Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :biometric_datas
    end
  end
end