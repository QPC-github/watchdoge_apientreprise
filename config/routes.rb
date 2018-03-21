require 'sidekiq/web'

Rails.application.routes.draw do
  scope 'api/watchdoge' do
    get 'dashboard/current_status'
    get 'dashboard/availability_history'
    get 'dashboard/homepage_status'
    get 'stats/jwt_usage/:jti', to: 'stats#jwt_usage'
  end

  mount Sidekiq::Web => '/sidekiq'
end
