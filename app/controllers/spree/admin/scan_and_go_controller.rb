module Spree
  module Admin
    class ScanAndGoController < Spree::Admin::BaseController
      def redirect
        sag_value = params[:scan_and_go_input]

        unless sag_value.blank?
          if sag_value.starts_with? "R"
            # order
            order = Spree::Order.where(number: sag_value).first
            if order
              redirect = edit_admin_order_path(order)
            else
              error = t(:couldnt_find_order)
            end
          elsif sag_value.include? "@"
            # user
            user = Spree::User.where(email: sag_value).first
            if user
              redirect = edit_admin_user_path(user)
            else
              error = t(:couldnt_find_user)
            end            
          elsif sag_value.starts_with? "H"
            # shipment, order
            shipment = Spree::Shipment.where(number: sag_value).first
            # as the shipment has no detail page, redirect to the order
            if shipment and shipment.order
              redirect = edit_admin_order_path(shipment.order)
            else
              error = t(:couldnt_find_shipment)
            end
          else
            error = t(:couldnt_handle_scan_and_go_input)
          end
        else
          error = t(:scan_and_go_input_was_empty)          
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