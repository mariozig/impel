Impel::Application.routes.draw do
  # root should be first:
  # http://guides.rubyonrails.org/routing.html#using-root
  root 'posts#index'

  get "pages/home"
  namespace :api do
    resources :posts, :only => [:index]
  end

end
