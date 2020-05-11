# 月がふたつ以上あるMonthを探して、それに紐づくtfstocksを、ひも付きが最も多いMonthに付け替える

(2000..2020).each { |y|
  (1..12).each{|m|
    ymcount = Month.by_ym(y,m).count
    if ymcount <= 1
      next
    else
      months = Month.by_ym(y,m)
      ms_map = months.map{|m|  m.tfstocks.count }
      target_month = months[ms_map.index(ms_map.max)]

      months.each{ |m|
        next if m == target_month

        m.tfstocks.each{|tf|
          tf.update(month: target_month)
        }
      }
    end
  }
}


yms = []
(2000..2020).each { |y|
  (1..12).each{|m|
    ymcount = Month.by_ym(y,m).count
    if ymcount <= 1
      next
    else
      yms << {year: y, month: m, ymcount: ymcount}

      puts "#{y} / #{m} => #{ymcount}, target_month.tfstocks.count: #{target_month.tfstocks.count}"
    end
  }
}

yms.each{|ym|
  Month.by_ym(ym[:year], ym[:month]).each{|month|
    if month.tfstocks.empty?
      month.destroy
    end
  }
}
