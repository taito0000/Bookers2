class BooksController < ApplicationController

  before_action :ensure_current_user, {only: [:edit, :update, :destroy]}

  def ensure_current_user
    unless Book.find(params[:id]).user.id.to_i == current_user.id
      redirect_to books_path,
      notice: "権限がありません"
    end
  end

  def create
    @books = Book.all
    @user = current_user
    @book_new = Book.new(book_params)
    @book_new.user_id = current_user.id
    if @book_new.save
      redirect_to book_path(@book_new.id),
      notice: "You have created book successfully."
    else
      render :index
    end
  end

  def index
    @books = Book.all
    @book_new = Book.new
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    redirect_to book_path(@book.id),
    notice: "You have updated book successfully."
    else
    render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end


  private

  def book_params
    params.require(:book).permit(:title, :body)
  end



  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image_id)
  end

end
