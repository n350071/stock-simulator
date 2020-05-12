json.id(@month_simulation.id)
json.set! :months do
  json.array!(@month_simulation.reports.first.performances) do |perf|
    json.month(perf.month.at_ym)
  end
end
json.set! :reports do
  json.array!(@month_simulation.reports) do |report|
    json.report_id(report.id)
    json.set! :performances do
      json.array!(report.performances) do |perf|
        json.total_asset(perf.total_asset)
      end
    end
  end
end


