require "rails_helper"

describe ApplicationController, type: :controller do
  describe "require_login" do
    context "not logged in" do
      let(:response) { double("response") }

      before do
        allow(controller).to receive(:logged_in?).and_return(false)
        allow(controller).to receive(:redirect_to).with(:root).and_return(response)
        allow(controller).to receive(:flash).and_return({ alert: "" })
      end

      after do
        expect(controller).to have_received(:logged_in?)
        expect(controller).to have_received(:redirect_to).with(:root)
        expect(controller).to have_received(:flash)
      end

      it "should redirect_to :root" do
        expect(controller.require_login).to eq(response)
      end
    end

    context "logged in" do
      before do
        allow(controller).to receive(:logged_in?).and_return(true)
      end

      it "is nil" do
        expect(controller.require_login).to be_nil
      end
    end
  end
end
