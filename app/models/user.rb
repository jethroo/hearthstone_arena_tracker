class User < ActiveRecord::Base
  has_secure_password

  has_many :arenas
  belongs_to :user

  validates :name, presence: true, length: { maximum: 50 }
  validates :name, uniqueness: true
  validates :password, length: { minimum: 6 }

end
