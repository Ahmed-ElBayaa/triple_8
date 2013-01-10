class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  has_attached_file :avatar, :styles => { :medium => "100x100>", :thumb => "30x30>" }

  validates_attachment_content_type :avatar,  content_type: /image/
  validates_attachment_size :avatar, less_than: 2.megabytes

  belongs_to :country

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :classifieds, dependent: :destroy
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :country_id, :phone,:email, :password,
		:password_confirmation, :remember_me, :sign_in_count, :updated_at, :created_at,
    :current_sign_in_at, :current_sign_in_ip, :last_sign_in_at, :last_sign_in_ip,
    :avatar


  def admin?
    self.type == "Admin"
  end
    
end
