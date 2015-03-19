class Match < ActiveRecord::Base
  include Hero

  belongs_to :user
  enum opponent: HEROS
  validates :opponent, inclusion: { in: HEROS.map{ |hero| hero.to_s } }
end
