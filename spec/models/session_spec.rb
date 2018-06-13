require "rails_helper"

describe Session, :type => :model do

    it  "Create Session" do
        session=Session.new(:title => "Session1", :location => "Roma", :version => "1", :description => "Description1")
        expect(session).to be_valid
    end

    it "is not valid without a title" do
        session=Session.new(:title => nil)
        expect(session).to_not be_valid
    end

    it "is not valid without a location" do
        session=Session.new(:title => "Titolo", :location => nil)
        expect(session).to_not be_valid
    end

    it "is not valid without a version" do
        session=Session.new(:title => "Titolo", :location => "Roma", :version => nil)
        expect(session).to_not be_valid
    end

    it "is not valid without a description" do
        session=Session.new(:title => "Titolo", :location => "Roma", :version => "1.0", :description => nil)
        expect(session).to_not be_valid
    end

end
