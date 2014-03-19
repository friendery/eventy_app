# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
SampleApp::Application.initialize!

require 'aws/s3'
AWS::S3::DEFAULT_HOST = "s3-ap-southeast-1.amazonaws.com"