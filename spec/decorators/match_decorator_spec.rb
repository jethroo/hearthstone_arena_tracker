require 'spec_helper'

describe MatchDecorator do
  let(:created_at) { double('time') }

  let(:match) do
    double('match', opponent: 'opponent_test', created_at: created_at)
  end

  subject { described_class.new(match) }

  describe '#opponent' do
    it 'should remove prefix opponent_ for hero' do
      expect(subject.opponent).to eq('test')
    end
  end

  describe 'created_at' do
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
end
