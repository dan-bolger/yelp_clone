class Restaurant < ActiveRecord::Base

  has_many :reviews, dependent: :destroy
  validates :name, length: {minimum: 3}, uniqueness: true

  def build_review(current_user, review_params)
    review_info = {:restaurant_id => self.id, :user_id => current_user.id }
    review = Review.new(review_info.merge(review_params))
  end

end
