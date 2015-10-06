require 'rest-client'

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
      ssh_keys: [ENV['SSHKEY_FINGERPRINT']],
      user_data: nil,
    }
    response = RestClient.post "https://#{ENV['TOKEN']}:@api.digitalocean.com/v2/droplets", options.to_json, content_type: :json
    puts response.to_str
  end
end
