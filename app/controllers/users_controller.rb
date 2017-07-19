class UsersController < Clearance::UsersController

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in @user
      # redirect_back_or url_after_create
      redirect_to "users/homepage"
    else
      render template: "users/new"
    end
  end

  # def index
  # end

  def homepage
    @user = User.find(current_user.id)    
  end

  def edit
    @user = User.find(current_user.id) 
  end

  def update
    @user = User.find(current_user.id) 
    @user.update(user_params)
    if @user.save 
      redirect_to '/homepage'
    end
  end

  def redirect_signed_in_users
    if signed_in?
      redirect_to "/homepage"
    else
      redirect_to "/sign_in"
    end
  end


  private

  def user_params
    params.require(:user).permit(:email, :username, :password, :image)
  end

end