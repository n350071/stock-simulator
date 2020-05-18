# TOPIXの積立て（上場インデックスファンド）
class Strategies::TopixReserve
  attr_accessor :report

  def initialize(report: nil, strategy_params: nil)
    return if report.nil?
    # return if strategy_params.nil?

    @report = report
    # set_params(strategy_params)
  end

  # 売らずに積み立てる
  def run
    report.charge(10_000)
    reserve
    report.reload.reserve_settle
  end

  # 毎月、一定額、ある商品を買う（累積口数を増やす）
  def reserve
    target_etf = Months::Etfn.where(ticker_id: 37, month: report.month).first
    return if target_etf.nil?

    report.reserve(target_etf, report.cash)

  end


  # def set_params(strategy_params)
  #   params = eval(strategy_params)
  #   @up_per = params[:up_per]
  #   @down_per = params[:down_per]
  #   @loss_per = params[:loss_per]
  #   @n_month = params[:n_month]
  # end
end

