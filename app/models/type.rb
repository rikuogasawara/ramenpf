class Type < ApplicationRecord
  
  #reviewsとtypeは多対1の関係
  has_many :reviews, dependent: :destroy
  
  #バリデーション
   validates :name,presence: true
end
