Rails.application.routes.draw do
  get 'admins/index' => 'admins#index', as: 'admin'
get 'sessions/new'  
root 'users#index'
get '/wall' => 'users#wall',as: 'wall'
get '/index'=>'users#index' ,as: 'index'
post '/home_search' => 'users#home_search'
post '/user_search' => 'users#user_search'
post '/suggestion_box' => 'users#suggestion_box'
get '/users' => 'users#users',as: 'users'
get '/signup'=>'users#signup' ,as: 'signup'

post '/signningUp' => 'users#signningUp', as: 'signningUp'

post '/admins/index' => 'sessions#acreate', as: 'adminlogin'
get '/admins/show/:id', to: 'admins#show'

get '/verifier/:user_id/:otp' => 'users#verifier'

get '/edit/:user_id' => 'users#edit', as: 'user_edit_profile'

patch '/edit/:user_id' => 'users#save', as: 'user_save_profile'

get '/profile/:user_id' => 'users#profile', as: 'user_profile'

get '/MyPostedProblems/:user_id' => 'users#myPostedProblems' , as: 'user_posted_problems'

get '/MyPostedSolutions' => 'users#myPostedSolutions' , as: 'user_posted_solutions'

get '/viewRequests/:prob_id' => 'users#viewRequests', as: 'view_requests'

get '/sentRequests/' => 'users#sentRequests', as: 'user_sent_requests'

get '/grantAccess/:request_id' => 'users#grantAccess', as: 'grant_access'




get '/users/debug2' => 'users#debug2'

post '/login'=>'sessions#create' ,as: 'login'

get '/logout' => 'sessions#destroy', as: 'logout'

post '/alogin'=>'sessions#acreate' ,as: 'alogin'

get '/alogout' => 'sessions#adestroy', as: 'alogout'



get '/post_problem' => 'users#post_problem',as: 'post_problem'
post '/getProblemDetails' => 'users#getProblemDetails',as: 'getProblemDetails'
get 'show_attachments' => 'users#show_attachments'

get '/debug' => 'users#debug',as: 'debug'
post '/filter_tags' => 'users#filter_tags',as: 'filter_tags'
get '/viewproblem/:id' => 'users#view_problem',as:'view_problem'
post '/postsolution/:prob_id' => 'users#post_solution',as:'post_solution'
get '/request_access/:prob_id' => 'users#request_access',as:'request_access'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
