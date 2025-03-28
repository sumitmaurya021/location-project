Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end

  namespace :api do
    namespace :v1 do
      resources :users do
        collection do
          post "login"
        end
      end
      resources :locations
      resources :enquiries
    end
  end
end
