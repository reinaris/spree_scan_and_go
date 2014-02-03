Spree Scan And Go
==============

Find orders, shipments and users with you barcode scanner.
This extension is usefull when you use a barcode scanner with you Spree shop.
If you print a barcode to your printable orders or packing slips, you can easily scan this barcode to view the order or shipment in your Spree admin.

For user without a barcode scanner: it's also pretty handy to just find stuff very fast from every admin screen. The scan and go bar will be on the bottom of every screen.

Created for Spree 2-1-stable (2.1.4)

Installation
------------

Add spree_scan_and_go to your Gemfile:

```ruby
gem 'spree_scan_and_go', github: 'reinaris/spree_scan_and_go'
```

Bundle your dependencies and run the installation generator:

```shell
bundle
bundle exec rails g spree_scan_and_go:install
```
