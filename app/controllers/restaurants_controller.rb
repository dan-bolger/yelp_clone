class RestaurantsController < ApplicationController

  def index
    # raise 'Hello from the index action'
    @restaurants = Restaurant.all
  end

end
