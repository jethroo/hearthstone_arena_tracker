class Arena < ActiveRecord::Base
  include Hero
  belongs_to :user
  has_many   :matches

  def finished?
    too_much_lost? || too_much_won?
  end

  validates_each :matches do |arena, attr, value|
    arena.errors.add attr, "too much lost matches for the arena!" if arena.too_much_lost?
    arena.errors.add attr, "too much won matches for the arena! hooray!" if arena.too_much_won?
  end

  def too_much_lost?
    matches.where(won: false).count > 2
  end

  def too_much_won?
    matches.where(won: true).count >= 12
  end
end
