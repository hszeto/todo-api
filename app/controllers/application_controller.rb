class ApplicationController < ActionController::API
  include JsonResponse
  include ExceptionHandler
  include JwtDecoder

  before_action :set_user


  private

  def set_user
    token = request.headers['Authorization']

    raise 'Token required' if token.nil?

    decoded = jwt_decode(token)

    @current_user = User.create_with( email: decoded['email'],
                                      name:  decoded['email'].split('@')[0] )
                        .find_or_create_by!( uuid: decoded['sub'] )
  end
end
