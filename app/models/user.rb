class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  validates_processing_of :avatar
  validate :avatar_size_validation

  validates :display_name, length: { minimum: 5 }, uniqueness: true
  validates :display_name, format: { with: /\A[a-zA-Z0-9\-_]{5,40}\Z/, message: "Only allows letters and numbers" }

  has_many :parks, :dependent => :delete_all
  has_many :reviews, :dependent => :delete_all
  has_many :park_votes, :dependent => :delete_all
  has_many :review_votes, :dependent => :delete_all
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
