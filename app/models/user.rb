class User < ApplicationRecord
  has_many  :addresses
  belongs_to  :team
  # accepts_nested_attributes_for :addresses
    # is the same as the method defined below:

  def addresses_attributes=(addresses_attributes) # Magic of nested forms
    # raise addresses_attributes.inspect

    # addresses_attributes = [
    #   {street_1: "Address 1 Street", address_type: "Home"},
    #   {street_1: "Address 2 Street", address_type: "Business"}
    # ]

    # When used with fields_for ,rails will generate these:
    # addresses_attributes = {
    #     0 => {street_1: "Address 1 Street", address_type: "Home"},
    #     1 => {street_2: "Address 2 Street", address_type: "Business"}
    # }

    addresses_attributes.each do |i, address_attributes|
      # want to create an address for this user with these attributes
      # "i" is the placeholder for the numeric keys(0, 1, 2 etc...). we're only interested in the value(which is the hash for the address attributes) of that numeric key.
      # raise address_attributes.inspect
      self.addresses.build(address_attributes)
      # self is the current_user
    end
  end

  def team_name=(name)
    # find that team by name
    self.team = Team.find_by(name: name)
  end

  def new_team_attributes=(team_attributes)
    # team_attributes = {
    #   name: "New Team Name",
    #   hometown: "Singapore"
    # }
    self.team.build(team_attributes)
    # create a team by name and set attributes
  end

  def team_attributes=(team_attributes)
    self.team = Team.where(name: team_attributes[:name]).first_or_create do |t|
      t.hometown = team_attributes[:hometown]
    end
  end

=begin
Basically:

Foo.where(attributes).first_or_create

Is the same as:

Foo.find_or_create_by(attributes)

#first_or_create is sometimes misunderstood as people expect it to search by the attributes given, but that is not the case. Aka

Foo.first_or_create(attributes)

Will not search for a foo that satisfies the attributes. It will take the first foo if any are present. It's useful if the conditions for finding are a subset of those used for creation. Aka

Foo.where(something: value).first_or_create(attributes)

Will find the first foo where something: value. If none is present, it will use attributes to create it.
=end


end
