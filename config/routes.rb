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
    get 'orders/confirm/error' => 'orders#error'
    get 'order/confirm/index' => 'orders#confirm_html'
    post 'order/confirm' => 'orders#confirm'
    # get 'order/confirm' => 'orders#confirm'


    root 'items#top'
    get 'about' => 'homes#about', as: 'about'

    get 'customers/mypage' => 'customers#show', as: 'mypage'
    get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'confirm_unsubscribe'
    patch 'customers/withdraw' => 'customers#withdraw', as: 'withdraw_customer'
    put 'customers/withdraw' => 'customers#withdraw'

    delete 'cart_items/destroy_all' => 'cart_items#destroy_all', as: 'destroy_all_cart_items'


    get 'orders/complete' => 'orders#complete', as: 'complete'

    resources :customers, only: [:edit, :update]
    resources :shops, only: [:index, :show, :create, :update]
    resources :items, only: [:top,:index, :show] do
      resources :cart_items, only: [:create, :update, :destroy]
    end
    resources :cart_items, only: [:index]
    resources :orders, only: [:new, :index, :create, :show]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
