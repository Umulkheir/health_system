class CreateVerifications < ActiveRecord::Migration[5.0]
  def change
    create_table :verifications do |t|
      t.string :phone_number
      t.string :verification_code
      t.boolean :verified, default: false

      t.timestamps
    end
  end
end
