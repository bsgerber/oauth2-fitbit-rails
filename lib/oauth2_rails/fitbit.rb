require 'oauth2_rails/base'
require 'oauth2_rails/client'
require 'oauth2_rails/user'
require 'oauth2_rails/fitbit/activities'

module Oauth2Rails
  class Fitbit < Client

    include Activities
    include Goals
    include HeartRate
    include Sleep

    ## => PROFILE
    # https://api.fitbit.com/1/user/-/profile.json
    def profile
      Profile.new(api_call('/1/user/-/profile.json').json_body)
    end

    def raw_profile
      api_call('/1/user/-/profile.json')
    end

    ## => BODY INFORMATION
    def body_weight(date)
      api_call("/1/user/-/body/log/weight/date/#{date}.json")
    end
    
  end
end
