module JwtDecoder
  extend ActiveSupport::Concern

  def jwt_decode jwt
    begin
      kid = JSON.parse( Base64.decode64(jwt.split('.')[0]) )['kid']

      jwk = jwk_set[:keys].detect{ |key| key[:kid] == kid }

      jwk = JSON::JWK.new jwk

      JSON::JWT.decode jwt, jwk

    rescue => e
      raise ExceptionHandler::InvalidToken, e.message
    end
  end


  private

  def jwk_set
    # obtained from https://cognito-idp.us-west-2.amazonaws.com/us-west-2_CU8GarjcW/.well-known/jwks.json
    # for Cognito AskOutAuth
    {
      "keys": [
        {
          "alg": "RS256",
          "e": "AQAB",
          "kid": "vEkigJpDLmJzJz/8y3cUN83sZ6cfiJFOrS+zb9hCUyI=",
          "kty": "RSA",
          "n": "lZ3L-Hxd6ctb7IG0SQJBT2ocDlXsTgZ9KUl5KmzH6m2T3j789YYgdPpEuuQggnOlcNvnH9Riq88xIHGDgVX_ibxZmxRJuq_R_1YbqU6PJkj_X0qjEfWRvuDwtCiFT9OzJQ5xFVx0fdzhNXHHSxW5dxSTZQKVvH1Fx-2tH1w4n-74OzdQQgAmYrWgn9hS928nLYhywO2d06b1nWJMWB1xdWqZjw0GHRszvfAwP7iv-tHKsbWoGoK9xy0WbMaYBw9rJOWr7w-896b9I2vBPCnjvbYQvLtOZR9-5grnuSdHek4IE0W_UarXSl2I8OxhTyFBHwJpljBOrPHkMSwQ4J3Wfw",
          "use": "sig"
        },
        {
          "alg": "RS256",
          "e": "AQAB",
          "kid": "mguch0RxvIYstUQjyFrTZoTOSOm6hyP6F6Y+aK+iHhw=",
          "kty": "RSA",
          "n": "l4Y-n03u3wRZcfx1eJJ4wMwX1DfXhBEXnKaGLatgICjrGWocPrzBfw_U2e0TUzfCgzmmOtcqvUPmNoY0DwAYktzfdIlCzWC8Xi0Pce3q8fyZGA63Bs5ta0xkujtKazn7oGDC5tIXDrgC0FlpsHIGgJYgkH092Jn-Cc8Q8zUw1b1yD_WT2mwKRss-qiYW-VxX8CsZ7FhpHzTw3giW35-LorQky4PKlnqF6GR3WcC8Z3ARbDbh55vTiiAR5fqO4ZUn1uv9AEnUMvo5wPi0GQpVNfTIvQUea8RBZdnb6x7R1hH6CxV6oUbk_rlIiXDyUPYax8YNtm4PJ0PFlOjkGkt1sw",
          "use": "sig"
        }
      ]
    }
  end
end
