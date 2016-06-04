class ProductController < ApplicationController

  get '/products' do
    if Helpers.is_logged_in?(session)
      @products = Product.all
      erb :'/products/index'
    else
      redirect to "/login"
    end
  end

  get '/products/:slug' do
    if Helpers.is_logged_in?(session)
      @product = Product.find_by_slug(params[:slug])
      erb :'/products/show_product'
    else
      redirect to "/login"
    end
  end

end