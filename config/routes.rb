Rails.application.routes.draw do

  # Reports

  get 'report/:purchase_channel'                => 'reports#index'

  # Batches

  post 'batch/create'                           => 'batches#create'
  post 'batch/produce'                          => 'batches#produce'
  post 'batch/close/'                           => 'batches#close'
  post 'batch/deliver/'                            => 'batches#deliver'

  # Orders
  post 'orders/create'                          => 'orders#create'

  get 'orders/:purchase_channel'                => 'orders#list'
  get 'orders/status/:ref'                      => 'orders#status'
  get 'orders/status/client/:client_name'       => 'orders#status'
end
