class ProjectsController < ApplicationController
  def create
    @project = Project::Creator.new.perform
    render :show
  end
end
