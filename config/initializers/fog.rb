if Rails.env.development?
  CarrierWave.configure do |config|
    config.storage = :file
    config.asset_host = 'http://localhost:3000'
  end
else
  CarrierWave.configure do |config|
    config.storage = :fog
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider:              'AWS',                        # required
      aws_access_key_id:     ENV['AWS_KEY_CARRIERWAVE'],                        # required unless using use_iam_profile
      aws_secret_access_key: ENV['AWS_SECRET_CARRIERWAVE'],                        # required unless using use_iam_profile
      use_iam_profile:       true,                         # optional, defaults to false
      # region:                'eu-west-1',                  # optional, defaults to 'us-east-1'
      # host:                  's3.example.com',             # optional, defaults to nil
      # endpoint:              'https://s3.example.com:8080' # optional, defaults to nil
    }
    config.fog_directory  = 'bootcampheroku'                                      # required
    config.fog_public     = false                                                 # optional, defaults to true
    config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" } # optional, defaults to {}
  end
end