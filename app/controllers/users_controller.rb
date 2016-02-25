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
    erb :"users/added"
  else
    erb :"users/add_error"
  end
end

# Shows all users added
MyApp.get "/all_users" do 
  @all_users = User.all 
  erb :"users/view_all"
end

# Shows one user
MyApp.get "/view_one/:num" do 
  @one_user = User.find_by_id(params[:num])

  erb :"users/view_one"
end

# Processes deletion of a user (from view_all page)
MyApp.get "/delete_user/:num" do
  @delete_user = User.find_by_id(params[:num]) 
  @this_user_todo_lists = Todo.where({"user_id" => params[:num]})
  @this_user_todo_lists.delete_all
  @delete_user.delete
  erb :"users/delete"
end

#Shows form for updating a user
MyApp.get "/update_user/:num" do 
  @user_update = User.find_by_id(params[:num]) 
  erb :"users/update"
end

#Processes the form for updating a user
MyApp.post "/updated_user/:num" do 
  @update_user = User.find_by_id(params[:num])
  @update_user.name = params["name"]
  @update_user.email = params["email"]
  @update_user.password = params["password"]
  if @update_user.is_valid == true
    @update_user.save
    erb :"users/updated"
  else
    erb :"users/update_error"
  end
end
