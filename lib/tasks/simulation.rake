namespace :simulation do
  desc 'シミュレーション'

  # bin/rails simulation:month
  task month: :environment do
    MonthlySimulationService.run
  end

end

