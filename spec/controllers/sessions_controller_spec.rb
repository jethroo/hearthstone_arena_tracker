require 'rails_helper'

RSpec.configure { |c| c.include SessionsHelper }

describe SessionsController, type: :controller do
  let(:user) { double('user', id: 1, name: 'user') }

  describe 'create' do
    let(:create_params) do
      {
        session: {
          name: 'user',
          password: 'secret'
        }
      }
    end

    before do
      allow(controller)
        .to receive(:require_login)
        .and_call_original

      allow(controller)
        .to receive(:log_in)
        .and_call_original
    end

    after do
      expect(controller).to_not have_received(:require_login)
    end

    context 'with existing user' do
      before do
        allow(User)
          .to receive(:find_by)
          .with(name: create_params[:session][:name])
          .and_return(user)
      end

      context 'with valid name and password' do
        before do
          allow(user)
            .to receive(:authenticate)
            .with(create_params[:session][:password])
            .and_return(true)
        end

        after do
          expect(controller).to have_received(:log_in)
        end

        it 'will login user' do
          expect { post :create, create_params }
            .to change { flash[:success] }
            .from(nil)
            .to(/Welcome back user/)
        end
      end

      context 'with valid name and invalid password' do
        before do
          allow(user)
            .to receive(:authenticate)
            .with(create_params[:session][:password])
            .and_return(false)
        end

        after do
          expect(controller).to_not have_received(:log_in)
        end

        it 'will not login user' do
          expect { post :create, create_params }
            .to change { flash[:alert] }
            .from(nil)
            .to(/The credentials you provided/)
        end
      end
    end

    context 'with not existing user' do
      after do
        expect(controller).to_not have_received(:log_in)
      end

      it 'will not login user' do
        expect { post :create, create_params }
          .to change { flash[:alert] }
          .from(nil)
          .to(/The credentials you provided/)
      end
    end
  end

  describe 'destroy' do
    before do
      allow(controller).to receive(:current_user).and_return(user)
      allow(controller).to receive(:log_out).and_call_original
      delete :destroy
    end

    after do
      expect(controller).to have_received(:current_user).at_least(1).times
      expect(controller).to have_received(:log_out)
    end

    it 'will log out the user' do
      expect(response).to be_redirect
      expect(flash[:success]).to match(/You have been logged out./)
    end
  end
end
