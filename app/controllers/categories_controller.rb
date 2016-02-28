# This controller is for all the CRUD operations related to Categories.

# Shows the form for adding a category
MyApp.get "/categories/new" do 
  @current_user = User.find_by_id(session["user_id"])
  if session["user_id"] != nil
    erb :"categories/new"
  else
    erb :"please_login"
  end
end

# Processes the form for adding a category
MyApp.post "/categories/create" do 
  @current_user = User.find_by_id(session["user_id"])
  if session["user_id"] != nil
    @category = Category.new
    @category.name = params["name"]
  else
    erb :"please_login"
  end
  if @category.is_valid == true
    @category.save
    redirect "/categories/#{@category.id}"
  else
    # return error message
    erb :"categories/new"
  end
end

# Shows all categories added
MyApp.get "/categories" do 
@current_user = User.find_by_id(session["user_id"])
  if session["user_id"] != nil
    @all_categories = Category.all 
    erb :"categories/index"
  else
    erb :"please_login"
  end
end

# Shows one category
MyApp.get "/categories/:id" do 
  @one_category = Category.find_by_id(params[:id])
  erb :"categories/show" 
end

# Processes deletion of a category (from index page)
MyApp.post "/categories/:id/delete" do
  @current_user = User.find_by_id(session["user_id"])
  if session["user_id"] != nil
    @delete_category = Category.find_by_id(params[:id]) 
    @todos_of_this_category = Todo.where({"category_id" => params[:id]})
    @todos_of_this_category.delete_all
    @delete_category.delete
    erb :"categories/delete"
  else
    erb :"please_login"
  end  
end

#Shows form for updating a category
MyApp.get "/categories/:id/edit" do 
  @current_user = User.find_by_id(session["user_id"])
  if session["user_id"] != nil
    @category_update = Category.find_by_id(params[:id]) 
    erb :"categories/update"
  else
    erb :"please_login"
  end  
end

#Processes the form for updating a category
MyApp.post "/categories/:id/update" do 
  @current_user = User.find_by_id(session["user_id"])
  if session["user_id"] != nil
    @update_category = Category.find_by_id(params[:id])
    @update_category.name = params["name"]
  else
    erb :"please_login"
  end  

  if @update_category.is_valid == true
    @update_category.save
    erb :"categories/updated"
  else
    erb :"categories/update_error"
  end
end
