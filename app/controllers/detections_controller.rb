class DetectionsController < ApplicationController
  def index; end

  def new
    @detection = Detection.new
  end

  def create
    detection = Detection.create!
    detection.before_img.attach(params[:detection][:before])
    detection.detect_objects
    redirect_to detection_path(detection.hashid)
  end

  def show
    @detection = Detection.find(params[:id])
    @before = @detection.before_img
    @after = @detection.after_img
  end

  private

  def detection_params
    params.require(:detection).permit(:before)
  end
end
