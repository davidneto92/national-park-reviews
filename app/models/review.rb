class Review < ApplicationRecord
  has_many :review_votes
  belongs_to :park
  belongs_to :user

  validates :title, length: { minimum: 20 }
  validates :body, length: { minimum: 100 }
  validate :visit_date_has_happened

  def calculate_score
    if !self.review_votes.empty?
      return self.review_votes.inject(0){|sum, vote| sum + vote.choice }
    else
      return 0
    end
  end

  private

  def visit_date_has_happened
    if (self.visit_date.to_time.to_i) > Time.now.to_i
      errors.add("Visit date", "cannot be in the future.")
    end
  end
end
