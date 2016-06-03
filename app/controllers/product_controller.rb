class ProductController < ApplicationController

  get '/products' do
    @products = Product.all
    erb :'/products/index'
  end

  get '/products/:slug' do
    @product = Product.find_by_slug(params[:slug])
    erb :'/products/show_product'
  end

end