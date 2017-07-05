VCR.configure do |config|
  config.cassette_library_dir = "cassettes"
  config.hook_into :webmock
end
