module Spree
  module Admin
    class ScanAndGoController < Spree::Admin::BaseController
      def redirect
        input = params[:scan_and_go_input]

        case input
        when /^R/
          if order = Spree::Order.find_by_number(input)
            redirect = edit_admin_order_path(order)
          else
            error = t(:couldnt_find_order)
          end
        when /^H/
          if shipment = Spree::Shipment.find_by_number(input)
            redirect = edit_admin_order_shipment_url(shipment.order, shipment)
          else
            error = t(:couldnt_find_shipment)
          end
        when /@/
          if user = Spree::User.find_by_email(input)
            redirect = edit_admin_user_path(user)
          else
            error = t(:couldnt_find_user)
          end
        when /^[0-9]/
          if product = Spree::Product.find_by_id(input)
            redirect = edit_admin_product_path(product)
          else
            error = t(:couldnt_find_product)
          end
        else
          error = t(:couldnt_handle_scan_and_go_input)
        end

        flash[:error] = error if error
        redirect_to redirect ? redirect : :back
      end
    end
  end
end