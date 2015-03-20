class Arena < ActiveRecord::Base
  include Hero
  belongs_to :user
  has_many   :matches
end
