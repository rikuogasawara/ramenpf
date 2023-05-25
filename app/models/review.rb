class Review < ApplicationRecord
   #画像を表示する記述
   has_one_attached :image

   #GoogleMapの住所入力
   geocoded_by :address
   after_validation :geocode
   
   #commentsとreviewは多対1の関係
   has_many :comments, dependent: :destroy
   #favoritesとreviewは多対1の関係
   has_many :favorites, dependent: :destroy
   #customerとreviewは1対多の関係
   belongs_to :customer
   #typeとreviewは1対多の関係
   belongs_to :type
   #soupとreviewは1対多の関係
   belongs_to :soup

   #バリデーション
   validates :name,presence: true
   validates :address,presence: true
   validates :menu,presence: true
   validates :image,presence: true
   validates :introduction,presence: true
   enum status: {
    "published": true,
    "draft": false
   }
   validates :status,presence: true

   def favorited_by?(customer)
     favorites.where(customer_id: customer.id).exists?
   end

end