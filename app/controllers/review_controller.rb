class ReviewController < ApplicationController

  get "/reviews" do
    @reviews = Review.all
    erb :"/reviews/index"
  end

  get "/reviews/new" do
    erb :"/reviews/create_review"
  end

  post "/reviews" do
    @review = Helpers.current_user(session).reviews.create(content: params[:content])
    redirect to "/reviews"
  end

end