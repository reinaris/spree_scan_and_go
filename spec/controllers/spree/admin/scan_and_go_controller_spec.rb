require 'spec_helper'

describe Spree::Admin::ScanAndGoController do
  stub_authorization!
  let(:order) { create :order }

  describe '.redirect' do
    context 'a product id is given' do
      let(:product) { create :product }

      it 'redirects to the product page' do
        spree_get :redirect, { scan_and_go_input: product.id }
        expect(response).to redirect_to("/admin/products/#{product.permalink}/edit")
      end
    end 

    context 'a order number is given' do
      it 'redirects to the order page' do
        spree_get :redirect, { scan_and_go_input: order.number }
        expect(response).to redirect_to("/admin/orders/#{order.number}/edit")
      end
    end

    context 'a order number is given' do
      let(:shipment) { create :shipment, order: order, number: 'H100' }

      it 'redirects to the order page' do
        spree_get :redirect, { scan_and_go_input: shipment.number }
        expect(response).to redirect_to("/admin/orders/#{shipment.order.number}/edit")
      end
    end

    context 'a email address is given' do
      let(:user) { create :user }
      it 'redirects to the users page' do
        spree_get :redirect, { scan_and_go_input: user.email }
        expect(response).to redirect_to("/admin/users/#{user.id}/edit")
      end
    end
  end
end