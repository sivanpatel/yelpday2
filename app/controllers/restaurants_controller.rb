class RestaurantsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @restaurants = Restaurant.all
    current_user ? @user_id = current_user.id : @user_id = nil
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new({ name: restaurant_params[:name],
                                   user_id: current_user.id })
    if @restaurant.save
      redirect_to '/restaurants'
    else
      render 'new'
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.created_by_current_user?(current_user)
      @restaurant.update(restaurant_params)
      redirect_to '/restaurants'
    else
      flash[:notice] = 'You cannot edit restaurants you did not create.'
      render 'index'
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.created_by_current_user?(current_user)
      @restaurant.destroy
      flash[:notice] = 'Restaurant deleted successfully'
      redirect_to '/restaurants'
    else
      flash[:notice] = 'You cannot delete restaurants you did not create.'
      render 'index'
    end
  end

  def restaurant_params
    params.require(:restaurant).permit(:name)
  end

end
