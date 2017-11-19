require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "addresses_attributes" do
    params = {
      user: {
        email: "haha@example.com",
        addresses_attributes: {
          0 => {street_1: "Address 1 Street", address_type: "Home"},
          1 => {street_1: "Address 2 Street", address_type: "Business"}
        },
        team_name: "Existing Team Name",
        new_team_attributes: {
          name: "New Team Name",
          hometown: "Singapore"
        }
      }
    }
    user = User.new(params[:user])
    user.save

    assert_equal user.addresses.size, 2
    assert_equal user.addresses.first.street_1, "Address 1 Street"
    assert_equal user.addresses.first.address_type, "Home"

    assert_equal user.addresses.last.street_1, "Address 2 Street"
    assert_equal user.addresses.last.address_type, "Business"
  end

  
end
