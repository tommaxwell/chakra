class SubmissionsController < ApplicationController
	load_and_authorize_resource
	respond_to :json

	def create 

	    ajax_title = params[:title]
      ajax_content = params[:content]
      ajax_folder = params[:folder_id]
      ajax_parent = params[:parent_id]
      ajax_children = Array(params[:children])

      @submission = Submission.find_by_title(ajax_title)
      
      if ajax_title && @submission
          @submission.content = ajax_content
          @submission.save
      else
          @submission = Submission.create(
              :title=>ajax_title,
              :content=>ajax_content, 
              :user_id=>current_user.id, 
              :folder_id=>ajax_folder,
              :parent_id=>ajax_parent, 
              :children=>ajax_children,
          )
      end

    respond_to do |format|
      if @submission.save
        format.json { render :json => @submission.to_json }
      else
      end
    end
    
	end

	def new
		respond_to do |format|
			format.js
			format.html
		end
	end

	def show 
		respond_to do |format|
			format.js
			format.json {render json: @submission.as_json(:include =>[:children])}
			format.html 
		end
	end		

	def index
		render json: Submission.all
	end

	def edit
		respond_to do |format|
			format.html
			format.json { render json: @submission }
		end
	end

	def update
		[:title, :content].each do |attribute|
			params[attribute] = params["new_#{attribute}".to_sym] unless params["new_#{attribute}".to_sym].blank?
		end

		respond_to do |format|
			if @submission.update_attributes(params[:submission])
				format.html {redirect_to @submission, notice: "Submission updated."}
				format.json { render json: @submission}
			else
				format.html {render action: "edit"}
				format.json {render json: @submission.errors, status: :unprocessable_entity}
			end
		end
	end

	def usercontent
		@submissions = @user.submissions
		render json: @submissions
		respond_to :js
	end		

	def usersubmission
	  @submissions = @user.submissions
	  @submission = @submissions.find(params[:id])
	  render json: @submission
	end

	def parent
		@submission = Submission.find(params[:submission])
	end

	def new_submission
		@submission = Submission.find(params[:submission])
		respond_to do |format|
			format.html
			format.js
		end
	end


	def destroy 
		@submission.destroy
		redirect_to "/"
	end
  
  def create_submission_view
    respond_to do |format|
      format.js
      format.html
    end
  end
  
  def highlight_node
    @submission = Submission.find(params[:submission])
    respond_to do |format|
      format.js
      format.html
    end
  end

end
