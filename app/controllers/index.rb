get '/' do
  # Look in app/views/index.erb
  @posts = Post.all
  if request.xhr?
    erb :_all_posts, layout: false
  else
    erb :index
  end
end

get '/create_post' do
  erb :create_post, layout: !request.xhr?
end

get '/user/:user_id' do
  @user = User.find(params[:user_id])
  erb :profile
end

get '/user/:user_id/posts' do
  @user = User.find(params[:user_id])
  erb :user_posts
end

get '/user/:user_id/comments' do
  @user = User.find(params[:user_id])
  erb :user_comments
end

get "/post/comments/:post_id" do
  @post = Post.find(params[:post_id])
  erb :post_comments
end

get '/logout' do
  session[:user_id] = nil
  redirect to '/'
end

get '/post_counter/:post_id/:type_vote' do
  if params[:type_vote] == "upvote"
    @vote = 1
  else
    @vote = -1
  end
  @post = Post.find(params[:post_id])
  @post.postvotes.create(user_id: current_user.id, value: @vote)
  new_counter = @post.counter + @vote
  @post.update_attributes(counter: new_counter)

  if request.xhr?
    @post.counter.to_s
  else
    redirect to '/'
  end
end


post '/create_user' do
  User.create(params[:user])
  redirect to '/'
end

post '/login' do
  found_user = User.find_by_name(params[:name])
  
  if found_user
    @current_user = User.authenticate(params[:name], params[:password])
  end

  if @current_user
    session[:user_id] = @current_user.id
    redirect to '/'
  else
    redirect to '/'
  end
end

post '/created_post' do
  if session[:user_id]
    @post = Post.create(params[:post])

    @user = User.find(session[:user_id])
    @user.posts << @post

    redirect to '/'
  else
    redirect to '/'
  end
end
