# This controller is for all the CRUD operations related to a Todo.

# Shows the form for adding a to do list
MyApp.get "/new_todo" do 
  erb :"todos/add"
end

# Processes the form for adding a to do list
MyApp.post "/todo_added" do 
  @todo = Todo.new
  @todo.title = params["title"]
  @todo.description = params["description"]
  @todo.completed = false
  @todo.user_id = params["user_id"]
  if @todo.is_valid == true
    @todo.save
    erb :"todos/added"
  else
    erb :"todos/add_error"
  end
end

# Shows all to do lists
MyApp.get "/all_todos" do 
  @todo_lists = Todo.all
  @todo_users = User.all
  erb :"todos/view_all"
end

# Shows one to do list NEED THIS?????
MyApp.get "/view_one/:num" do 
  @one_user = Todo.find_by_id(params[:num])

  erb :"todos/view_one"
end

# Processes deletion of a to do list (from view_all page)
MyApp.get "/delete_todo/:num" do
  @delete_todo = Todo.find_by_id(params[:num]) 
  @this_user_todo_lists = Todo.where({"user_id" => params[:num]})
  @this_user_todo_lists.delete_all
  @delete_todo.delete
  erb :"todos/delete"
end

#Shows form for updating a to do list
MyApp.get "/update_todo/:num" do 
  @todo_update = Todo.find_by_id(params[:num]) 
  erb :"todos/update"
end

#Processes the form for updating a to do list
MyApp.post "/updated_todo/:num" do 
  @update_todo = Todo.find_by_id(params[:num])
  @update_todo.title = params["title"]
  @update_todo.description = params["description"]
  @update_todo.user_id = params["user_id"]
  if @update_todo.is_valid == true
    @update_todo.save
    erb :"todos/updated"
  else
    erb :"todos/update_error"
  end
end

#GENERIC REQUESTS HAVE TO GO AT BOTTOM SO AS NOT TO GET CAUGHT ON /:NUM ETC.
