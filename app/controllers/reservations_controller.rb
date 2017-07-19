class ReservationsController < ApplicationController
  def new
    @reservation = Reservation.new
    @listing = Listing.find(params[:listing_id])
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.save
    if @reservation.save
      ReservationMailer.reservation_email(current_user).deliver_now
    end
    redirect_to '/my_reservations'
  end

  def my_reservation
    @my_reservations = Reservation.where(user_id: current_user.id)
  end

  def edit
    @listing = Listing.find(params[:listing_id])
    @reservation = Reservation.find(params[:id])
  end

  def update
    @listing = Listing.find(params[:listing_id])
    @reservation = Reservation.find(params[:id])
    @reservation.update(reservation_params)
    @reservation.save
    redirect_to '/my_reservations'
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to '/my_reservations'
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def show_all_reservation
    @reservations = Reservation.all
  end

  def payment
    @client_token = Braintree::ClientToken.generate
    @reservation = Reservation.find(params[:id])    
  end

=begin --> code from agilan
  def new
    @reservation = Reservation.new
    @listing = Listing.find(params[:listing_id])
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.save
    redirect_to listing_reservation_path(params[:listing_id], @reservation.id)
  end
=end

  private
  def reservation_params
    params.require(:reservation).permit(:user_id, :listing_id, :check_in, :check_out)
  end
end
