require 'pry'

class Client
  attr_reader(:client_id, :client_name)

  define_method(:initialize) do |attribute|
    @client_id = attribute.fetch(:id)
    @client_name = attribute.fetch(:name)
  end

  define_method(:save_client) do
    result = DB.exec("Insert INTO client (client_name) VALUES ('#{@client_name}') RETURNING id; ")
    @client_id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:all_clients) do
    returned_clients = DB.exec("SELECT * FROM client;")
    clients = []
    returned_clients.each() do |client|
      client_name = client.fetch("client_name")
      id = client.fetch("id").to_i
      clients.push(Client.new(:name => client_name, :id => id))
    end
    clients
  end

  define_method(:==) do |other_client|
    self.client_name == other_client.client_name && self.client_id == other_client.client_id
  end

  define_method(:update_client) do |name, id|
    DB.exec("UPDATE client SET client_name = '#{name}'  WHERE id = '#{id}';")
    returned_client = DB.exec("Select * FROM client WHERE id = '#{id}';")
    new_name = returned_client.first().fetch("client_name")
    new_id = returned_client.first().fetch("id").to_i
    new_client = Client.new({:name => new_name, :id => new_id})
  end

  define_method(:delete_client) do
  DB.exec("DELETE FROM client WHERE id = '#{self.client_id}'")
end
end
