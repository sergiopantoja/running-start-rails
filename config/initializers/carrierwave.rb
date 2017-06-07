CarrierWave.configure do |config|
  case Rails.env
  when 'development'
    config.storage = :file
    config.asset_host = 'http://localhost:5000'
  when 'test'
    config.storage = :file
    config.asset_host = 'public'
  else
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: Rails.application.secrets.aws_access_key_id,
      aws_secret_access_key: Rails.application.secrets.aws_secret_access_key,
      region: Rails.application.secrets.aws_region
    }
    config.fog_directory  = Rails.application.secrets.aws_s3_bucket
    config.storage = :fog
  end
end
