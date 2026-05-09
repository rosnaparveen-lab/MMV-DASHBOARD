class AddDownloadDetailsToDownloadLogs < ActiveRecord::Migration[7.1]
  def change
    add_column :download_logs, :downloaded_item, :string
    add_column :download_logs, :downloaded_filename, :string
    add_column :download_logs, :duration_seconds, :float
  end
end
