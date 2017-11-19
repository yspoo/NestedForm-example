class UsersController < ApplicationController

  def new
    @user = User.new

    # has_many adds <collection>.build
    # where the collection is "addresses".
    @user.addresses.build(address_type: "Home")
    @user.addresses.build(address_type: "Business")
    @user.addresses.build(address_type: "Spacedress")

    @user.build_team  # belongs_to:  .build_<association>
                      # belongs to adds build association
                      # when there is a belongs_to relationship, you use .build_<association> because user belongs to team.

    # @user.addresses.build(address_type: "Home") will give you the box to fill in the user home address. It looks the same as the box for business address because they share the same form. However, this box has address_type of "Home" data in it, whereas the box for business has address_type of "Business" data in it.

    # If you want more boxes simply type in more build statements, for example:
    #   @user.addresses.build(city: "Singapore")
    # will give you another box with the city attribute of value "Singapore" filled in.

    # The order in which these build statements are typed in the "new" method matters because they determine what data(attribute) each box holds.
  end

  def create
    # raise params.inspect
    @user = User.new(user_params)

    # is the same as:
    # @user = User.new
    # @user.addresses_attributes=(params[:user][:addresses_attributes])

    if @user.save
      redirect_to @user   #   users/#{@user.id}
    else
      render "new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, addresses_attributes: [:street_1, :street_2, :address_type], team_attributes: [:name, :hometown])
  end

end

# the controller push the data from forms into the model.
