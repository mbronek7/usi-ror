require 'mini_magick'
require 'numo/narray'
require 'onnxruntime'

module Detect
  class DetectObjectsService < BaseService
    attr_accessor :detection, :model, :labels
    SFloat = Numo::SFloat

    def initialize(detection)
      @detection = detection
      @model = OnnxRuntime::Model.new(Rails.root.join('app', 'services', 'detect', 'yolov3.onnx'))
      @labels = File.readlines(Rails.root.join('app', 'services', 'detect', 'coco-labels-2014_2017.txt'))
    end

    def call
      process(detection.before_img)
    end

    private

    def process(image)
      img = MiniMagick::Image.read(image.download)
      image_size = [[img.height, img.width]]
      image_preprocessing(img)
      img_data = SFloat.cast(img.get_pixels)
      img_data /= 255.0
      output = predict(model, get_image_data(img_data), image_size)
      boxes, scores, indices = output.values
      results = get_results(indices, scores, boxes)
      draw_after_image(img, results, image)
    end

    def predict(model, image_data, image_size)
      model.predict({input_1: image_data, image_shape: image_size})
    end

    def get_image_data(img_data)
      img_data.transpose(2, 0, 1)
              .expand_dims(0)
              .to_a
    end

    def image_preprocessing(img)
      img.combine_options do |b|
        b.resize '416x416'
        b.gravity 'center'
        b.background 'transparent'
        b.extent '416x416'
      end
    end

    def get_results(indices, scores, boxes)
      indices.map do |idx|
        { class: idx[1],
          score: scores[idx[0]][idx[1]][idx[2]],
          box: boxes[idx[0]][idx[2]] }
      end
    end

    def draw_after_image(img, results, image)
      img = MiniMagick::Image.open(image)
      img.colorspace 'gray'
      results.each do |r|
        hue = r[:class] * 100 / 80.0
        label = labels[r[:class]]
        score = r[:score]
        y1, x1, y2, x2 = r[:box].map(&:round)
        img.combine_options do |c|
          c.draw        "rectangle #{x1}, #{y1}, #{x2}, #{y2}"
          c.fill        "hsla(#{hue}%, 20%, 80%, 42%)"
          c.stroke      "hsla(#{hue}%, 70%, 60%, 60%)"
          c.strokewidth (score * 3).to_s
        end
        img.combine_options do |c|
          c.draw "text #{x1}, #{y1 - 5} \"#{label}\""
          c.fill 'white'
          c.pointsize 18
        end
      end
      file = Tempfile.new('foo')
      img.write file.path
      detection.after_img.attach(io: File.open(file.path), filename: "detect.jpg", content_type: "image/jpg")
    end
  end
end
