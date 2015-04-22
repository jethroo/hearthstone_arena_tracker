class Arena < ActiveRecord::Base
  include Hero
  belongs_to :user
  has_many :matches

  MAX_WINS = 12
  MAX_LOSES = 3

  attr_accessor :set_rewards

  def finished?
    matches.where(won: true).count  >= MAX_WINS ||
      matches.where(won: false).count >= MAX_LOSES
  end

  def rewarded?
    @set_rewards = true
    packs.present? && valid?
  end

  validates :packs, :gold, :dust, :cards, :gold_cards,
            numericality: true,
            allow_nil: true

  validates_each :matches do |arena, attr, _value|
    unless arena.set_rewards
      arena.errors.add(
        attr,
        'arena is finished'
      ) if arena.finished?
    end
  end

  def open_wins
    MAX_WINS - matches.where(won: true).count
  end

  def open_losses
    MAX_LOSES - matches.where(won: false).count
  end

  def rewards(reward)
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
