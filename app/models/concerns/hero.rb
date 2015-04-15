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
  ].freeze

  included do
    enum hero: HEROS
    validates :hero, inclusion: { in: HEROS.map(&:to_s) }
  end
end
