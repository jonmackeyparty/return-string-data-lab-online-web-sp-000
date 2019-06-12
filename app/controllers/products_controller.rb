class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def info
    @product = Product.find(params[:id])
    if @product.inventory > 0
      @product.inventory_description = 'Available'
    else
      @product.inventory_description = 'Sold Out'
    end
    render plain: "#{@product.name}: #{@product.description}. #{@product.inventory_description}"
  end

  def description
    product = Product.find(params[:id])
    render plain: product.description
  end

  def inventory
    product = Product.find(params[:id])
    if product.inventory > 0
      render plain: "true"
    else
      render plain: "false"
    end
  end

  def create
    @product = Product.create(product_params)
    @product.save
    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :description)
  end

end
