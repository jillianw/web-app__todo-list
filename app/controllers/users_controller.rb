# This controller is for all the CRUD operations related to a User.

# Shows the form for adding a user
MyApp.get "/new_user" do 
  @add_user = User.all 
  erb :"users/new"
end

# Processes the form for adding a user
MyApp.post "/add_user" do 
  @user = User.new
  @user.name = params["name"]
  if @user.is_valid == true
    @user.save
    erb :"users/add"
  else
    erb :"users/error"
  end
end

# Shows all users added
MyApp.get "/all_users" do 
  @all_users = User.all 

  erb :"users/view_all"
end

# Processes deletion of a user
MyApp.post "/delete_user/:b" do
  @delete_user = User.find_by_id(params[:b]) 
  @this_user_todo_lists = Todo.where({"user_id" => params[:b]})
  @this_user_todo_lists.delete_all
  @delete_user.delete

  erb :"users/delete"
end

# Updating......

MyApp.post "/update_user" do
  @update_user = User.all 

  erb :"users/update"
end

