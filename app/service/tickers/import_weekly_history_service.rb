class Tickers::ImportWeeklyHistoryService
  # Alpha Vantage API から週次株価データを収集する
  # https://www.alphavantage.co/documentation/

  def self.run
    new.run
  end

  def initialize
    @apikeys = ['T0WZY9EXEE0YAZT1', 'S3P88SPPELL9JCWK', 'VGYCJY3803TGGXTY', 'SJ1NU7PDJV8U3ZEQ']
    @xtime = Time.now
  end

  attr_accessor :apikeys, :xtime

  def run
    start_time = Time.now

    Ticker.find_each{ |ticker|
      puts "経過時間: #{Time.now - start_time}"
      puts "ticker: #{ticker.symbol}, name: #{ticker.name_ja}, market: #{ticker.market}"

      # alphaにないことがわかっている場合は next
      next if ticker.on_alph == false

      # すでに取り込み済みは next
      # ticker.ticker_week_histories.first.week_at <= Date.today
      next if ticker.last_reflashed_at

      # APIからデータ取得
      res_json = request_to_alpha(ticker.symbol_with_region)

      # meta data がない場合は next
      unless res_json[Ticker::ALPHA::META_DATA]
        ticker.update(on_alph: false)
        next
      end
      puts "Meta data: #{res_json[Ticker::ALPHA::META_DATA][Ticker::ALPHA::META::SYMBOL]}"

      # 最初にweek_atを更新する（ないものがあれば、追加）
      weekly_keys(res_json).each{ |week_at|
        Week.find_or_create_by(week_at: Time.zone.parse(week_at))
      }

      # 次に、Week.find_eachで追加する
      Week.find_each{ |week|
        next unless res_json[Ticker::ALPHA::WEEKLY_TIME_SERIES][week.at_to_s]
        puts "#{week.at_to_s}"

        ticker.ticker_week_histories.create(
          week: week,
          open: res_json[Ticker::ALPHA::WEEKLY_TIME_SERIES][week.at_to_s][Ticker::ALPHA::WEEKLY::OPEN],
          high: res_json[Ticker::ALPHA::WEEKLY_TIME_SERIES][week.at_to_s][Ticker::ALPHA::WEEKLY::HIGH],
          low: res_json[Ticker::ALPHA::WEEKLY_TIME_SERIES][week.at_to_s][Ticker::ALPHA::WEEKLY::LOW],
          close: res_json[Ticker::ALPHA::WEEKLY_TIME_SERIES][week.at_to_s][Ticker::ALPHA::WEEKLY::CLOSE],
          volume: res_json[Ticker::ALPHA::WEEKLY_TIME_SERIES][week.at_to_s][Ticker::ALPHA::WEEKLY::VOLUME]
        )
      }
      puts "ticker.ticker_week_histories.count: #{ticker.ticker_week_histories.count}"

      # tickerのlast_reflashed_at等を更新
      ticker.update(
        last_reflashed_at: res_json[Ticker::ALPHA::META_DATA][Ticker::ALPHA::META::REFRESHED]
      )

    }

  end

  def weekly_keys(res_json)
    res_json[Ticker::ALPHA::WEEKLY_TIME_SERIES].keys
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
#https://www.alphavantage.co/query?function=TIME_SERIES_WEEKLY&symbol=1321.TOK&apikey=T0WZY9EXEE0YAZT1
#https://www.alphavantage.co/query?function=TIME_SERIES_WEEKLY&symbol=IBM&apikey=demo
#https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=1321&apikey=T0WZY9EXEE0YAZT1
#https://www.alphavantage.co/query?function=TIME_SERIES_MONTHLY&symbol=1929.TOK&apikey=T0WZY9EXEE0YAZT1
  def function
    'TIME_SERIES_WEEKLY'
  end

  # 'T0WZY9EXEE0YAZT1' #1 n350071@gmail.com
  # 'S3P88SPPELL9JCWK' #2 ishigaki0515naoki@gmail.com
  # 'VGYCJY3803TGGXTY' #3 ishigaki_naoki@yahoo.co.jp
  # 'SJ1NU7PDJV8U3ZEQ' #4 n350071_paper_white@kindle.com
  def apikey
    sleep_management
    apikeys.push(apikeys.shift).last
  end

  # 5 API requests per minute; 500 API requests per day
  # apikeyが１周したとき、前回から３分経過しないと再開できないようにする (24 * 60 / 500 = 2.88分)
  def sleep_management
    if apikeys.last == 'SJ1NU7PDJV8U3ZEQ'
      until Time.now - xtime > 180
        sleep 1
        puts "180秒まで休憩 : #{(Time.now - xtime).round}"
      end
      @xtime = Time.now
    end
  end


  def client
    @client ||= HTTPClient.new
  end

  def url
    'https://www.alphavantage.co/query'
  end



end

