class MonthlySimulationService
  # 東証のCSVからTicker情報を収取する
  # https://www.jpx.co.jp/markets/statistics-equities/misc/01.html
  # 東証上場銘柄一覧（２０２０年３月末）

  def self.run
    new.run
  end

  def initialize

  end

  def run
    MonthSimulation.eager_load(:reports).where(reports: {id: nil}).find_each{ |ms|
      ms.run
    }
  end

end

