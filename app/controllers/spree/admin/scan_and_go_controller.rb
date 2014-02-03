module Spree
  module Admin
    class ScanAndGoController < Spree::Admin::BaseController
      def redirect
        sag_value = params[:scan_and_go_input]

        if sag_value.starts_with? "R"
          # order
          if order = Spree::Order.find_by(number: sag_value)
            redirect = edit_admin_order_path(order)
          else
            error = t(:couldnt_find_order)
          end
        elsif sag_value.include? "@"
          # user
          if user = Spree::User.find_by(email: sag_value)
            redirect = edit_admin_user_path(user)
          else
            error = t(:couldnt_find_user)
          end            
        elsif sag_value.starts_with? "H"
          # shipment, order
          if shipment = Spree::Shipment.find_by(number: sag_value) and shipment.order
            # as the shipment has no detail page, redirect to the order
            redirect = edit_admin_order_path(shipment.order)
          else
            error = t(:couldnt_find_shipment)
          end
        else
          error = t(:couldnt_handle_scan_and_go_input)
        end

        if error
          flash[:error] = error
        end

        if redirect
          redirect_to redirect
        else
          redirect_to :back
        end

      end
    end
  end
end