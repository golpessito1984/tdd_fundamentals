# Use TDD principles to build out name functionality for a Person.
# Here are the requirements:
# - Add a method to return the full name as a string. A full name includes
#   first, middle, and last name. If the middle name is missing, there shouldn't
#   have extra spaces.
# - Add a method to return a full name with a middle initial. If the middle name
#   is missing, there shouldn't be extra spaces or a period.
# - Add a method to return all initials. If the middle name is missing, the
#   initials should only have two characters.
#
# We've already sketched out the spec descriptions for the #full_name. Try
# building the specs for that method, watch them fail, then write the code to
# make them pass. Then move on to the other two methods, but this time you'll
# create the descriptions to match the requirements above.
require "rspec/autorun"


class Person
  def initialize(first_name:, middle_name: nil, last_name:)
    @first_name = first_name
    @middle_name = middle_name
    @last_name = last_name
  end

  def full_name
    return @first_name + " " + @middle_name + " " + @last_name if @middle_name
    @first_name + " " + @last_name
  end

  def initials
    return @first_name[0]+"."+@middle_name[0]+"."+@last_name[0] if @middle_name
    @first_name[0]+"."+@last_name[0]
  end
end

RSpec.describe Person do
  describe "#full_name" do
    it "does not add extra spaces if middle name is missing" do
      person = Person.new(first_name: "David", last_name: "de la Rosa")
      expect(person.full_name).to eq("David de la Rosa")
    end
  end

  describe "#full_name_with_middle_initial" do
    it "concatenates first name, middle name, and last name with spaces" do
      person = Person.new(first_name: "David", middle_name: "Ruiz", last_name: "de la Rosa")
      expect(person.full_name).to eq("David Ruiz de la Rosa")
    end
  end

  describe "#initials" do
    it "successfully with first name, middle name, and last name" do
      person = Person.new(first_name: "Cristina", middle_name: "Mena", last_name: "Manzano")
      expect(person.initials).to eq("C.M.M")
    end

    it "successfully with two characters when middle name is empty" do
      person = Person.new(first_name: "Cristina", last_name: "Manzano")
      expect(person.initials).to eq("C.M")
    end

  end
end
