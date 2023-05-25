class Favorite < ApplicationRecord
  
  #customerとfavoriteは1対多の関係
  belongs_to :customer
  #reviewとfavoriteは1対多の関係
  belongs_to :review
  
  #バリデーション
  validates_uniqueness_of :review_id, scope: :customer_id
end
