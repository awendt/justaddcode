require 'rest-client'
require 'net/ssh'

namespace :droplet do
  desc 'Creates droplet for justaddco.de'
  task :create do
    options = {
      backups: false,
      image: "dokku",
      ipv6: true,
      name: ENV['HOSTNAME'],
      private_networking: nil,
      region: "fra1",
      size: "512mb",
      ssh_keys: [Net::SSH::KeyFactory.load_public_key("~/.ssh/id_rsa.pub").fingerprint],
      user_data: File.read('user_data.sh'),
    }
    response = RestClient.post "https://#{ENV['TOKEN']}:@api.digitalocean.com/v2/droplets", options.to_json, content_type: :json
    puts response.to_str
  end
end
