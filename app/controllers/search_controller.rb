class SearchController < ApplicationController
  def search
    @target = params[:target]
    @keyword = params[:keyword]
    @match_type = params[:match_type]
    if @target == "book"
      case @match_type
      when "exact_match"
        @result = Book.where("title = :keyword OR body = :keyword", { keyword: @keyword })
      when "forward_match"
        @result = Book.where("title LIKE :keyword OR body LIKE :keyword", { keyword: "#{@keyword}%" })
      when "backward_match"
        @result = Book.where("title LIKE  :keyword OR body LIKE :keyword", { keyword: "#{@keyword}%" })
      when "partial_match"
        @result = Book.where("title LIKE  :keyword OR body LIKE :keyword", { keyword: "%#{@keyword}%" })
      else
        # type code here
      end

    elsif @target == "user"
      case @match_type
      when "exact_match"
        @result = User.where("name = :keyword ", { keyword: @keyword })
      when "forward_match"
        @result = User.where("name LIKE :keyword", { keyword: "#{@keyword}%" })
      when "backward_match"
        @result = User.where("name LIKE :keyword", { keyword: "#{@keyword}%" })
      when "partial_match"
        @result = User.where("name LIKE :keyword", { keyword: "%#{@keyword}%" })
      else
        # type code here
      end
    end
  end
end
