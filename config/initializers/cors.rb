Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'todo-react16-app.herokuapp.com', 'localhost:3000'

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
