class Tickers::ImportMonthlyHistoryService
  # Alpha Vantage API から週次株価データを収集する
  # https://www.alphavantage.co/documentation/

  def self.run
    new.run
  end

  def initialize
    # @apikeys = ['T0WZY9EXEE0YAZT1', 'S3P88SPPELL9JCWK', 'VGYCJY3803TGGXTY', 'SJ1NU7PDJV8U3ZEQ']
    @apikeys = ['T0WZY9EXEE0YAZT1']
    @xtime = Time.now
    @scount = 0
    @rcount = 0
  end

  attr_accessor :apikeys, :xtime, :scount, :rcount

  module ALPHA
    META_DATA = 'Meta Data'
    WEEKLY_TIME_SERIES = 'Weekly Time Series'
    MONTHLY_TIME_SERIES = 'Monthly Time Series'

    INFO = '1. Information'
    SYMBOL = '2. Symbol'
    REFRESHED = '3. Last Refreshed'
    TIME_ZONE = '4. Time Zone'

    OPEN = "1. open"
    HIGH = "2. high"
    LOW = "3. low"
    CLOSE = "4. close"
    VOLUME = "5. volume"
  end

  def run
    start_time = Time.now

    Ticker.market_TokyoFirst.find_each{ |ticker|
      puts "ticker: #{ticker.symbol}, name: #{ticker.name}, market: #{ticker.market}, 経過時間: #{Time.now - start_time}"

      # すでに取り込み済みは next
      next if ticker.reflashed_at

      # APIからデータ取得
      res_json = request_to_alpha(ticker.symbol_with_region)

      # meta data がない場合は 削除してnext
      unless res_json[ALPHA::META_DATA]
        # binding.pry
        if res_json["Note"] =~ /5 calls per minute and 500 calls per day/
          puts "#{res_json["Note"]}"
          sleep_management
          @rcount += 1
          if rcount > 5
            puts "The limit of 500 calls"
            exit
          end
          redo
        else
          ticker.destroy
          puts "🍩 destroy => ticker: #{ticker.symbol}, name: #{ticker.name}"
          next
        end
      end

      puts "🎉 Data Found: #{res_json[ALPHA::META_DATA][ALPHA::SYMBOL]}"
      @rcount = 0

      # 最初にmonth_atを更新する（ないものがあれば、追加）
      monthly_keys(res_json).each{ |month_at|
        Month.find_or_create_by(month_at: Time.zone.parse(month_at))
      }

      # 次に、Month.find_eachで追加する
      Month.find_in_batches(batch_size: 100){ |months|

        histories = months.reject{|month|
          res_json[ALPHA::MONTHLY_TIME_SERIES][month.at_to_s].nil?
        }.map{ |month|
          month.tfstocks.new(
            open: res_json[ALPHA::MONTHLY_TIME_SERIES][month.at_to_s][ALPHA::OPEN],
            high: res_json[ALPHA::MONTHLY_TIME_SERIES][month.at_to_s][ALPHA::HIGH],
            low: res_json[ALPHA::MONTHLY_TIME_SERIES][month.at_to_s][ALPHA::LOW],
            close: res_json[ALPHA::MONTHLY_TIME_SERIES][month.at_to_s][ALPHA::CLOSE],
            volume: res_json[ALPHA::MONTHLY_TIME_SERIES][month.at_to_s][ALPHA::VOLUME],
            ticker: ticker
          )
        }

        Months::TfStock.import(histories)
      }

      # tickerのreflashed_at等を更新
      ticker.update( reflashed_at: res_json[ALPHA::META_DATA][ALPHA::REFRESHED] )
      puts "ticker.tfstocks.count: #{ticker.tfstocks.count}, Months::TfStock.count: #{Months::TfStock.count}"
    }

  end

  def monthly_keys(res_json)
    res_json[ALPHA::MONTHLY_TIME_SERIES].keys
  end

  def request_to_alpha(symbol_with_region)
    res = client.get(url, query(symbol_with_region))
    JSON.parse(res.body)
  end

  def query(symbol)
    {
      function: function,
      apikey: apikey,
      symbol: symbol
    }
  end
#https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=8230&apikey=T0WZY9EXEE0YAZT1
#https://www.alphavantage.co/query?function=TIME_SERIES_MONTHLY&symbol=8230.TOK&apikey=T0WZY9EXEE0YAZT1
#https://www.alphavantage.co/query?function=TIME_SERIES_MONTHLY&symbol=3194.TOK&apikey=VGYCJY3803TGGXTY

  def function
    'TIME_SERIES_MONTHLY'
  end

  # 'T0WZY9EXEE0YAZT1' #1 n350071@gmail.com
  # 'S3P88SPPELL9JCWK' #2 ishigaki0515naoki@gmail.com
  # 'VGYCJY3803TGGXTY' #3 ishigaki_naoki@yahoo.co.jp
  # 'SJ1NU7PDJV8U3ZEQ' #4 n350071_paper_white@kindle.com
  def apikey
    # sleep_management
    apikeys.push(apikeys.shift).last
  end

  # 5 API requests per minute; 500 API requests per day
  # ~~apikeyが１周したとき、前回から３分経過しないと再開できないようにする (24 * 60 / 500 = 2.88分)~~
  # ~~apikeyが５周したとき、前回から１分経過しないと再開できないようにする~~
  def sleep_management
    # return unless apikeys.last == 'T0WZY9EXEE0YAZT1'
    # puts "scount: #{scount}"
    # @scount += 1

    # return if scount < 5

    until Time.now - xtime > 60 #180
      sleep 1
      # puts "180秒まで休憩 : #{(Time.now - xtime).round}"
    end

    # @scount = 0
    @xtime = Time.now
  end


  def client
    @client ||= HTTPClient.new
  end

  def url
    'https://www.alphavantage.co/query'
  end

end

