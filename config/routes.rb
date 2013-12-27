EpetitionUnzensiert::Application.routes.draw do
  devise_for :users

  get '/browser/:petition_id' => 'browser#show', :as => :browser_show, :petition_id => /\d+/
  get '/browser/index' => 'browser#index'

  resources :meinungen, :only => [] do
    collection do
      patch '/bin_unterstuetzer/:petition_id' => 'meinungen#bin_unterstuetzer', :as => :bin_unterstuetzer, :petition_id => /\d+/
      patch '/bin_dagegen/:petition_id' => 'meinungen#bin_dagegen', :as => :bin_dagegen, :petition_id => /\d+/
      patch '/habe_keine_meinung/:petition_id' => 'meinungen#habe_keine_meinung', :as => :habe_keine_meinung, :petition_id => /\d+/
      patch '/ist_spam/:petition_id' => 'meinungen#ist_spam', :as => :ist_spam, :petition_id => /\d+/
      patch '/ist_kein_spam/:petition_id' => 'meinungen#ist_kein_spam', :as => :ist_kein_spam, :petition_id => /\d+/
    end
  end

  resources :static_sites
  resources :users, :only => [:index, :show] do 
    resources :petitionen do
      patch '/jetzt_veroeffentlichen' => 'petitionen#jetzt_veroeffentlichen'
      patch '/entzensieren' => 'petitionen#entzensieren'
      patch '/admin_zensieren' => 'petitionen#admin_zensieren'
      patch '/nicht_admin_zensieren' => 'petitionen#nicht_admin_zensieren'
    end
    resources :meinungen, :only => [:index]
    patch '/ist_spammer' => 'users#ist_spammer'
    patch '/ist_kein_spammer' => 'users#ist_kein_spammer'
  end

  get '/:static_site_path' => 'static_sites#show_static_site'
  root 'static_sites#show_static_site' # index.html aus CMS ist Startseite

  get '*path' => 'application#notfound404'
end
