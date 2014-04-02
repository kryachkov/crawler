SampleApp::Application.routes.draw do
  resources :home, :only => [:index] do
    collection do
      get :products, :contacts, :map, :faq, :good_products, :bad_products, :questions, :answers
    end
  end

  root :to => 'home#index'
end
