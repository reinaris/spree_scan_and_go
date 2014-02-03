Spree::Core::Engine.routes.draw do
  namespace :admin do
    get '/scanandgo/redirect',
        :to => 'scan_and_go#redirect'
  end
end
