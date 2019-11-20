# RailsSettings Model
class Setting < RailsSettings::Base
  cache_prefix { "v1" }

  field :registration_open, type: :boolean, default:true
  field :judges_endpoints, type: :array, default: %w[http://127.0.0.1:3001/judge]
  field :trusted_ips, type: :array, default: %w[127.0.0.1]
  field :judges_submission, type: :integer
  field :tournament_logs_open, type: :boolean, default: false
  field :default_event, type: :integer
end
