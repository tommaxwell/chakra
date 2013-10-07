class UsersController < ApplicationController
	respond_to :json

	def show
		@user = User.find(params[:id])
		respond_to do |format|
			format.html
			format.json {render json: @user.as_json(include: [:folders, :submissions])}
		end
	end

end