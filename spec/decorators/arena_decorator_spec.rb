require 'rails_helper'

describe ArenaDecorator do
  let(:match) { double('match') }
  let(:matches) { [match] }
  let(:arena) { double('arena', matches: matches) }
  subject { described_class.new(arena) }

  describe '#won_count' do
    before do
      allow(match).to receive(:won).and_return(true)
      allow(matches).to receive(:select).and_call_original
    end

    after do
      expect(match).to have_received(:won)
      expect(matches).to have_received(:select)
    end

    it 'counts won matches' do
      expect(subject.won_count).to eq(1)
    end
  end

  describe '#lost_count' do
    before do
      allow(match).to receive(:won).and_return(false)
      allow(matches).to receive(:select).and_call_original
    end

    after do
      expect(match).to have_received(:won)
      expect(matches).to have_received(:select)
    end

    it 'counts lost matches' do
      expect(subject.lost_count).to eq(1)
    end
  end

  describe '#finished?' do
    before do
      allow(subject).to receive(:won_count).and_return(5)
      allow(subject).to receive(:lost_count).and_return(3)
    end

    it 'calls arena finished with known matchresults' do
      expect(subject.finished?).to be_truthy
    end
  end

  describe 'created_at' do
    let(:created_at) { double('time') }

    before do
      allow(arena).to receive(:created_at).and_return(created_at)
      allow(created_at).to receive(:strftime)
    end

    after do
      expect(created_at).to have_received(:strftime)
        .with(described_class::STRFTIME_FORMAT)
    end

    it 'formats created_at' do
      subject.created_at
    end
  end
end
