Rails.application.routes.draw do
  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'

  namespace :api do
    namespace :v1 do
      devise_for :users, controllers: {
        sessions: 'api/v1/users/sessions',
        registrations: 'api/v1/users/registrations',
        passwords: 'api/v1/users/passwords'
      }

      # Define routes for the 'users' resource under api/v1/users
      namespace :users do
        scope controller: 'users' do
          post '/', action: :create
          get '/', action: :index
          get '/:id', action: :show
          patch '/:id', action: :update
          put '/:id', action: :update
          delete '/:id', action: :destroy
        end
      end

      # Define routes for the 'leads' resource under api/v1/leads
      namespace :leads do
        scope controller: 'leads' do
          post '/', action: :create
          get '/', action: :index
          get '/:id', action: :show
          patch '/:id', action: :update
          put '/:id', action: :update
          delete '/:id', action: :destroy
        end
      end
    end
  end
end
