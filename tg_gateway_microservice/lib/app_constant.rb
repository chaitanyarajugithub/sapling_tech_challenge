# Following the third answer in http://stackoverflow.com/questions/12330730/where-should-i-store-constant-data-and-then-how-to-reference-it-in-rails
module AppConstant
  CONFIG_FILE = File.expand_path("#{Rails.root}/config/constants.yml", __FILE__)
  @@app_constants = YAML.load_file(CONFIG_FILE)
  @@constants = @@app_constants[Rails.env]

  @@service_list = @@constants['service_list']

  @@service_paths = {}

  def self.service_paths
    @@service_paths
  end
end
