class ProjectsController < ApplicationController

	def new
		@project = Project.new
	end

	def create
		puts params
		@project = Project.new(project_params)
		@project.save
		redirect_to root_path
	end

private
		def project_params
			params.require(:project).permit(:name)
		end

end
