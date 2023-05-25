class Customer < ApplicationRecord
  #画像を表示する記述
  has_one_attached :image
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #commentsとcustomerは多対1の関係
  has_many :comments, dependent: :destroy
  #favoritesとcustomerは多対1の関係
  has_many :favorites, dependent: :destroy
  #reviewsとcustomerは多対1の関係
  has_many :reviews, dependent: :destroy

  #バリデーション
  validates :name,presence: true
  validates :email,presence: true
  enum sex: {
    "no_answer":0,
    "man":1,
    "woman":2
  }
  validates :sex, inclusion: { in: Customer.sexes.keys }, on: :update

  #デフォルトの画像
  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end

  #ゲストログイン
  def self.guest
   find_or_create_by!(name: 'guestuser',email: 'guest@example.com',sex: 'no_answer') do |customer|
    customer.password = SecureRandom.urlsafe_base64
    customer.name = "guestuser"
   end
  end

  #退会済みのユーザーが同じアカウントでログイン出来ないよう制約を設けて
  def active_for_authentication?
   super && (is_deleted == false)
  end

end
