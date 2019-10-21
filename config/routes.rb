Rails.application.routes.draw do
get 'sessions/new'  
root 'users#index'
get '/wall' => 'users#wall',as: 'wall'
get '/index'=>'users#index' ,as: 'index'
post '/home_search' => 'users#home_search'
post '/suggestion_box' => 'users#suggestion_box'

get '/signup'=>'users#signup' ,as: 'signup'

post '/signningUp' => 'users#signningUp', as: 'signningUp'

get '/verifier/:user_id/:otp' => 'users#verifier'

get '/edit/:user_id' => 'users#edit', as: 'user_edit_profile'

patch '/edit/:user_id' => 'users#save', as: 'user_save_profile'

get '/profile/:user_id' => 'users#profile', as: 'user_profile'




get '/users/debug2' => 'users#debug2'

post '/login'=>'sessions#create' ,as: 'login'

get '/logout' => 'sessions#destroy', as: 'logout'



get '/post_problem' => 'users#post_problem',as: 'post_problem'
post '/getProblemDetails' => 'users#getProblemDetails',as: 'getProblemDetails'
get 'show_attachments' => 'users#show_attachments'

get '/debug' => 'users#debug',as: 'debug'
post '/filter_tags' => 'users#filter_tags',as: 'filter_tags'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
