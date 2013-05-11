Impel::Application.routes.draw do
  # root should be first:
  # http://guides.rubyonrails.org/routing.html#using-root
  root 'pages#main'

  namespace :api do
    resources :posts, :only => [:index]
  end

end
