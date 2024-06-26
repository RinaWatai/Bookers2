class BooksController < ApplicationController
before_action :authenticate_user!, except: [:root]

  def index
    @book = Book.new
    @user = current_user
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end

  def update
    @user = current_user
    @book = Book.find(params[:id])
    if @book.update(book_params)
       flash[:notice] = "You have updated user successfully."
       redirect_to book_path(@book.id)
    else
       render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
    @user = @book.user
    if current_user != @user
      redirect_to books_path
    else
      @book = Book.find(params[:id])
      render :edit
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body, :image)
  end
end
