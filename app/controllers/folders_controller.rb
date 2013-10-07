class FoldersController < ApplicationController
	load_and_authorize_resource
	respond_to :json

	def new
		respond_to do |format|
			format.js
			format.html
		end
	end

	def ajax_load_events
		respond_to do |format|
			format.html
			format.js
		end
	end

	def create
		@folder = Folder.where(title: params[:title]).first_or_create(
			title: params[:title],
			user_id: params[:user_id],
			parent_id: params[:parent_id]
			)
		@folder.user = current_user
		if @folder.save
			redirect_to :back, flash: {notice: "Folder successfully created."}
		else
			flash.now[:notice] = "Error"
		end
	end

	def show
		respond_to do |format|
			format.html
			format.js
      format.json {render :json => @folder.as_json( :include => [:submissions, :children])}
		end
	end

	def index
		if params[:search]
			@folders = Folder.search(params[:search]).order("created_at DESC")
		else
			@folders = Folder.order("created_at DESC")
		end
	end

	def update
		[:title].each do |attribute|
			params[attribute] = params["new_#{attribute}".to_sym] unless params["new_#{attribute}".to_sym].blank?
		end

		respond_to do |format|
			if @folder.update_attributes(params[:folder])
				format.html 
				format.json {render json: @folder}
			else
				format.html {render action: "edit"}
				format.json {render json: @folder.errors, status: :unprocessable_entity}
			end
		end
	end


	def destroy 
		@folder.destroy
		redirect_to "/"
	end

end