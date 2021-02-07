class Detection < ApplicationRecord
  include Hashid::Rails

  has_one_attached :before_img
  has_one_attached :after_img

  def detect_objects
    ::Detect::DetectObjectsService.call(self)
  end
end
