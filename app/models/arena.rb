class Arena < ActiveRecord::Base
  include Hero
  belongs_to :user
  has_many   :matches

  enum hero: HEROS
  validates :hero, inclusion: { in: HEROS.map{ |hero| hero.to_s } }
end
