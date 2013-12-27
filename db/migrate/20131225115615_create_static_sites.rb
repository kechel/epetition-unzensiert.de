class CreateStaticSites < ActiveRecord::Migration
  def change
    create_table :static_sites do |t|
      t.string :url, :null => false
      t.string :title
      t.string :description
      t.string :keywords
      t.text :html, :null => false

      t.timestamps
    end
  end
end
