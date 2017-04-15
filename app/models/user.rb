class User < ApplicationRecord
  has_many :parks
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable #,:rememberable
  # validates :display_name, allow_blank: true
end
