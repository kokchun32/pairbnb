class User < ApplicationRecord
  include Clearance::User 

  has_many :authentications, dependent: :destroy
  has_many :listings
  mount_uploader :image, ImageUploader
  has_many :reservations

  def self.create_with_auth_and_hash(authentication, auth_hash)
      user = self.create!(
        # byebug
        # username: auth_hash["name"],
        email: auth_hash["extra"]["raw_info"]["email"]
        # password: SecureRandom.
      )
      user.authentications << authentication
      return user
    end

    # grab fb_token to access Facebook for user data
    def fb_token
      x = self.authentications.find_by(provider: 'facebook')
      return x.token unless x.nil?
    end  

end
