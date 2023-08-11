class CreateLeads < ActiveRecord::Migration[7.0]
  def change
    create_table :leads do |t|
      t.references :user
      t.string :title
      t.string :description
      t.string :budget
      t.string :income
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
