class Review < ActiveRecord::Base
  validates :rating, inclusion: (1..5)

  belongs_to :user
  belongs_to :restaurant

  validates :user, uniqueness: { scope: :restaurant, message: "I cannot possibly allow you to review this restaurant twice" }
end
