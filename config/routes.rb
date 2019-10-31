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

get '/approve/:sol_id' => 'users#approve' , as: 'approve'

get '/revert/:problem_id/:user_id' => 'users#revert' , as: 'revert'

get '/satisfied/:sol_id/:button_id/' => 'users#satisfied' , as: 'satisfied'



get '/admins/monthly_report', to: 'admins#monthly_report'

post '/signningUp' => 'users#signningUp', as: 'signningUp'

post '/admins/index' => 'sessions#acreate', as: 'adminlogin'
get '/admins/show/:id', to: 'admins#show',as: 'adminshow'
get '/admins/show/:id/:bid' => 'admins#show',as: 'adminshowstat'
get '/verifier/:user_id/:otp' => 'users#verifier'

get '/edit/:user_id' => 'users#edit', as: 'user_edit_profile'

patch '/edit/:user_id' => 'users#save', as: 'user_save_profile'

get '/profile/:user_id' => 'users#profile', as: 'user_profile'

get '/MyPostedProblems' => 'users#myPostedProblems' , as: 'user_posted_problems'

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
post '/afilter_tags' => 'admins#afilter_tags',as: 'afilter_tags'
get '/viewproblem/:id' => 'users#view_problem',as:'view_problem'
post '/postsolution/:prob_id' => 'users#post_solution',as:'post_solution'
get '/request_access/:prob_id' => 'users#request_access',as:'request_access'
post '/upvote/:id' => 'users#upvote', as: 'upvote'
post '/downvote/:id' => 'users#downvote', as: 'downvote'
get '/repost/:prob_id' => 'users#repost',as: 'repost'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
