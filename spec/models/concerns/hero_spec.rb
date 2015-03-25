require 'rails_helper'

describe Hero do
  subject { Hero }

  describe "constants" do
    it "should have a heros constant" do
      expect(subject).to have_constant(:HEROS)
    end
  end

  describe "included" do
    class HeroDummy
      include ActiveModel::Validations
      include ActiveModel::Model

      def self.enum(_)
      end

      def self.validates(*)
      end
    end

    before do
      allow(HeroDummy).to receive(:enum).with(hero: Hero::HEROS)
      allow(HeroDummy).to receive(:validates).with(:hero, inclusion: { in: Hero::HEROS.map{ |hero| hero.to_s } })
    end

    after do
      expect(HeroDummy).to have_received(:enum).with(hero: Hero::HEROS)
      expect(HeroDummy).to have_received(:validates).with(:hero, inclusion: { in: Hero::HEROS.map{ |hero| hero.to_s } })
    end

    it "should call enum and validates" do
      HeroDummy.send(:include, Hero)
    end
  end
end
