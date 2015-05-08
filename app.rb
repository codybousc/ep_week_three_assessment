require'sinatra'
require 'sinatra/reloader'
also_reload("lib/**/*.rb")
require './lib/client'
require './lib/stylist'
require 'pg'
require 'pry'

DB = PG.connect({:dbname => "hair_salon"})

get('/') do
  @stylists = Stylist.all_stylists
  erb(:index)
end

post('/stylists') do
  name = params.fetch("stylist_name")
  stylist = Stylist.new({:name => name, :id => nil})
  stylist.save_stylist
  @stylists = Stylist.all_stylists
  erb(:index)
end

get("/stylists/:id") do
  @stylist = Stylist.find(params.fetch("id").to_i())
  erb(:stylist)
end
