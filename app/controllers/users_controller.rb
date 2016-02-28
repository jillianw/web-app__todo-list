# This controller is for all the CRUD operations related to a User.

# Shows the form for adding a user
MyApp.get "/users/new" do 
  erb :"users/new"
end

# Processes the form for adding a user
MyApp.post "/users/create" do 
  @user = User.new
  @user.name = params["name"]
  @user.email = params["email"]
  @user.password = params["password"]
  if @user.is_valid == true
    @user.save
    redirect "/users/#{@user.id}"
  else
    # return error message
    erb :"users/new"
  end
end

# Shows all users added
MyApp.get "/users" do 
  @current_user = User.find_by_id(session["user_id"])
  if session["user_id"] != nil
    @users = User.all 
    erb :"users/index"
  else
    erb :"please_login"
  end
end

# Shows one user
MyApp.get "/users/:id" do 
  @current_user = User.find_by_id(session["user_id"])
  if session["user_id"] != nil
    @user = User.find_by_id(params[:id])
    erb :"users/show" 
  else
    erb :"please_login"
  end
end

# Processes deletion of a user (from index page)
MyApp.post "/users/:id/delete" do
  @current_user = User.find_by_id(session["user_id"])
  if session["user_id"] != nil
    @user = User.find_by_id(params[:id]) 
    @this_user_todo_lists = Todo.where({"user_id" => params[:id]})
    @this_user_todo_lists.delete_all
    @user.delete
    erb :"users/delete"
  else
    erb :"please_login"
  end  
end

#Shows form for updating a user
MyApp.get "/users/:id/edit" do 
  @current_user = User.find_by_id(session["user_id"])
  if session["user_id"] != nil
    @user = User.find_by_id(params[:id]) 
    erb :"users/edit"
  else
    erb :"please_login"
  end  
end

#Processes the form for updating a user
MyApp.post "/users/:id/update" do 
  @current_user = User.find_by_id(session["user_id"])
  if session["user_id"] != nil
    @user = User.find_by_id(params[:id])
    @user.name = params["name"]
    @user.email = params["email"]
    @user.password = params["password"]
  else
    erb :"please_login"
  end  

  if @user.is_valid == true
    @user.save
    erb :"users/updated"
  else
    erb :"users/update_error"
  end
end
