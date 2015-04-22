require 'rails_helper'

describe Arena do
  subject { described_class.new }

  context 'module inclusion' do
    it 'should include Hero' do
      expect(described_class.included_modules).to include(Hero)
    end
  end

  describe 'constants' do
    it 'should have a max wins constant' do
      expect(described_class).to have_constant(:MAX_WINS)
    end

    it 'should have a max loses constant' do
      expect(described_class).to have_constant(:MAX_LOSES)
    end
  end

  describe 'finished?' do
    context 'if lost or won to many matches' do
      before do
        allow(subject).to receive(:finished?).and_return(true)
      end

      after do
        expect(subject).to have_received(:finished?)
      end

      it 'is true' do
        expect(subject.finished?).to be_truthy
      end
    end

    context 'neither lost or won to much' do
      before do
        allow(subject).to receive(:finished?).and_return(false)
      end

      after do
        expect(subject).to have_received(:finished?)
      end

      it 'is false' do
        expect(subject.finished?).to be_falsy
      end
    end
  end

  describe 'rewarded?' do
    before do
      subject.hero = Hero::HEROS.first
    end

    it 'is determined by packs' do
      expect { subject.packs = 1 }.to change { subject.rewarded? }
        .from(false).to(true)
    end
  end

  describe 'valid?' do
    context 'if finished' do
      before do
        allow(subject).to receive(:finished?).and_return(true)
      end

      after do
        expect(subject).to have_received(:finished?)
      end

      it 'is false' do
        expect(subject.valid?).to be_falsy
      end
    end
  end

  describe 'open_wins' do
    context 'with 5 won matches' do
      let(:matches) { double('matches', count: 5) }

      before do
        allow(matches).to receive(:where).with(won: true).and_return(matches)
        allow(subject).to receive(:matches).and_return(matches)
      end

      after do
        expect(matches).to have_received(:where).with(won: true)
        expect(subject).to have_received(:matches)
      end

      it 'returns left to win matches' do
        expect(subject.open_wins).to eq(described_class::MAX_WINS - 5)
      end
    end
  end

  describe 'open_losses' do
    context 'with 2 lost matches' do
      let(:matches) { double('matches', count: 2) }

      before do
        allow(matches).to receive(:where).with(won: false).and_return(matches)
        allow(subject).to receive(:matches).and_return(matches)
      end

      after do
        expect(matches).to have_received(:where).with(won: false)
        expect(subject).to have_received(:matches)
      end

      it 'returns left to loose matches' do
        expect(subject.open_losses).to eq(described_class::MAX_LOSES - 2)
      end
    end
  end
end
