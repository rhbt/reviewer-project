module ReviewsHelper
  def calculate_rating(review)
    ((review.rating/review.total_ratings)*2).ceil.to_f / 2
  end
end
