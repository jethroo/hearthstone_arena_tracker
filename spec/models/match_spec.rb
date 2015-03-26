require 'rails_helper'

describe Match do
  subject { described_class.new }

  context "module inclusion" do
    it "should include Hero" do
      expect(Arena.included_modules).to include(Hero)
    end
  end

  describe "constants" do
    it "should have a max wins constant" do
      expect(described_class).to have_constant(:OPPONENTS)
    end

    it "should equal Hero::HEROS but prefixed with opponent_" do
      expect(
        described_class::OPPONENTS.map do
          |opponent| opponent.gsub("opponent_", "").to_sym
        end
      ).to eq(Hero::HEROS)
    end
  end

  describe "valid?" do
    context "validates inclusion of opponent" do
      before do
        subject.hero = Hero::HEROS.first
      end

      it "if a valid opponent" do
        expect{ subject.opponent = described_class::OPPONENTS.first }
          .to change{ subject.valid? }
            .from(false)
            .to(true)
      end
    end

    context "validates arena" do
      let(:arena) do
        double("arena",
          marked_for_destruction?: false,
        )
      end

      let(:match) do
        subject.tap do |match|
          match.hero = subject.hero = Hero::HEROS.first
          match.opponent = described_class::OPPONENTS.first
        end
      end

      before do
        allow(match).to receive(:arena).and_return(arena)
      end

      after do
        expect(arena).to have_received(:valid?)
      end

      context "with valid arena" do
        before do
          allow(arena).to receive(:valid?).and_return(true)
        end

        it "is true" do
          expect(match.valid?).to be_truthy
        end
      end

      context "with invalid arena" do
        before do
          allow(arena).to receive(:valid?).and_return(false)
        end

        it "is false" do
          expect(match.valid?).to be_falsy
        end
      end
    end
  end
end
