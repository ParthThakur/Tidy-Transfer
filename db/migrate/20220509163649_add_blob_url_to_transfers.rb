class AddBlobUrlToTransfers < ActiveRecord::Migration[7.0]
  def change
    add_column :transfers, :blob_url, :string
  end
end
