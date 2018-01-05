class User < ActiveRecord::Base
  has_secure_password

  has_many :arenas
  has_many :matches

  validates :name, presence: true, length: { maximum: 50 }
  validates :name, uniqueness: true
  validates :password, length: { minimum: 6 }, if: :password_required?

  private

  def password_required?
    new_record? || password?
  end
end
