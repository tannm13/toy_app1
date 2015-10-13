class CommentsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_user, only: :destroy

	def create
		@comment = current_user.comments.build(comment_params)
		@comment.entry = Entry.find(params[:entry_id])
		if @comment.save
			#flash[:success] = "Comment posted!"
			respond_to do |format|
				format.html { redirect_to @comment.entry }
				format.js
			end
			
			#redirect_to @comment.entry
		else
			redirect_to @comment.entry
		end
	end

	def destroy
		@comment.destroy
		#flash[:success] = "Comment deleted!"
		#redirect_to @comment.entry
		respond_to do |format|
			format.html { redirect_to @comment.entry }
			format.js
		end
	end

	private 
	def comment_params
		params.require(:comment).permit(:content)
	end

	def correct_user
		@comment = current_user.comments.find_by(id: params[:id])
		redirect_to root_url if @comment.nil?
	end
end
