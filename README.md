# Oauth2Rails

A gem that currently provides support for the Fitbit API using Oauth2 protocol.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'oauth2_rails'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install oauth2_rails

## Usage - Connecting your appto Fitbit

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

You are now ready to fetch data from Fitbit (see below)


## Contributing
One project I would be very interested in is extracting this to a more general framework, that works with most clients on rails. For example, I'm sure the Fitbit flow is a little different, so it would not work always with other providers.

1. Fork it ( https://github.com/[my-github-username]/oauth2_rails/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
