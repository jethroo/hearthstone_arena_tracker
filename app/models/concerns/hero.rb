module Hero
  extend ActiveSupport::Concern

  HEROS = [
          :anduin,
          :garrosh,
          :guldan,
          :jaina,
          :malfurion,
          :rexxar,
          :thrall,
          :uther,
          :valeera
        ]

  included do
    enum hero: HEROS
    validates :hero, inclusion: { in: HEROS.map{ |hero| hero.to_s } }
  end
end
