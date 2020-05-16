class MonthSimulationsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]

  # GET /ticker_week_histories
  # GET /ticker_week_histories.json
  def index
    # Report.all.order(id: :desc).map(&:id)
    @month_simulations = MonthSimulation.all.order(id: :desc)
  end

  # GET /ticker_week_histories/1
  # GET /ticker_week_histories/1.json
  def show
    # @reports = @month_simulation.reports
  end

  def destroy
    @month_simulation.destroy
    respond_to do |format|
      format.html { redirect_to month_simulations_url, notice: 'MonthSimulation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @month_simulation = MonthSimulation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    # def report_params
    #   params.require(:report).permit(:open, :high, :low, :close, :volue, :week_at)
    # end
end