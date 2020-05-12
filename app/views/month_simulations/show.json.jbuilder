@reports.each do |report|
  json.id(report.id)
  json.set! :performances do
    json.array!(report.performances) do |perf|
      json.month(perf.month.at_ym)
      json.total_asset(perf.total_asset)
    end
  end
end
