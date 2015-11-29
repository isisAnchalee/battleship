class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  devise :omniauthable, :omniauth_providers => [:facebook, :twitter]
  
  has_many :boards
  has_many :games
  has_many :first_player_games, class_name: 'Game', foreign_key: 'first_player_id'
  has_many :second_player_games, class_name: 'Game', foreign_key: 'second_player_id'
  has_many :first_players, through: :first_player_games
  has_many :second_players, through: :second_player_games
  has_many :first_player_board, through: :first_players , source: :games
  has_many :second_player_board, through: :second_players, source: :games

  attr_accessor :login

  def username
    self.email || self.username
  end

  def total_score
    return "0" if score.nil?
    "#{score}"
  end

  def email_required?
    false
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
