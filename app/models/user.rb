class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable,
         :timeoutable, :token_authenticatable, :registerable

  # Setup accessible (or protected) attributes for your model
end
