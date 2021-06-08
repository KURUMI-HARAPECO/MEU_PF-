Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: 'admin/sessions',
  }

  namespace :admin do
    # get 'admin' => 'homes#top', as: 'top'
    root 'homes#top'
    get 'search' => 'homes#search', as: 'search'
    get 'customers/:customer_id/orders' => 'orders#index', as: 'customer_orders'

    resources :customers, only: [:index, :show, :edit, :update]
    resources :items, except: [:index,:new,:create,:show,:edit,:update,:destroy]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :orders, only: [:index, :show, :update] do
      resources :order_details, only: [:update]
    end
    resources :shops, only: [:index, :show, :create, :edit, :update, :destroy]
  end

  devise_for :customers, controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations',
  }

  scope module: :public do
    root 'items#top'
    get 'about' => 'homes#about', as: 'about'

    get 'customers/mypage' => 'customers#show', as: 'mypage'
    get 'customers/edit' => 'customers#edit', as: 'edit_information'
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
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
