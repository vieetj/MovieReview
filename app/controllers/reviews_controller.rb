class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  # before_action :set_movie, only: [:new]
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
      redirect_to @review.movie
    else
      render 'new'
    end
  end

  def update
    if current_user == @review.user
      if @review.update(review_params)
        redirect_to @review.movie
      else
        render 'edit'
      end
    end
  end

  def destroy
    @movie = @review.movie
    if current_user == @review.user
        @review.destroy
    end
    redirect_to movie_path(@movie)
  end

  private
    def set_review
      @review = Review.find(params[:id])
    end

    def review_params
      params.require(:review).permit(:rating, :comment)
    end
end