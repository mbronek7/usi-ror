Rails.application.routes.draw do
  resources :detections
  root to: "detections#index"
end
