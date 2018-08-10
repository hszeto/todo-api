module ExceptionHandler
  extend ActiveSupport::Concern

  # Custom error subclasses
  class InvalidToken < StandardError; end

  included do
    rescue_from StandardError do |e|
      json_response({ message: e.message }, :unprocessable_entity)
    end

    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({ message: e.message }, :unprocessable_entity)
    end

    rescue_from ExceptionHandler::InvalidToken do |e|
      json_response({ message: e.message }, :unprocessable_entity)
    end
  end
end
