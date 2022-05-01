class AddSharedToTransfer < ActiveRecord::Migration[7.0]
  def change
    add_column :transfers, :shared, :boolean, :default => false
  end
end
