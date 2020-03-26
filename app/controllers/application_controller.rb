class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end
  
  get '/recipes/new' do
    erb :new
  end 
   get '/recipes/:id' do
    @recipe = Recipe.find_by(id: params[:id])
    erb :show
  end
  
  post '/recipes' do
    @recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    # binding.pry
    redirect "/recipes/#{@recipe.id}"
  end
  
  patch '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    #binding.pry
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect to "/recipes/#{@recipe.id}"
  end
  
  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by(id: params[:id])
    # binding.pry
    erb :edit
  end
  
  delete '/recipes/:id' do
    Recipe.find_by(id: params[:id]).destroy
    redirect '/recipes'
  end
  
 end
 
