# This controller is for all the CRUD operations related to a Login.

# Note that "logins" are not stored in the database. But there is still
# a reasonable way to think about a "login" as a resource which is created
# and deleted (i.e. 'logging out').
# 
# Reading and Updating a login, however, make a little less sense.

# Shows the form for a user to create a new login session
MyApp.post "/logins/delete" do
  session["user_id"] = nil
  erb :"logins/deleted"
end

MyApp.get "/logins/new" do
  erb :"logins/new"
end

# Processes the form that creates a new login session for a user
MyApp.post "/logins/create" do
  @user = User.find_by_email(params["email"])
  if @user.password == params["password"]
    session["user_id"] = @user.id
     erb :"logins/success"
  else
    erb :"logins/failed"
  end
end 