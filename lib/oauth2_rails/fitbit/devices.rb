module Devices

  def devices
    api_call("/1/user/-/devices.json")
  end

 end