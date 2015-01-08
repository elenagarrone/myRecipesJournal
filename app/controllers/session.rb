get '/session/new' do
  @sign_in = true
  erb :'session/new'
end

post '/session' do
  email = params[:email]
  password = params[:password]
  @user = User.authenticate(email, password)
  if @user
    session[:user_id] = @user.id
    redirect to('/')
  else
    flash[:error] = ["Ether email or password is incorrect"]
    erb :'session/new'
  end
end

delete '/sessions' do
  session.clear
  erb :'session/delete'
end
