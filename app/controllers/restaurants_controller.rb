class RestaurantsController < ApplicationController

  def index
    # raise 'Hello from the index action'
    @restaurants = Restaurant.all
  end

  def new

  end

  def restaurant_params
    params.require(:restaurant).permit(:name)
  end

  def create
    Restaurant.create(restaurant_params)
    redirect_to '/restaurants'
  end

end
