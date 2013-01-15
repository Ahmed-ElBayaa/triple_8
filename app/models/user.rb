class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  has_attached_file :avatar, :styles => { :medium => "100x100>", :thumb => "30x30>" }

  validates_attachment_content_type :avatar,  content_type: /image/
  validates_attachment_size :avatar, less_than: 2.megabytes

  belongs_to :country

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
   :trackable, :validatable, :omniauthable


  has_many :classifieds, dependent: :destroy
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :country_id, :phone,:email, :password,
		:password_confirmation, :remember_me, :sign_in_count, :updated_at, :created_at,
    :current_sign_in_at, :current_sign_in_ip, :last_sign_in_at, :last_sign_in_ip,
    :avatar,:provider, :uid


  def admin?
    self.type == "Admin"
  end

  def self.from_omniauth_facebook(auth)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(provider:auth.provider, uid:auth.uid,
        name:"#{auth.extra.raw_info.first_name} #{auth.extra.raw_info.last_name}",        
        email: auth.info.email,
        password:Devise.friendly_token[0,20] )
    end
    user
  end

  def self.from_omniauth_twitter(auth)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(name:auth.info.name,
        provider:auth.provider, uid:auth.uid,
        email: "#{auth.provider}#{auth.uid}@888.com",
        password:Devise.friendly_token[0,20] )
    end
    user
  end

  def self.from_omniauth_linkedin(auth)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(name:auth.info.name,
        provider:auth.provider, uid:auth.uid,
        email: auth.info.email,
        password:Devise.friendly_token[0,20] )
    end
    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
    
end
