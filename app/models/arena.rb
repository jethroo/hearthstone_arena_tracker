class Arena < ActiveRecord::Base
  include Hero
  belongs_to :user
  has_many :matches

  MAX_WINS = 12
  MAX_LOSES = 3

  attr_accessor :set_rewards

  def finished?(_won = nil, lost = nil)
    too_much_lost?(lost) || too_much_won?(lost)
  end

  def rewarded?
    @set_rewards = true
    packs.present? && valid?
  end

  validates_numericality_of(
    [:packs, :gold, :dust, :cards, :gold_cards],
    allow_nil: true
  )

  validates_each :matches do |arena, attr, _value|
    unless arena.set_rewards
      arena.errors.add(
        attr,
        'too much lost matches for the arena!'
      ) if arena.too_much_lost?
      arena.errors.add(
        attr,
        'too much won matches for the arena! hooray!'
      ) if arena.too_much_won?
    end
  end

  def too_much_lost?(lost = nil)
    (lost || matches.where(won: false).count) >= MAX_LOSES
  end

  def too_much_won?(won = nil)
    (won || matches.where(won: true).count) >= MAX_WINS
  end

  def open_wins
    MAX_WINS - matches.where(won: true).count
  end

  def open_losses
    MAX_LOSES - matches.where(won: false).count
  end

  def rewards!(reward)
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
