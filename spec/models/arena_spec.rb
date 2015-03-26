require 'rails_helper'

describe Arena do
  subject { described_class.new }

  context "module inclusion" do
    it "should include Hero" do
      expect(described_class.included_modules).to include(Hero)
    end
  end

  describe "constants" do
    it "should have a max wins constant" do
      expect(described_class).to have_constant(:MAX_WINS)
    end

    it "should have a max loses constant" do
      expect(described_class).to have_constant(:MAX_LOSES)
    end
  end

  describe "finished?" do
    context "if lost to many matches" do
      before do
        allow(subject).to receive(:too_much_lost?).and_return(true)
      end

      after do
        expect(subject).to have_received(:too_much_lost?)
      end

      it "is true" do
        expect(subject.finished?).to be_truthy
      end
    end

    context "if won to many matches" do
      before do
        allow(subject).to receive(:too_much_won?).and_return(true)
      end

      after do
        expect(subject).to have_received(:too_much_won?)
      end

      it "is true" do
        expect(subject.finished?).to be_truthy
      end
    end

    context "neither lost or won to much" do
      before do
        allow(subject).to receive(:too_much_won?).and_return(false)
        allow(subject).to receive(:too_much_lost?).and_return(false)
      end

      after do
        expect(subject).to have_received(:too_much_won?)
        expect(subject).to have_received(:too_much_lost?)
      end

      it "is false" do
        expect(subject.finished?).to be_falsy
      end
    end
  end

  describe "rewarded?" do
    it "is determined by packs" do
      expect{ subject.packs = 1 }.to change{ subject.rewarded? }.from(false).to(true)
    end
  end

  describe "too_much_lost?" do
    context "with 3 lost matches" do
      let(:matches) { double("matches", count: 3) }

      before do
        allow(matches).to receive(:where).with(won: false).and_return(matches)
        allow(subject).to receive(:matches).and_return(matches)
      end

      after do
        expect(matches).to have_received(:where).with(won: false)
        expect(subject).to have_received(:matches)
      end

      it "is true" do
        expect(subject.too_much_lost?).to be_truthy
      end
    end

    context "less then 3 lost " do
      let(:matches) { double("matches", count: 0) }

      before do
        allow(matches).to receive(:where).with(won: false).and_return(matches)
        allow(subject).to receive(:matches).and_return(matches)
      end

      it "is false" do
        expect(subject.too_much_lost?).to be_falsy
      end
    end
  end

  describe "too_much_won?" do
    context "with 12 won matches" do
      let(:matches) { double("matches", count: 12) }

      before do
        allow(matches).to receive(:where).with(won: true).and_return(matches)
        allow(subject).to receive(:matches).and_return(matches)
      end

      after do
        expect(matches).to have_received(:where).with(won: true)
        expect(subject).to have_received(:matches)
      end

      it "is true" do
        expect(subject.too_much_won?).to be_truthy
      end
    end

    context "less then 12 won " do
      let(:matches) { double("matches", count: 0) }

      before do
        allow(matches).to receive(:where).with(won: true).and_return(matches)
        allow(subject).to receive(:matches).and_return(matches)
      end

      it "is false" do
        expect(subject.too_much_won?).to be_falsy
      end
    end
  end

  describe "valid?" do
    context "is false if having to much lost matches" do
      before do
        allow(subject).to receive(:too_much_lost?).and_return(true)
      end

      after do
        expect(subject).to have_received(:too_much_lost?)
      end

      it "is false" do
        expect(subject.valid?).to be_falsy
      end
    end

    context "is false if having to much won matches" do
      before do
        allow(subject).to receive(:too_much_won?).and_return(true)
      end

      after do
        expect(subject).to have_received(:too_much_won?)
      end

      it "is false" do
        expect(subject.valid?).to be_falsy
      end
    end
  end
end
