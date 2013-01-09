class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  belongs_to :country
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :classifieds, dependent: :destroy
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :country_id, :phone,:email, :password,
		:password_confirmation, :remember_me, :sign_in_count, :updated_at, :created_at,
    :current_sign_in_at, :current_sign_in_ip, :last_sign_in_at, :last_sign_in_ip
    
end
