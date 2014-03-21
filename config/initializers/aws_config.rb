file = Rails.root.join('config', 'ss-aws.yml')

# log requests using the default rails logger
AWS.config(:logger => Rails.logger)

aws_config = nil
if File.exists?(file) && Rails.env.development?
  aws_config = YAML.load(File.read(file))
elsif ENV.key?('AWS_ACCESS_KEY_ID') && ENV.key?('AWS_SECRET_KEY')
  aws_config = {access_key_id: ENV['AWS_ACCESS_KEY_ID'], secret_access_key: ENV['AWS_SECRET_KEY']}
else
  if Rails.env.development?
    raise("No AWS config file in #{file}")
  elsif Rails.env.test?
    aws_config = {access_key_id: 'test_access_key_id', secret_access_key: 'test_secret_access_key'}
  else
    raise('No AWS credentials in the ENV')
  end
end

unless aws_config.nil?
  AWS.config(aws_config)
end