OmniAuth::Strategies::Facebook

Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, ENV['FACEBOOK_APP_KEY'], ENV['FACEBOOK_APP_SECRET']
    # scope: 'email, first_name, last_name', display: 'popup'
end