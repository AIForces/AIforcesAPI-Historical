# RailsSettings Model
class Setting < RailsSettings::Base
  cache_prefix { "v1" }

  field :registration_open, type: :boolean, default:true
  field :judges_endpoints, type: :array, default: %w[http://127.0.0.1:3001/judge]
  field :trusted_ips, type: :array, default: %w[127.0.0.1]
  field :judges_submission, type: :integer
  field :tournament_logs_open, type: :boolean, default: false
  field :default_event, type: :integer

  # Define your fields
  # field :host, type: :string, default: "http://localhost:3000"
  # field :default_locale, default: "en", type: :string
  # field :confirmable_enable, default: "0", type: :boolean
  # field :admin_emails, default: "admin@rubyonrails.org", type: :array
  # field :omniauth_google_client_id, default: (ENV["OMNIAUTH_GOOGLE_CLIENT_ID"] || ""), type: :string, readonly: true
  # field :omniauth_google_client_secret, default: (ENV["OMNIAUTH_GOOGLE_CLIENT_SECRET"] || ""), type: :string, readonly: true
end
