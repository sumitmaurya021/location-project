if Doorkeeper::Application.count.zero?
  Doorkeeper::Application.create(name: "Location", redirect_uri: "", scopes: "")
end

if User.count.zero?
  User.create(email: "admin@gmail.com", password: "123456", password_confirmation: "123456")
end
