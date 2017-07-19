class ReservationMailer < ApplicationMailer

  def reservation_email(user)
    @user = user
    mail(to: @user.email, subject: 'Your room is successfully booked!')
  end
end
