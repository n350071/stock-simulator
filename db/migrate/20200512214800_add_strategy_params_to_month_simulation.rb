class AddStrategyParamsToMonthSimulation < ActiveRecord::Migration[6.0]
  def change
    add_column :month_simulations, :strategy_params, :string
  end
end
