module HeartRate

  def daily_heart(start_date)
    api_call("/1/user/-/activities/heart/date/#{start_date}/1d.json")
  end

  def minute_heart(days, seconds, start_date, start_time, end_time)
    api_call("/1/user/-/activities/heart/date/#{start_date}/#{days}d/#{seconds}sec/time/#{start_time}/#{end_time}.json")
  end

end