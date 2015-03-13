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
            :valera
          ]

  enum hero: HEROS
end
