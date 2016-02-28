# This controller is for all the CRUD operations related to a Todo.

# Shows the form for adding a to do list
MyApp.get "/todos/new" do 
  @current_user = User.find_by_id(session["user_id"])
  if session["user_id"] != nil
    @user = User.all
    @categories = Category.all 
    erb :"todos/new"
  else
    erb :"please_login"
  end
end

# Processes the form for adding a to do list
MyApp.post "/todos/create" do 
  @current_user = User.find_by_id(session["user_id"])
  if session["user_id"] != nil
    @todo = Todo.new
    @todo.title = params["title"]
    @todo.description = params["description"]
    @todo.completed = false
    @todo.user_id = params["user_id"]
    @todo.category_id = params["category_id"]
  else
    erb :"please_login"
  end
  
  if @todo.is_valid == true
    @todo.save
    redirect "/todos/#{@todo.id}"
  else
    # return error message
    erb :"todos/new"
  end
end


# Shows all to do lists
MyApp.get "/todos" do 
  @current_user = User.find_by_id(session["user_id"])
  if session["user_id"] != nil
    @todos = Todo.all
    @todo_categories = Category.all 
    erb :"todos/index"
  else
    erb :"please_login"
  end
end

# Shows one to do list
MyApp.get "/todos/:id" do 
  @current_user = User.find_by_id(session["user_id"])
  if session["user_id"] != nil
    @todo = Todo.find_by_id(params[:id])
    erb :"todos/show"
  else
    erb :"please_login"
  end   
end

# Processes deletion of a to do list (from index page)
MyApp.post "/todos/:id/delete" do
  @current_user = User.find_by_id(session["user_id"])
  if session["user_id"] != nil
    @todo = Todo.find_by_id(params[:id]) 
    @this_user_todo_lists = Todo.where({"user_id" => params[:id]})
    @this_user_todo_lists.delete_all 
    @todo.delete
    erb :"todos/delete"
  else
    erb :"please_login"
  end
end

#Shows form for updating a to do list
MyApp.get "/todos/:id/edit" do 
  @current_user = User.find_by_id(session["user_id"])
  if session["user_id"] != nil
    @todo = Todo.find_by_id(params[:id]) 
    @todo_owner = User.all
    @todo_category_update = Category.all 
    erb :"todos/edit"
  else
    erb :"please_login"
  end
end

#Processes the form for updating a to do list
MyApp.post "/todos/:id/update" do 
  @current_user = User.find_by_id(session["user_id"])
  if session["user_id"] != nil
    @todo = Todo.find_by_id(params[:id])
    @todo.title = params["title"]
    @todo.description = params["description"]
    @todo.user_id = params["user_id"]
    @todo.category_id = params["category_id"]
  else
    erb :"please_login"
  end
  
  if @todo.is_valid == true
    @todo.save
    erb :"todos/updated"
  else
    erb :"todos/update_error"
  end
end

#GENERIC REQUESTS HAVE TO GO AT BOTTOM SO AS NOT TO GET CAUGHT ON /:id ETC.
