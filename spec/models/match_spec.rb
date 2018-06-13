require "rails_helper"

describe Match, :type => :model do

    it  "Create Match" do
        @session=Session.new(:title => "Session1", :location => "Roma", :version => "1", :description => "Description1")
        match=@session.matches.new(:title => "Match1", :data => Date.today)
        expect(match).to be_valid
    end

    it "is not valid without a title" do
        @session=Session.new(:title => "Session1", :location => "Roma", :version => "1", :description => "Description1")
        match=@session.matches.new(:title => nil)
        expect(match).to_not be_valid
    end

    it "is not valid without a date" do
        @session=Session.new(:title => "Session1", :location => "Roma", :version => "1", :description => "Description1")
        match=@session.matches.new(:title => "Match1", :data => nil)
        expect(match).to_not be_valid
    end
end
