class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[ show edit update destroy ]

  def index
    # @restaurants = Restaurant.all
    # Because of the Scope rules that I have inside my RestaurantPolicy
    # There two lines(5 && 8) are returning EXACLTY the same data!!!!!!
    @restaurants = policy_scope(Restaurant)
  end

  def show
    authorize @restaurant
  end

  def new
    @restaurant = Restaurant.new
    authorize @restaurant
  end

  def edit
    authorize @restaurant
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user = current_user
    authorize @restaurant

    if @restaurant.save
      redirect_to restaurant_url(@restaurant), notice: "Restaurant was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @restaurant
    if @restaurant.update(restaurant_params)
      redirect_to restaurant_url(@restaurant), notice: "Restaurant was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @restaurant
    if @restaurant.destroy
      redirect_to restaurants_url, notice: "Restaurant was successfully destroyed."
    end
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def restaurant_params
    params.require(:restaurant).permit(:name)
  end
end
