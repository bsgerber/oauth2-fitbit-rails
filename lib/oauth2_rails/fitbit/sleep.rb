module Sleep

  def sleep(date)
    api_call("/1/user/-/sleep/date/#{date}.json")
  end

  def time_asleep(start_date, end_date)
    api_call("/1/user/-/sleep/minutesAsleep/date/#{start_date}/#{end_date}.json")
  end

  def sleep_start(start_date, end_date)
    api_call("/1/user/-/sleep/startTime/date/#{start_date}/#{end_date}.json")
  end

  def sleep_efficiency(start_date, end_date)
    api_call("/1/user/-/sleep/efficiency/date/#{start_date}/#{end_date}.json")
  end

  def sleep_total_time(start_date, end_date)
    api_call("/1/user/-/sleep/minutesAsleep/date/#{start_date}/#{end_date}.json")
  end
  
end