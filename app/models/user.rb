class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  devise :omniauthable, :omniauth_providers => [:facebook, :twitter]
  
  has_one :player
  attr_accessor :login

  def email_required?
    false
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.picture = auth.info.image
      user.email = auth.info.nickname
      user.password = Devise.friendly_token[0,20]
      # user.name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def update_picture(omniauth)
    if omniauth['provider'] == 'twitter'
        self.picture = omniauth['info']['image'].sub("_normal", "")
    end
  end

  def portrait(size)
    # Twitter
    # mini (24x24)                                                                  
    # normal (48x48)                                            
    # bigger (73x73)                                                
    # original (variable width x variable height)
    if self.image.include? "twimg"
        # determine filetype        
        case 
        when self.image.downcase.include?(".jpeg")
            filetype = ".jpeg"
        when self.image.downcase.include?(".jpg")
            filetype = ".jpg"
        when self.image.downcase.include?(".gif")
            filetype = ".gif"
        when self.image.downcase.include?(".png")
            filetype = ".png"
        else
            raise "Unable to read filetype of Twitter image for User ##{self.id}"
        end
        # return requested size
        if size == "original"
            return self.image
        else
            return self.image.gsub(filetype, "_#{size}#{filetype}")
        end
    end
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end
end
