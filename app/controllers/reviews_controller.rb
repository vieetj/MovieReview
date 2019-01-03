class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def new
    @review = Review.new
  end

  def edit
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.movie_id = @movie.id
    if @review.save
      flash[:success] = "Review was successfully created."
      redirect_to @review.movie
    else
      flash[:info] = "Review was not successfully created."
      render 'new'
    end
  end

  def update
    if current_user == @review.user
      if @review.update(review_params)
        flash[:success] = "Review was successfully updated."
        redirect_to @review.movie
      else
        flash[:info] ="Review was not successfully updated."
        render 'edit'
      end
    end
  end

  def destroy
    @movie = @review.movie
    if current_user == @review.user
        @review.destroy
        flash[:danger] = "Review was successfully destroyed."
        redirect_to movie_path(@movie)
    end
  end

  private
    def set_review
      @review = Review.find(params[:id])
    end

    def review_params
      params.require(:review).permit(:rating, :comment)
    end
end
