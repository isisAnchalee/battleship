class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  devise :omniauthable, :omniauth_providers => [:facebook, :twitter]
  
  has_many :games
  has_many :boards

  attr_accessor :login

  def username
    self.email || self.username || 'butts'
  end

  def total_score
    return 0.to_s if score.nil?
    score.to_s
  end

  def email_required?
    false
  end

  def setup_boards(game)
    board = Board.new({ game_id: game.id, user_id: id })
    board.save!
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.picture = auth.info.image
      user.email = auth.info.nickname
      user.password = Devise.friendly_token[0,20]
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
