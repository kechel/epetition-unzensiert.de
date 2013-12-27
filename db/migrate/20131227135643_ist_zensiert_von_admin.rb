class IstZensiertVonAdmin < ActiveRecord::Migration
  def change
    add_column :petitionen, :ist_zensiert_von_admin, :boolean, :null => false, :default => false
  end
end
