require 'rails_helper'

describe SessionsHelper do
  let(:user_id) { double('user_id') }
  let(:user) { double('user', id: user_id) }

  describe 'log_in' do
    it 'sets user_id in session' do
      expect { helper.log_in(user) }
        .to change { session[:user_id] }
        .from(nil)
        .to(user_id)
    end
  end

  describe 'log_out' do
    before do
      session[:user_id] = user_id
    end

    it 'unsets user_id in session' do
      expect { helper.log_out }
        .to change { session[:user_id] }
        .from(user_id)
        .to(nil)
    end
  end

  describe 'current_user' do
    context 'is set' do
      before do
        helper.instance_variable_set('@current_user', user)
      end

      it 'will be returned' do
        expect(helper.current_user).to eq(user)
      end
    end

    context 'is not set' do
      context 'and user_id is in session' do
        before do
          session[:user_id] = user_id
          allow(User).to receive(:find_by).with(id: user_id).and_return(user)
        end

        it 'will load the user' do
          expect { helper.current_user }
            .to change { helper.instance_variable_get('@current_user') }
            .from(nil)
            .to(user)
        end
      end

      context 'and user_id is not in session' do
        it 'will not change' do
          expect { helper.current_user }
            .to_not change { helper.instance_variable_get('@current_user') }
            .from(nil)
        end
      end
    end
  end

  describe 'logged_in?' do
    it 'if current_user is present' do
      expect { helper.instance_variable_set('@current_user', user) }
        .to change { helper.logged_in? }
        .from(false)
        .to(true)
    end
  end
end
