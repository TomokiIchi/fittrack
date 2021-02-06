class CreateBiometricData < ActiveRecord::Migration[6.0]
  def change
    create_table :biometric_data do |t|
      t.integer :heartrate
      t.integer :step_count
      t.float :height
      t.float :weight
      t.integer :distance
      t.integer :energy
      t.float :water
      t.integer :sleep
      t.timestamps
    end
  end
end
