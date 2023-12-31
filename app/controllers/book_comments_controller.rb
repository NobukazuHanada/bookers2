class BookCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book = book
    comment.save
    @comment = comment
    @book = book
  end

  def destroy
    comment = BookComment.find(params[:id])
    unless comment.user.id == current_user.id
      redirect_to books_path
    end
    comment.destroy
    @comment = comment
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:body)
  end

end
