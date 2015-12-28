module Subscriptions

  SUBSCRIBABLE_TYPES = [:sleep, :body, :activities, :foods, :all]

  # list notification subscriptions
  def get_subscriptions(options)
    api_call(make_subscription_url(options))
  end

  # create a notification subscription
  def create_subscription(options)
    api_post(make_subscription_url(options.merge({:use_subscription_id => true})))
  end

  # remove a notification subscription
  def remove_subscription(options)
    api_delete(make_subscription_url(options.merge({:use_subscription_id => true})))
  end

  protected

  def validate_subscription_types(subscription_type)
    unless subscription_type && SUBSCRIBABLE_TYPES.include?(subscription_type)
      raise "Invalid subscription type (valid values are #{SUBSCRIBABLE_TYPES.join(', ')})"
    end
    true
  end

  def make_subscription_url(options)
    validate_subscription_types(options[:type])
    path = if options[:type] == :all
      ""
    else
      "/"+options[:type].to_s
    end
    url = "/1/user/-#{path}/apiSubscriptions"
    if options[:use_subscription_id]
      unless options[:subscription_id]
        raise "Must include options[:subscription_id]"
      end
      url += "/#{options[:subscription_id]}"
    end
    url += ".json"
  end

end