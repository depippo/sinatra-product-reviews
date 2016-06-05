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
      @failure_message = session[:failure_message]
      session[:failure_message] = nil
      erb :"/reviews/create_review"
    else
      redirect to "/login"
    end
  end

  post "/reviews" do
    if params[:content] != "" && params["Product Name"] !=""
      @review = Review.create(content: params[:content])
      @review.user = Helpers.current_user(session)
      @review.product = Product.find_or_create_by(name: params["Product Name"])
      @review.save
      session[:success_message] = "Successfully created review."
      redirect to "/reviews/#{@review.id}"
    else
      session[:failure_message] = "Please enter the name of product you're reviewing, and type a review in the text box."
      redirect to "/reviews/new"
    end
  end

  get '/reviews/:id' do
    if Helpers.is_logged_in?(session)
      @review = Review.find(params[:id])
      @success_message = session[:success_message]
      session[:success_message] = nil
      erb :'/reviews/show_review'
    else
      redirect to "/login"
    end
  end

  get '/reviews/:id/edit' do
    if Helpers.is_logged_in?(session)
      @review = Review.find(params[:id])
      if @review.user_id == Helpers.current_user(session).id
        @failure_message = session[:failure_message]
        session[:failure_message] = nil
        erb :'/reviews/edit_review'
      else
        redirect to "/reviews"
      end
    else
      redirect to "/login"
    end
  end

  patch '/reviews/:id' do
    @review = Review.find(params[:id])
    if params[:content] != ""
      @review.update(content: params[:content])
      session[:success_message] = "Review successfully updated."
      redirect to "/reviews/#{@review.id}"
    else
      session[:failure_message] = "Your review cannot be empty."
      redirect to "/reviews/#{@review.id}/edit"
    end
  end

  delete '/reviews/:id/delete' do
    @review = Review.find(params[:id])
    if @review.user_id == Helpers.current_user(session).id
      @review.destroy
    end
    redirect to "/reviews"
  end

end