class ListingsController < ApplicationController

  def index
    # @listings = Listing.all
    @filterrific = initialize_filterrific(
    Listing,
    params[:filterrific]
    ) or return
    @listings = Listing.all.paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params)
    # byebug
    if @listing.save
      redirect_to '/my_listing'
    else
      render '/listings/new'
    end
  end

  def show
    # byebug
    @listing = Listing.find(params[:id])
  end

  def my_listing
    @my_listings = Listing.where(user_id: current_user.id)
  end

  def edit
    @listing = Listing.find(params[:id])
  end

  def update
    @listing = Listing.find(params[:id])
    @listing.update(listing_params)
    if @listing.save 
      redirect_to '/my_listing'
    end
  end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy
      if current_user.role == "admin"
        redirect_to '/admin_listing'
      else
      redirect_to '/my_listing'
    end
  end

  def admin_listing
    @listings=Listing.all
  end

  private
  def listing_params
    # params.require(:listing).permit(:user_id, :name, :property_type, :room_number, :bed_number, :guest_number, :country, :state, :city, :zipcode, :address, :price, :image)
    params.require(:listing).permit(:user_id, :name, :property_type, :room_number, :bed_number, :guest_number, :country, :state, :city, :zipcode, :address, {image: []})
  end
end
