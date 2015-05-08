require 'pry'

class Stylist
  attr_reader(:id, :name)

  define_method(:initialize) do |attribute|
    @id = attribute.fetch(:id)
    @name = attribute.fetch(:name)
  end

  define_method(:save_stylist) do
    result = DB.exec("Insert INTO stylist (name) VALUES ('#{@name}') RETURNING id; ")
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:all_stylists) do
    returned_stylists = DB.exec("SELECT * FROM stylist;")
    stylists = []
    returned_stylists.each() do |stylist|
      name = stylist.fetch("name")
      id = stylist.fetch("id").to_i
      stylists.push(Stylist.new(:name => name, :id => id))
    end
    stylists
  end

  define_method(:==) do |other_stylist|
    self.name == other_stylist.name && self.id == other_stylist.id
  end

  define_method(:update_stylist) do |name, id|
    DB.exec("UPDATE stylist SET name = '#{name}'  WHERE id = '#{id}';")
    returned_stylist = DB.exec("Select * FROM stylist WHERE id = '#{id}';")
    new_name = returned_stylist.first().fetch("name")
    new_id = returned_stylist.first().fetch("id").to_i
    new_stylist = Stylist.new({:name => new_name, :id => new_id})
  end

  define_method(:delete_stylist) do
  DB.exec("DELETE FROM stylist WHERE id = '#{self.id}'")
  end

  define_singleton_method(:find) do |id|
  found_stylist = nil
  Stylist.all_stylists().each() do |stylist|
    if stylist.id().==(id)
      found_stylist = stylist
    end
  end
  found_stylist
  end

  define_method(:clients) do
  stylist_clients = []
  clients = DB.exec("SELECT * FROM client WHERE stylist_id = #{self.id()};")
  clients.each() do |client|
    name = client.fetch("name")
    stylist_id = client.fetch("stylist_id").to_i()
    stylist_clients.push(Client.new({:name => name, :stylist_id => stylist_id}))
  end
  stylist_clients
  end
  
end
