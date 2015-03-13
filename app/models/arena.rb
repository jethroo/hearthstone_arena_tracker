class Arena < ActiveRecord::Base
  belongs_to :user
  has_many   :matches

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

  enum hero: HEROS
  validates :hero, inclusion: { in: HEROS.map{ |hero| hero.to_s } }
end
