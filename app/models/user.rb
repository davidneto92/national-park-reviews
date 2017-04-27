class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  validates_processing_of :avatar
  validate :avatar_size_validation

  has_many :parks
  has_many :reviews
  has_many :park_votes
  has_many :review_votes
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable #,:rememberable
  # validates :display_name, allow_blank: true

  def admin?
    return self.role == "admin"
  end

  private

  def avatar_size_validation
    errors[:avatar] << "should be less than 500KB" if avatar.size > 0.5.megabytes
  end
end
