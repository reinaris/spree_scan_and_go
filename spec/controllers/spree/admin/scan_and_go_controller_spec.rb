require 'spec_helper'

describe Spree::Admin::ScanAndGoController do
  stub_authorization!

  describe '.redirect' do
    context 'a order number is given' do
      let(:order) { create :order }

      it 'redirects to the order page' do
        spree_get :redirect, { scan_and_go_input: order.number }
        expect(response).to redirect_to("/admin/orders/#{order.number}/edit")
      end
    end
  end
end