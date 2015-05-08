require 'spec_helper'

describe(Client) do
  describe("#name") do
    it("returns client name") do
      test_client = Client.new({:name => "Lordy Lord", :id => nil})
      expect(test_client.name()).to(eq("Lordy Lord"))
    end
  end

  describe("#save_client") do
    it("pushes the client name into the database") do
      test_client = Client.new({:name => "Lordy Lord", :id => nil})
      test_client.save_client()
      all_clients = Client.all_clients
      expect(all_clients).to(eq([test_client]))
    end
  end

  describe(".all_clients") do
  it("retrieves all entries in from the database table accessed") do
    test_client = Client.new({:name => "Lordy Lord", :id => nil})
    test_client.save_client()
    test_client2 = Client.new({:name => "Lordy of the Rings", :id => nil})
    test_client2.save_client()
    all_clients = Client.all_clients
    expect(all_clients).to(eq([test_client,test_client2]))
  end
end

describe("#id") do
  it("Checks assigned ID to match serial type and be Fixnum") do
    test_client = Client.new({:name => "Lordy Lord", :id => nil})
    test_client.save_client()
    all_clients = Client.all_clients
    expect(all_clients[0].client_id).to(be_an_instance_of(Fixnum))
  end
end

describe("#update_client") do
  it("alters the client name") do
    test_client = Client.new({:name => "Lordy Lord", :id => nil})
    test_client.save_client()
    old_id = test_client.client_id
    new_client = test_client.update_client("Looooordy Lord", test_client.client_id)
    expect(new_client.client_id).to(eq((test_client.client_id)))
    expect(new_client.name).to(eq("Looooordy Lord"))
  end
end

describe("#delete_client")  do
    it("deletes a client from the database") do
      test_client = Client.new({:name => "OH Lord", :id => nil})
      test_client.save_client()
      test_client2 = Client.new({:name => "Lordy Lord", :id => nil})
      test_client2.save_client()
      test_client2.delete_client()
      expect(Client.all_clients).to(eq([test_client]))
    end
  end
end
