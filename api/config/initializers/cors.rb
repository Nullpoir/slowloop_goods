Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins ENV.fetch('API_CORS_ALLOW_ORIGIN', 'localhost:3001')

    resource '*',
             headers: :any,
             expose: ['client', 'uid', 'access-token'],
             methods: %i[get post put patch delete options head]
  end
end
