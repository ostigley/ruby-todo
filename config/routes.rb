Rails.application.routes.draw do
  get 'to_do/index'

  root 'to_do#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
