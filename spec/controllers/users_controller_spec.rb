require 'rails_helper'

describe UsersController, type: :controller do
  let(:user) { double('user', id: 1) }

  before do
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe '#show' do
    context 'when user found' do
      before do
        allow(controller).to receive(:fetch_max_hero_matches)
          .and_return([Match.heros.values.first, 10])
        allow(controller).to receive(:render)
      end

      after do
        expect(controller)
          .to have_received(:render)
          .with(
            locals: {
              user: user,
              max_matches: 10,
              max_hero: Hero::HEROS.first.to_s
            }
          )
      end

      it 'will render user show' do
        get :show, id: 1
      end
    end
  end
end
