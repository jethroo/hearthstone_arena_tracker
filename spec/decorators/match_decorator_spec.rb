require 'rails_helper'

describe MatchDecorator do
  let(:created_at) { double('time') }

  let(:match_double) do
    double(
      'match',
      opponent: 'opponent_test',
      created_at: created_at,
      hero: 'hero'
    )
  end

  subject { described_class.new(match_double) }

  describe '#opponent' do
    it 'should remove prefix opponent_ for hero' do
      expect(subject.opponent).to eq('test')
    end
  end

  describe '#created_at' do
    before do
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

  describe '#hero_image' do
    it 'returns the image path of hero' do
      expect(subject.hero_image).to eq('/images/heroes/hero_small_circle.png')
    end
  end

  describe '#opponent_image' do
    it 'returns the image path of hero' do
      expect(subject.opponent_image)
        .to eq('/images/heroes/test_small_circle.png')
    end
  end

  describe '#arena_link' do
    before do
      allow(match_double).to receive(:arena).and_return(arena)
    end

    context 'when no arena' do
      let(:arena) { nil }

      it 'returns arena path' do
        expect(subject.arena_link).to eq(nil)
      end
    end

    context 'when arena' do
      let(:arena) { double('arena', id: 1) }

      it 'returns arena path' do
        expect(subject.arena_link).to match(/arenas/)
      end
    end
  end

  describe '#won' do
    context 'when match was won' do
      before do
        allow(match_double).to receive(:won?).and_return(true)
      end

      it 'returns won string' do
        expect(subject.won).to match('win')
      end
    end

    context 'when match was lost' do
      before do
        allow(match_double).to receive(:won?).and_return(false)
      end

      it 'returns lost string' do
        expect(subject.won).to match('loose')
      end
    end
  end

  describe '#arena_id' do
    context 'when arena present' do
      let(:arena) { double('arena', id: 123) }

      before do
        allow(match_double).to receive(:arena).and_return(arena)
      end

      it 'should return the arena id' do
        expect(subject.arena_id).to eq(123)
      end
    end

    context 'when arena is not presen' do
      before do
        allow(match_double).to receive(:arena).and_return(nil)
      end

      it 'should return nil' do
        expect(subject.arena_id).to eq(nil)
      end
    end
  end
end
