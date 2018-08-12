class ApplicationController < ActionController::API
  include ExceptionHandler
  include JsonResponse
  include JwtDecoder

  before_action :set_user


  private

  def set_user
    decoded = jwt_decode( request.headers['Authorization'] )

    @current_user = User.create_with( email: decoded['email'],
                                      name:  decoded['email'].split('@')[0] )
                        .find_or_create_by!( uuid: decoded['sub'] )
  end
end
