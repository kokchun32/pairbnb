class BraintreeController < ApplicationController
  def new
  end

  def new
    @client_token = Braintree::ClientToken.generate
  end

  def checkout
    nonce_from_the_client = params[:checkout_form][:payment_method_nonce]
    # @reservation = Reservation.find(params[:reservation_id])
    @reservation = Reservation.find(params[:id])


    result = Braintree::Transaction.sale(
     :amount => @reservation.listing.price, #this is currently hardcoded
     :payment_method_nonce => nonce_from_the_client,
     :options => {
        :submit_for_settlement => true
      }
     )

    if result.success?
      redirect_to :root, :flash => { :success => "Transaction successful!" }
    else
      redirect_to :root, :flash => { :error => "Transaction failed. Please try again." }
    end 
  end
end
