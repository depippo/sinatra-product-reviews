class ReviewController < ApplicationController

  get "/reviews" do
    erb :"/reviews/index"
  end

  get "/reviews/new" do
    erb :"/reviews/create_review"
  end

  post "/reviews" do
    @review = Review.create(content: params[:content])
    redirect to "/reviews"
  end

end