class Comment < ApplicationRecord
  
  #customerとcommentは1対多の関係
  belongs_to :customer
  #reviewとcommentは1対多の関係
  belongs_to :review
  #バリデーション
  validates :content, presence: true
end
