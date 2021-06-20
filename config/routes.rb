Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    registrations: 'admins/registrations',
  }

  namespace :admin do
    get 'admin' => 'homes#top', as: 'top'

    get 'search' => 'homes#search', as: 'search'
    get 'customers/:customer_id/orders' => 'orders#index', as: 'customer_orders'

    resources :customers, only: [:index, :show, :edit, :update]
    resources :items, only: [:index,:new,:create,:show,:edit,:update,:destroy]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :orders, only: [:index, :show, :update] do
      resources :order_details, only: [:update]
    end
    resources :shops, only: [:index, :show, :create, :edit, :update, :destroy]
    resources :shop_genres, only: [:index, :create, :edit, :update]
  end

  devise_for :customers, controllers: {
    sessions: 'customers/sessions',
    registrations: 'customers/registrations',
  }

  scope module: :public do
    root 'items#top'
    get 'about' => 'homes#about', as: 'about'

    get 'customers/mypage' => 'customers#show', as: 'mypage'
    get 'customers/editt' => 'customers#edit', as: 'edit_information'
    patch 'customers' => 'customers#update', as: 'update_information'
    put 'customers/information' => 'customers#update'
    get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'confirm_unsubscribe'
    patch 'customers/withdraw' => 'customers#withdraw', as: 'withdraw_customer'
    put 'customers/withdraw' => 'customers#withdraw'

    delete 'cart_items/destroy_all' => 'cart_items#destroy_all', as: 'destroy_all_cart_items'

    post 'orders/confirm' => 'orders#confirm'
    get 'orders/confirm' => 'orders#error'
    get 'orders/complete' => 'orders#complete', as: 'complete'


    resources :shops, only: [:index, :show, :create, :update]
    resources :items, only: [:top,:index, :show] do
      resources :cart_items, only: [:create, :update, :destroy]
    end
    resources :cart_items, only: [:index]
    resources :orders, only: [:new, :index, :create, :show]
    # resources :customers, only: [:edit, :update]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
