Rails.application.routes.draw do

  # Batches

  # Orders
  post 'orders/create'           => 'orders#create'

  get 'orders/:purchase_channel'                => 'orders#list'
  get 'orders/status/:ref'                      => 'orders#status'
  get 'orders/status/client/:client_name'       => 'orders#status'
end
