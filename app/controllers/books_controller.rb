class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    @new_book = Book.new
    @comment = BookComment.new
    view_history = @book.view_histories.new
    view_history.user = current_user
    view_history.save
  end

  def index
    order = params[:order]
    subquery = Favorite.where("created_at > ?", 1.week.ago)
    if order == "new"
      @books = Book.order(created_at: "DESC")
    elsif order == "rating"
      @books = Book.order(rating: "DESC")
    else
      @books = Book
                 .joins("LEFT OUTER JOIN (#{subquery.to_sql}) AS favorites ON favorites.book_id = books.id")
                 .group(:id)
                 .order("COUNT(favorites.id) DESC")
    end
    @book = Book.new
  end

  def create
    @book = Book.new(new_book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user.id != current_user.id
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def new_book_params
    params.require(:book).permit(:title, :body, :rating)
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
