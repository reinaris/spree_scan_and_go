Deface::Override.new(
  :virtual_path   => "spree/layouts/admin",
  :insert_bottom  => "#wrapper",
  :name           => "add_scan_box_to_admin",
  :partial        => "spree/admin/scan_and_go/scan_box")