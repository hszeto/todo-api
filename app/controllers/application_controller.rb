class ApplicationController < ActionController::API
  include JsonResponse
  include ExceptionHandler
  include JwtDecoder

  before_action :set_user


  private

  def find_or_create(decoded)
    user = User.find_by(uuid: decoded['sub'])

    if user.nil?
      user = User.create!( email: decoded['email'],
        name: decoded['email'].split('@')[0],
        uuid: decoded['sub'] )
    end

    user
  end

  def set_user
    token = request.headers['Authorization']

    raise 'Token required' if token.nil?

    @current_user = find_or_create( jwt_decode(token) )
  end
end
