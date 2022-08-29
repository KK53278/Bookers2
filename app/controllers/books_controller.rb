class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

 def new
    @book = Book.new
    @books = Book.all
 end

 def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
  if @book.save
    redirect_to book_path(@book), notice: 'You have created book successfully.'
  else
    @books = Book.all
    @user = current_user
    render action: :index
  end
 end

 def index
    @book = Book.new
    @books = Book.all
    @user =current_user
 end

 def show
    @book = Book.find(params[:id])
    @books = Book.all
    @user =@book.user
    @booknew = Book.new
 end

 def edit
      @book = Book.find(params[:id])
  if  @book.user == current_user
      render "edit"
  else
      redirect_to books_path(@book.id)
  end
 end

 def update
      @book = Book.find(params[:id])
  if  @book.update(book_params)
      redirect_to book_path(@book.id), notice: 'You have modified book successfully.'
  else
      render action: :edit
  end
 end

 def destroy
      @book = Book.find(params[:id])
  if  @book.user == current_user
      @book.destroy
      redirect_to books_path
  end
 end

  # 投稿データのストロングパラメータ
 private

 def book_params
    params.require(:book).permit(:title, :body)
 end

 def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
 end

 def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
  if current_user != @user
    redirect_to books_path
  end
 end
end