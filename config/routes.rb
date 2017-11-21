Rails.application.routes.draw do
	get '/patients/check_in'
	post '/send_sms' => 'patients#send_sms'
	get 'patients/verify'
	post '/patients/verify' => 'patients#verify_patient'
	patch '/patients/:id/update' => 'patients#update'
	get '/patients/:id/details' =>'patients#details'#, as: 'patient_details'


  resources :patients#, controller: 'patients'
  resources :doctors


  resources :patient_histories
	root 'home#index'

  resources :hospitals
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
