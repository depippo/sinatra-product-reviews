class ReviewController < ApplicationController

  get "/reviews" do
    if Helpers.is_logged_in?(session)
      @reviews = Review.all
      erb :"/reviews/index"
    else
      redirect to "/login"
    end
  end

  get "/reviews/new" do
    if Helpers.is_logged_in?(session)
      @products = Product.all
      erb :"/reviews/create_review"
    else
      redirect to "/login"
    end
  end

  post "/reviews" do
    if params[:content] != ""
      @review = Review.create(content: params[:content])
      @review.user = Helpers.current_user(session)
      @review.product = Product.find_or_create_by(name: params["Product Name"])
      @review.save
      redirect to "/reviews"
    else
      redirect to "/reviews/new"
    end
  end

  get '/reviews/:id' do
  if Helpers.is_logged_in?(session)
    @review = Review.find(params[:id])
      erb :'/reviews/show_review'
    else
      redirect to "/login"
    end
  end

  delete '/reviews/:id/delete' do
    @review = Review.find(params[:id])
    if @review.user_id == Helpers.current_user(session).id
      @review.destroy
      redirect to "/reviews"
    else
      erb :'/reviews/error'
    end
  end

end