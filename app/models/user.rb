# User model
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_one :entry
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:slack]
  belongs_to :team
  ROLES = %w[admin user]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.username = auth.info.nickname   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data == session['devise.slack_data'] && session['devise.slack_data']['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
      end
    end
  end

  def admins
    ENV['ADMIN_EMAILS'].split(",")
  end

  before_save do
    if self.new_record?
      if admins.include? self.email
        self.role = 'admin'
      else
        self.role = 'user'
      end
    end
  end

end
