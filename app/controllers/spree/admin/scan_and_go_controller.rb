module Spree
  module Admin
    class ScanAndGoController < Spree::Admin::BaseController

      RULES = {
        /^RMA/ => :return_authorization,
        /^R/ => :order,
        /^H/ => :shipment,
        /@/ => :user,
        /^[0-9]/ => :product
      }

      def redirect
        input = params[:scan_and_go_input]
        error, redirect = nil, nil

        rules.each do |matcher, action|
          if input =~ matcher
            r = send(action, input)
            redirect, error = r[:redirect], r[:error]
            break
          end
        end

        error = t(:couldnt_handle_scan_and_go_input) if error.nil? && redirect.nil?

        flash[:error] = error if error
        redirect_to redirect ? redirect : :back
      end

      private

      def return_authorization(input)
        if return_authorization = Spree::ReturnAuthorization.find_by(number: input)
          redirect = edit_admin_order_return_authorization_path(return_authorization.order, return_authorization)
        else
          error = t(:couldnt_find_return_authorization)
        end

        { redirect: redirect, error: error }
      end

      def order(input)
        if order = Spree::Order.find_by(number: input)
          redirect = edit_admin_order_path(order)
        else
          error = t(:couldnt_find_order)
        end

        { redirect: redirect, error: error }
      end


      def shipment(input)
        if shipment = Spree::Shipment.find_by(number: input)
          # Since the shipment has no detail page we redirect to the order
          redirect = edit_admin_order_path(shipment.order)
        else
          error = t(:couldnt_find_shipment)
        end

        { redirect: redirect, error: error }
      end

      def user(input)
        if user = Spree::User.find_by(email: input)
          redirect = edit_admin_user_path(user)
        else
          error = t(:couldnt_find_user)
        end

        { redirect: redirect, error: error }
      end

      def product(input)
        if product = Spree::Product.find_by_id(input)
          redirect = edit_admin_product_path(product)
        else
          error = t(:couldnt_find_product)
        end

        { redirect: redirect, error: error }
      end

      def rules
        RULES
      end
    end
  end
end
