class User < ActiveRecord::Base
  include Clearance::User
  
  after_create :activate
  
  def activate
    self.confirm_email!
  end
  
  
end
