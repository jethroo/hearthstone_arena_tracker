class Match < ActiveRecord::Base
  include Hero

  OPPONENTS = HEROS.dup.map { |hero| "opponent_#{hero}" }

  belongs_to :user
  belongs_to :arena

  enum opponent: OPPONENTS
  validates :opponent, inclusion: { in: OPPONENTS.map(&:to_s) }
  validates_associated(
    :arena,
    message: 'The number of won / lost matches for this arena is exceeded!'
  )
end
