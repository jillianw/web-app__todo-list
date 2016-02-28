# This controller is for all the CRUD operations related to a User.

# Shows the form for adding a user
MyApp.get "/new_user" do 
  erb :"users/add"
end

# Processes the form for adding a user
MyApp.post "/user_added" do 
  @user = User.new
  @user.name = params["name"]
  @user.email = params["email"]
  @user.password = params["password"]
  if @user.is_valid == true
    @user.save
    redirect "/view_user/#{@user.id}"
  else
    # return error message
    erb :"users/add"
  end
end

# Shows all users added
MyApp.get "/all_users" do 
  @current_user = User.find_by_id(session["user_id"])
  if session["user_id"] != nil
    @all_users = User.all 
    erb :"users/view_all"
  else
    erb :"please_login"
  end
end

# Shows one user
MyApp.get "/view_user/:num" do 
  @current_user = User.find_by_id(session["user_id"])
  if session["user_id"] != nil
    @one_user = User.find_by_id(params[:num])
    erb :"users/view_one" 
  else
    erb :"please_login"
  end
end

# Processes deletion of a user (from view_all page)
MyApp.post "/delete_user/:num" do
  @current_user = User.find_by_id(session["user_id"])
  if session["user_id"] != nil
    @delete_user = User.find_by_id(params[:num]) 
    @this_user_todo_lists = Todo.where({"user_id" => params[:num]})
    @this_user_todo_lists.delete_all
    @delete_user.delete
    erb :"users/delete"
  else
    erb :"please_login"
  end  
end

#Shows form for updating a user
MyApp.get "/update_user/:num" do 
  @current_user = User.find_by_id(session["user_id"])
  if session["user_id"] != nil
    @user_update = User.find_by_id(params[:num]) 
    erb :"users/update"
  else
    erb :"please_login"
  end  
end

#Processes the form for updating a user
MyApp.post "/updated_user/:num" do 
  @current_user = User.find_by_id(session["user_id"])
  if session["user_id"] != nil
    @update_user = User.find_by_id(params[:num])
    @update_user.name = params["name"]
    @update_user.email = params["email"]
    @update_user.password = params["password"]
  else
    erb :"please_login"
  end  

  if @update_user.is_valid == true
    @update_user.save
    erb :"users/updated"
  else
    erb :"users/update_error"
  end
end
