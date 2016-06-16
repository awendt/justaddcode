require 'rest-client'
require 'net/ssh'
require 'dotenv/tasks'

def user_data
  public_user_data = File.read('user_data.sh')
  secret_user_data = begin
    File.read('secrets.sh')
  rescue Errno::ENOENT
    ''
  end
  [public_user_data, secret_user_data].join("\n")
end

namespace :droplet do
  desc 'Creates droplet for the given HOSTNAME'
  task create: :dotenv do
    options = {
      backups: false,
      image: "dokku",
      ipv6: true,
      name: ENV['HOSTNAME'],
      private_networking: nil,
      region: "fra1",
      size: "512mb",
      ssh_keys: [Net::SSH::KeyFactory.load_public_key("~/.ssh/id_rsa.pub").fingerprint],
      user_data: user_data,
    }
    response = RestClient.post "https://#{ENV['TOKEN']}:@api.digitalocean.com/v2/droplets", options.to_json, content_type: :json
    puts response.to_str
  end
end
