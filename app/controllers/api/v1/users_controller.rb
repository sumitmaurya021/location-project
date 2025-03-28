module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :doorkeeper_authorize!, only: %i[login]

      def login
        user = User.find_by(email: params[:email])

        if user.nil?
          render json: { error: "Invalid Email" }, status: :unauthorized
        elsif user.valid_password?(params[:password])
          client_app = Doorkeeper::Application.find_by(uid: params[:client_id])
          if client_app
            access_token = create_access_token(user, client_app)
            render_login_response(user, access_token, "Login successful")
          else
            render json: { error: "Invalid client ID" }, status: :forbidden
          end
        else
          render json: { error: "Invalid Password" }, status: :unauthorized
        end
      end

      private

      def generate_refresh_token
        loop do
          token = SecureRandom.hex(32)
          break token unless Doorkeeper::AccessToken.exists?(refresh_token: token)
        end
      end

      def create_access_token(user, client_app)
        Doorkeeper::AccessToken.create!(
          resource_owner_id: user.id,
          application_id: client_app.id,
          refresh_token: generate_refresh_token,
          expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
          scopes: ""
        )
      end

      def render_login_response(user, access_token, message)
        user_data = {
          id: user.id,
          email: user.email,
          role: user.role,
          created_at: access_token.created_at.to_time.to_i,
          access_token: access_token.token
        }
        render json: { user: user_data, message: message }, status: :ok
      end
    end
  end
end
