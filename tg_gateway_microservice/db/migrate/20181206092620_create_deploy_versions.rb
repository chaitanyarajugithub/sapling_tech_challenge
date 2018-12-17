class CreateDeployVersions < ActiveRecord::Migration[5.2]
  def change
    create_table :deploy_versions do |t|
      t.string :app_name
      t.text :version_number
      t.timestamps
    end
  end
end
