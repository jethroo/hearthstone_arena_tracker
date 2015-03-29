class Arena < ActiveRecord::Base
  include Hero
  belongs_to :user
  has_many   :matches

  MAX_WINS = 12
  MAX_LOSES = 3

  attr_accessor :set_rewards

  def finished?
    too_much_lost? || too_much_won?
  end

  def rewarded?
    packs.present?
  end

  validates_each :matches do |arena, attr, value|
    unless arena.set_rewards
      arena.errors.add attr, "too much lost matches for the arena!" if arena.too_much_lost?
      arena.errors.add attr, "too much won matches for the arena! hooray!" if arena.too_much_won?
    end
  end

  def too_much_lost?
    matches.where(won: false).count >= MAX_LOSES
  end

  def too_much_won?
    matches.where(won: true).count >= MAX_WINS
  end

  def set_rewards!(reward)
    @set_rewards = true
    self.packs       = reward[:packs]
    self.gold        = reward[:gold]
    self.dust        = reward[:dust]
    self.cards       = reward[:cards]
    self.gold_cards  = reward[:gold_cards]
    self.finished_at = Time.now
    save
  end
end
