class Soup < ApplicationRecord
  
  #reviewsとsoupは多対1の関係
  has_many :reviews, dependent: :destroy
 
  #バリデーション
   validates :name,presence: true
end
