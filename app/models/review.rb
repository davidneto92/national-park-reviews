class Review < ApplicationRecord
  belongs_to :park
  belongs_to :user

  validates :title, length: { minimum: 20 }
  validates :body, length: { minimum: 100 }
  validate :visit_date_has_happened

  private

  def visit_date_has_happened
    if (self.visit_date.to_time.to_i) > Time.now.to_i
      errors.add("Visit date", "cannot be in the future.")
    end
  end
end
