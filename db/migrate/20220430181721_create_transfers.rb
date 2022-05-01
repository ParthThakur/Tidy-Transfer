class CreateTransfers < ActiveRecord::Migration[7.0]
  def change
    create_table :transfers do |t|
      t.string :title
      t.string :type
      t.text :description
      t.string :sharable_link
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
