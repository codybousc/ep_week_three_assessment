require 'pry'

class Stylist
  attr_reader(:stylist_id, :stylist_name)

  define_method(:initialize) do |attribute|
    @stylist_id = attribute.fetch(:id)
    @stylist_name = attribute.fetch(:name)
  end

  define_method(:save_stylist) do
    result = DB.exec("Insert INTO stylist (stylist_name) VALUES ('#{@stylist_name}') RETURNING id; ")
    @stylist_id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:all_stylists) do
    returned_stylists = DB.exec("SELECT * FROM stylist;")
    stylists = []
    returned_stylists.each() do |stylist|
      stylist_name = stylist.fetch("stylist_name")
      id = stylist.fetch("id").to_i
      stylists.push(Stylist.new(:name => stylist_name, :id => id))
    end
    stylists
  end

  define_method(:==) do |other_stylist|
    self.stylist_name == other_stylist.stylist_name && self.stylist_id == other_stylist.stylist_id
  end

  define_method(:update_stylist) do |name, id|
    DB.exec("UPDATE stylist SET stylist_name = '#{name}'  WHERE id = '#{id}';")
    returned_stylist = DB.exec("Select * FROM stylist WHERE id = '#{id}';")
    new_name = returned_stylist.first().fetch("stylist_name")
    new_id = returned_stylist.first().fetch("id").to_i
    new_stylist = Stylist.new({:name => new_name, :id => new_id})
  end

  define_method(:delete_stylist) do
  DB.exec("DELETE FROM stylist WHERE id = '#{self.stylist_id}'")
end
end
