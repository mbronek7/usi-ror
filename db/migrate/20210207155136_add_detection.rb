class AddDetection < ActiveRecord::Migration[6.0]
  def change
    create_table :detections do |t|
      t.timestamps
    end

  end
end
