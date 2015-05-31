
require 'addressable/uri'
require 'rest-client'

def create_contact
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users/1/contacts'
  ).to_s

  new_user_data = {
    contact: {
      name: 'Kevin 3000',
      email: 'kevin3000@gmail.com',
    }
  }
  begin
    puts RestClient.post(url, new_user_data)
  rescue StandardError => e
    puts e.message
  end
end


def update_contact
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/contacts/1'
  ).to_s

  new_user_data = {
    contact: {
      name: 'Zach 3000',
      email: 'zach3000@gmail.com'
    }
  }
  begin
    puts RestClient.patch(url, new_user_data)
  rescue StandardError => e
    puts e.message
  end
end

def destroy_contact
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/contacts/1'
  ).to_s

  begin
    puts RestClient.delete(url)
  rescue StandardError => e
    puts e.message
  end
end

def show_contact
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/contacts/2'
  ).to_s

  begin
    puts RestClient.get(url)
  rescue StandardError => e
    puts e.message
  end
end
