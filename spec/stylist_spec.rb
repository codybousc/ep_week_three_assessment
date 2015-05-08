require 'spec_helper'

describe(Stylist) do
  describe("#name") do
    it("returns stylist name") do
      test_stylist = Stylist.new({:name => "Lordy Lord", :id => nil})
      expect(test_stylist.name()).to(eq("Lordy Lord"))
    end
  end

  describe("#save_stylist") do
    it("pushes the stylist name into the database") do
      test_stylist = Stylist.new({:name => "Lordy Lord", :id => nil})
      test_stylist.save_stylist()
      all_stylists = Stylist.all_stylists
      expect(all_stylists).to(eq([test_stylist]))
    end
  end

  describe(".all_stylists") do
  it("retrieves all entries in from the database table accessed") do
    test_stylist = Stylist.new({:name => "Lordy Lord", :id => nil})
    test_stylist.save_stylist()
    test_stylist2 = Stylist.new({:name => "Lordy of the Rings", :id => nil})
    test_stylist2.save_stylist()
    all_stylists = Stylist.all_stylists
    expect(all_stylists).to(eq([test_stylist,test_stylist2]))
  end
end

describe("#id") do
  it("Checks assigned ID to match serial type and be Fixnum") do
    test_stylist = Stylist.new({:name => "Lordy Lord", :id => nil})
    test_stylist.save_stylist()
    all_stylists = Stylist.all_stylists
    expect(all_stylists[0].id).to(be_an_instance_of(Fixnum))
  end
end

describe("#update_stylist") do
  it("alters the stylist name") do
    test_stylist = Stylist.new({:name => "Lordy Lord", :id => nil})
    test_stylist.save_stylist()
    old_id = test_stylist.id
    new_stylist = test_stylist.update_stylist("Looooordy Lord", test_stylist.id)
    expect(new_stylist.id).to(eq((test_stylist.id)))
    expect(new_stylist.name).to(eq("Looooordy Lord"))
  end
end

describe("#delete_stylist")  do
    it("deletes a stylist from the database") do
      test_stylist = Stylist.new({:name => "OH Lord", :id => nil})
      test_stylist.save_stylist()
      test_stylist2 = Stylist.new({:name => "Lordy Lord", :id => nil})
      test_stylist2.save_stylist()
      test_stylist2.delete_stylist()
      expect(Stylist.all_stylists).to(eq([test_stylist]))
    end
  end
end
