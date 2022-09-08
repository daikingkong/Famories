Rails.application.routes.draw do

  devise_for :end_users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_scope :end_user do
    post 'end_user/guest_sign_in' => 'public/sessions#guest_sign_in'
  end

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do
    root 'homes#top'
    get 'about' => 'homes#about'
    resources :end_users, only: [:show, :edit, :update, :destroy] do
      get 'favorite_memories' => 'end_users#favorite_memories'
      get 'unsubscribe' => 'end_users#unsubscribe'
    end

    get 'thanks' => 'end_users#thanks'

    resources :memories do
      resources :memory_comments, only: [:create, :destroy]
      resource :memory_favorites, only: [:create, :destroy]
    end

    resources :memory_tags, only: [:create, :index] do
      get 'tag_memories' => 'memory_tags#tag_memories'
    end

    resources :groups do
      get 'unsubscribe_confirm' => 'groups#unsubscribe_confirm'
      resources :join_requests, only: [:create, :index, :destroy]
      resources :group_users, only: [:create, :destroy]
      resources :group_memories, except: [:index]
    end

  end

  namespace :admin do
    get '' => 'homes#top'
    resources :end_users, only: [:index, :show, :destroy]
    resources :memories, only: [:show, :destroy]
    resources :memory_comments, only: [:index, :destroy]
    resources :groups, only: [:index, :show, :destroy] do
      resources :group_memories, only: [:show, :destroy]
    end
    resources :group_memories, only: [:index]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
