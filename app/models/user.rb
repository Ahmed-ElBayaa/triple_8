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
  has_many :authentications, dependent: :destroy
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :country_id, :phone,:email, :password,
		:password_confirmation, :remember_me, :sign_in_count, :updated_at, :created_at,
    :current_sign_in_at, :current_sign_in_ip, :last_sign_in_at, :last_sign_in_ip,
    :avatar


  def admin?
    self.type == "Admin"
  end

  def self.from_omniauth_provider(auth)

    user = Authentication.where(:provider => auth.provider,
     :uid => auth.uid).first.try :user
    
    unless user
      email = auth.info.email
      user = User.find_by_email(email)
      unless user
        user = User.new(name:auth.info.name, email: email)
        user.authentications.build(provider:auth.provider, uid:auth.uid)
        # if failed to save the new user then redirect to edit page
        # to correct invalid data 
        return nil unless user.save
      end
      
    end

    authentication = Authentication.find_by_provider_and_uid(
      auth.provider, auth.uid)
    authentication.oauth_token = auth.credentials.token
    authentication.save
    user
  end

  def password_required?
    authentications.empty? && super
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  def facebook
    oauth_token = Authentication.find_by_provider_and_user_id(
      'facebook', self.id).try :oauth_token
    @facebook ||= Koala::Facebook::API.new(oauth_token)
    rescue Koala::Facebook::APIError => e
      logger.info e.to_s
      nil
  end
    
end
