# Shows homepage

MyApp.get "/" do
  erb :"home"
end

# Shows admin page

MyApp.get "/admin" do
  @current_user = User.find_by_id(session["user_id"])
  
  if session["user_id"] != nil
    erb :"users/admin"
  else
    erb :"please_login"
  end
end