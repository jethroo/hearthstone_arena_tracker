class Match < ActiveRecord::Base
  include Hero

  OPPONENTS = HEROS.dup.map {|h| "opponent_#{h}"}

  belongs_to :user
  enum opponent: OPPONENTS
  validates opponent, inclusion: { in: OPPONENTS.map{ |hero| hero.to_s } }
end
