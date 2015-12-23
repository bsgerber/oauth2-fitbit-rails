module Goals

  def goals
    api_call("/1/user/-/activities/goals/daily.json")
  end

  def weekly_goals
    api_call("/1/user/-/activities/goals/weekly.json")
  end
  
end
