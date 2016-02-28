# This controller is for all the CRUD operations related to a Todo.

# Shows the form for adding a to do list
MyApp.get "/new_todo" do 
  @current_user = User.find_by_id(session["user_id"])
  if session["user_id"] != nil
    @users = User.all
    @categories = Todo.all 
    erb :"todos/add"
  else
    erb :"please_login"
  end
end

# Processes the form for adding a to do list
MyApp.post "/todo_added" do 
  @current_user = User.find_by_id(session["user_id"])
  if session["user_id"] != nil
    @todo = Todo.new
    @todo.title = params["title"]
    @todo.description = params["description"]
    @todo.completed = false
    @todo.user_id = params["user_id"]
  else
    erb :"please_login"
  end
  
  if @todo.is_valid == true
    @todo.save
    erb :"todos/added"
  else
    erb :"todos/add_error"
  end
end

# Shows all to do lists
MyApp.get "/all_todos" do 
  @current_user = User.find_by_id(session["user_id"])
  if session["user_id"] != nil
    @todo_lists = Todo.all
    erb :"todos/view_all"
  else
    erb :"please_login"
  end
end

# Shows one to do list
MyApp.get "/view_todo/:num" do 
  @current_user = User.find_by_id(session["user_id"])
  if session["user_id"] != nil
    @one_todo = Todo.find_by_id(params[:num])
    erb :"todos/view_one"
  else
    erb :"please_login"
  end   
end

# Processes deletion of a to do list (from view_all page)
MyApp.post "/delete_todo/:num" do
  @current_user = User.find_by_id(session["user_id"])
  if session["user_id"] != nil
    @delete_todo = Todo.find_by_id(params[:num]) 
    @this_user_todo_lists = Todo.where({"user_id" => params[:num]})
    @this_user_todo_lists.delete_all 
    @delete_todo.delete
    erb :"todos/delete"
  else
    erb :"please_login"
  end
end

#Shows form for updating a to do list
MyApp.get "/update_todo/:num" do 
    @todo_update = Todo.find_by_id(params[:num]) 
    erb :"todos/update"
end

#Processes the form for updating a to do list
MyApp.post "/updated_todo/:num" do 
  @current_user = User.find_by_id(session["user_id"])
  if session["user_id"] != nil
    @update_todo = Todo.find_by_id(params[:num])
    @update_todo.title = params["title"]
    @update_todo.description = params["description"]
    @update_todo.user_id = params["user_id"]
  else
    erb :"please_login"
  end
  
  if @update_todo.is_valid == true
    @update_todo.save
    erb :"todos/updated"
  else
    erb :"todos/update_error"
  end
end

#GENERIC REQUESTS HAVE TO GO AT BOTTOM SO AS NOT TO GET CAUGHT ON /:NUM ETC.
