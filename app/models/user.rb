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
    authentication.oauth_secret = auth.credentials.secret
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
    unless @facebook
      auth = Authentication.find_by_provider_and_user_id('facebook', self.id)
      @facebook = Koala::Facebook::API.new(auth.oauth_token) if auth
    end
    @facebook
  end

  def twitter
    unless @twitter
      auth = Authentication.find_by_provider_and_user_id('twitter', self.id)      
      @twitter = Twitter::Client.new(oauth_token: auth.oauth_token,
        oauth_token_secret: auth.oauth_secret ) if auth      
    end
    @twitter
  end

  def linkedin
    unless @linkedin
      auth = Authentication.find_by_provider_and_user_id('linkedin', self.id)
      if auth
        @linkedin = LinkedIn::Client.new
        @linkedin.authorize_from_access(auth.oauth_token, auth.oauth_secret)
      end
    end
    @linkedin
  end
  
  def share url, title

    Thread.new { 
      self.facebook.try(:put_object,"me",
       "#{Triple8::Application.config.fb_namespace}:#{Triple8::Application.config.fb_action}",
       classified: url,"fb:explicitly_shared" => true) 
    }
    
    tweet = "I have posted a new classified '#{title}' #{url}"
    self.twitter.try(:update, tweet.truncate(140))

    self.linkedin.try(:add_share, content: {title: title, 'submitted-url'=> url})
    
  end  
end
