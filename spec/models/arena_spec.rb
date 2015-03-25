=begin
  class Arena < ActiveRecord::Base
    include Hero
    belongs_to :user
    has_many   :matches

    MAX_WINS = 12
    MAX_LOSES = 3

    def finished?
      too_much_lost? || too_much_won?
    end

    def rewarded?
      packs.present?
    end

    validates_each :matches do |arena, attr, value|
      arena.errors.add attr, "too much lost matches for the arena!" if arena.too_much_lost?
      arena.errors.add attr, "too much won matches for the arena! hooray!" if arena.too_much_won?
    end

    def too_much_lost?
      matches.where(won: false).count >= MAX_LOSES
    end

    def too_much_won?
      matches.where(won: true).count >= MAX_WINS
    end
  end
=end
