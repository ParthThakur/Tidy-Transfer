class RenameTypeToFileTypeInTransfers < ActiveRecord::Migration[7.0]
  def change
    rename_column :transfers, :type, :file_type
  end
end
