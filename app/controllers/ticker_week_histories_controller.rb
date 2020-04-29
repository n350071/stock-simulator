class TickerWeekHistoriesController < ApplicationController
  before_action :set_ticker_week_history, only: [:show, :edit, :update, :destroy]

  # GET /ticker_week_histories
  # GET /ticker_week_histories.json
  def index
    @ticker_week_histories = TickerWeekHistory.all
  end

  # GET /ticker_week_histories/1
  # GET /ticker_week_histories/1.json
  def show
  end

  # GET /ticker_week_histories/new
  def new
    @ticker_week_history = TickerWeekHistory.new
  end

  # GET /ticker_week_histories/1/edit
  def edit
  end

  # POST /ticker_week_histories
  # POST /ticker_week_histories.json
  def create
    @ticker_week_history = TickerWeekHistory.new(ticker_week_history_params)

    respond_to do |format|
      if @ticker_week_history.save
        format.html { redirect_to @ticker_week_history, notice: 'Ticker week history was successfully created.' }
        format.json { render :show, status: :created, location: @ticker_week_history }
      else
        format.html { render :new }
        format.json { render json: @ticker_week_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ticker_week_histories/1
  # PATCH/PUT /ticker_week_histories/1.json
  def update
    respond_to do |format|
      if @ticker_week_history.update(ticker_week_history_params)
        format.html { redirect_to @ticker_week_history, notice: 'Ticker week history was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticker_week_history }
      else
        format.html { render :edit }
        format.json { render json: @ticker_week_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ticker_week_histories/1
  # DELETE /ticker_week_histories/1.json
  def destroy
    @ticker_week_history.destroy
    respond_to do |format|
      format.html { redirect_to ticker_week_histories_url, notice: 'Ticker week history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticker_week_history
      @ticker_week_history = TickerWeekHistory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ticker_week_history_params
      params.require(:ticker_week_history).permit(:open, :high, :low, :close, :volue, :week_at)
    end
end
