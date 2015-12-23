module Activities

  def recent_activites
    api_call("/1/user/-/activities/recent.json")
  end
  
  def activities_on_date(date)
    api_call("/1/user/-/activities/date/#{date}.json")
  end    

  def activities
    api_call("/activities.json")
  end

  def activity_on_date_range(activity, start, finish)
    api_call("/1/user/-/activities/#{activity}/date/start/finish.json")
  end

  def frequent_activities
    api_call("/1/user/-/activities/frequent.json")
  end

  def favorite_activities
    api_call("/1/user/-/activities/favorite.json")
  end

  def activity(id)
    api_call("/activities/#{id}.json")
  end

  def activity_statistics
    api_call("/1/user/-/activities.json")
  end

end
