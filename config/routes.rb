Rails.application.routes.draw do
  get "admin_patients/index"
  get "admin_patients/show"

  devise_for :users, controllers: { registrations: 'users/registrations' }

  devise_scope :user do

    get 'admin/login', to: 'users/sessions#new', defaults: { role: 'admin' }, as: 'admin_login'

    get 'doctor/login', to: 'users/sessions#new', defaults: { role: 'doctor' }, as: 'doctor_login'

    get 'patient/login', to: 'users/sessions#new', defaults: { role: 'patient' }, as: 'patient_login'

  end

get 'dashboard', to: 'dashboard#index', as: :dashboard

get 'appointments/available_slots', to: 'appointments#available_slots', as: 'available_slots_appointments'
 
get 'patients/register', to: 'patients#new', as: 'new_patient'
post 'patients/register', to: 'patients#create', as: 'create_patient_registration'
get 'patient/dashboard', to: 'patients#dashboard', as: 'patient_dashboard'


get 'patients/:id/profile', to: 'patients#profile', as: 'patient_profile'

get 'rooms/export_csv', to: 'rooms#export_csv', as: 'export_csv_rooms'
get 'rooms/:id/available_beds', to: 'rooms#available_beds'


  
get 'admin/patients', to: 'admin_patients#index', as: 'admin_patients'
get 'admin/patients/:id', to: 'admin_patients#show', as: 'admin_patient'

  

resources :doctors do
  resources :availabilities, only: [:new, :create, :index, :destroy]
  resources :appointments, only: [:index]
  
    
    member do
      get :edit   
      patch :update 
    end
  end
  
resources :departments

resources :appointments, only: [:index, :new, :create, :destroy] do

  collection do

    get :available_doctors

    get :available_slots

    end

  member do

    patch :accept  
    get :patient_profile
    end
 
   

  end
  

  resources :rooms do
    collection do
      get :export_csv
    end
    member do
      get :available_beds  
    end
  end
  

  resources :beds
 
  

  resources :patients, only: [:new, :create, :show, :edit, :update] do
    member do
      post :admit  
    end
    
    resources :medical_records, only: [:new, :create, :show], shallow: true do
      member do
        get :download_pdf, defaults: { format: :pdf }
      end
    end
  end
  
  

 
 


  authenticated :user, ->(u) { u.admin? } do

    root to: "dashboard#index", as: :admin_root

  end
 


  root 'home#index'

end

 