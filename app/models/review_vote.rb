class ReviewVote < ApplicationRecord
  belongs_to :review
  belongs_to :user
  belongs_to :park

  validates :choice, numericality: { only_integer: true }
  validates :choice, inclusion: { in: -1..1 }
end
