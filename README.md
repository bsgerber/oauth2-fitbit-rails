# Oauth2Rails

A gem that currently provides support for the Fitbit API using Oauth2 protocol.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'oauth2_rails'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install oauth2_rails

## Usage - Connecting your app to Fitbit

Create a config/initializers/fitbit.rb file, which should contain your Fitbit application oAuth2 Client ID, consumer secret key, callback url, etc:

```
if Rails.env.development?
  FOO::Application.config.fitbit_consumer_key = 'myconsumerkey'
  FOO::Application.config.fitbit_consumer_secret = 'myconsumersecret'
  Oauth2Rails::Base::OAUTH2_RAILS_ID = "123ABC"
  Oauth2Rails::Base::OAUTH2_RAILS_SECRET = FOO::Application.config.fitbit_consumer_secret
  Oauth2Rails::Base::OAUTH2_RAILS_CALLBACK = "http://www.lacolhost.com:3000/auth/fitbit_oauth2/callback"
elsif Rails.env.staging?
...
```

Your user model should have fields to hold the fitbit user ID, access and refresh tokens.  These need to be named (or alised) to access_token, refresh_token and expiry.  

```
  alias_attribute :access_token, :fitbit_oauth2_access_token
  alias_attribute :refresh_token, :fitbit_oauth2_refresh_token
  alias_attribute :expiry, :fitbit_oauth2_expiry

```

On a 'Connect to Fitbit' event, call Oauth2Rails::Auth.new with the scopes you want:

```
redirect_to Oauth2Rails::Auth.new(:scope=>'activity profile').authorize_url
```

If successful, Fitbit will redirect to your OAUTH2_RAILS_CALLBACK path.  In that code, retrieve the Fitbit token, and save off the fitbit user ID, access token, refresh token, and token expiry:

```
user_token = Oauth2Rails::Auth.new.get_token(params[:code])
current_user.update_attributes(
  :fitbit_user_id=>user_token.id,
  :fitbit_oauth2_access_token=>user_token.access_token,
  :fitbit_oauth2_refresh_token=>user_token.refresh_token,
  :fitbit_oauth2_expiry=>DateTime.now + (user_token.expires_every.to_i - 20).seconds)
```

You are now ready to fetch data from Fitbit (see below).

### Refreshing the token

When the token expiry passes (every hour) you need to refresh it before attempting another API call.  If you dont change the scopes, this can be transparent to the end user.  

```
if current_user.fitbit_oauth2_expiry < Time.now
  client = Oauth2Rails::Fitbit.new(current_user,{})
  refresh_response = client.refresh(current_user.refresh_token)
end

```

## Fetchables and Settables

To call the Fitbit API, you first need to get the Fitbit client

```
client = Oauth2Rails::Fitbit.new(current_user,{})
```

Once you have the client, you can call methods on it

```
response = client.activities_on_date("2015-12-21")
```

response.body will contain the data from the server:

```
{"activities":[],"goals":{"activeMinutes":30,"caloriesOut":2596,"distance":8.05,"floors":10,"steps":10000},"summary":{"activeScore":-1,"activityCalories":34,"caloriesBMR":1598,"caloriesOut":1626,"distances":[{"activity":"total","distance":0.15},{"activity":"tracker","distance":0.15},{"activity":"loggedActivities","distance":0},{"activity":"veryActive","distance":0},{"activity":"moderatelyActive","distance":0},{"activity":"lightlyActive","distance":0.15},{"activity":"sedentaryActive","distance":0}],"elevation":0,"fairlyActiveMinutes":0,"floors":0,"lightlyActiveMinutes":6,"marginalCalories":22,"sedentaryMinutes":1434,"steps":208,"veryActiveMinutes":0}}
```

### Getting data:

@wip - See fitbit.rb, and fitbit/*.rb files for details

### Setting data:

@wip - See fitbit/subscriptions.rb

## Work to do

* Add complete set of Fitbit API calls
* Divorce user model from oAuth client.  Use external model only.  Allow setting of token/expiry parameter names.
* Tests, tests, tests!

## Contributing
One project I would be very interested in is extracting this to a more general framework, that works with most clients on rails. For example, I'm sure the Fitbit flow is a little different, so it would not work always with other providers.

1. Fork it ( https://github.com/[my-github-username]/oauth2_rails/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
