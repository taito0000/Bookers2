class UsersController < ApplicationController

  before_action :ensure_current_user, {only: [:edit, :update]}

  def ensure_current_user
    unless User.find(params[:id]) == current_user
      redirect_to user_path(current_user.id),
      notice: "権限がありません"
    end
  end

  def index
    @users = User.all
    @user = current_user
    @book_new = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book_new = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to user_path(@user.id),
    notice: "You have updated user successfully."
    else
    render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :books)
  end

end
