require 'rails_helper'

describe User do
  it { should have_secure_password }
  it { should validate_uniqueness_of(:name) }
  it { should validate_presence_of(:name) }
  it { should ensure_length_of(:name).is_at_most(50) }
  it { should ensure_length_of(:password).is_at_least(6) }
end
