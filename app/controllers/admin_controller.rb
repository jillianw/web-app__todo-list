# Shows homepage

MyApp.get "/" do
  erb :"home"
end

# Shows admin page

MyApp.get "/admin" do
  erb :"users/admin"
end