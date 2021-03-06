class User < ApplicationRecord

  include RailsAdminCharts

  validates :email, uniqueness: true
  validates :name, uniqueness: true


  mount_uploader :avatar, ImageUploader

  rolify

  after_initialize :set_default_role, if: :new_record?
  validates :roles, presence: true

  def set_default_role
    self.add_role(:normal)
  end

  def self.from_omniauth(auth)
      where(email: auth.info.email, provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.name = auth.info.name   # assuming the user model has a name
        user.profile_photo = auth.info.image # assuming the user model has an image
        # If you are using confirmable and the provider(s) you use validate emails,
        # uncomment the line below to skip the confirmation emails.
        # user.skip_confirmation!
    end
  end



  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[github]
         # :trackable,


  has_many :comments, dependent: :destroy
  has_many :projects, dependent: :destroy

  paginates_per 10


end
