class CreatePetitionen < ActiveRecord::Migration
  def change
    create_table :petitionen do |t|
      t.integer :user_id, :null => false
      t.datetime :datum_erstellt, :null => false
      t.datetime :datum_zuletzt_bearbeitet, :null => false
      t.datetime :datum_veroeffentlicht
      t.boolean :ist_zensiert, :null => false, :default => false
      t.datetime :datum_zensiert
      t.datetime :datum_entzensiert
      t.string :titel, :null => false
      t.text :inhalt, :null => false
      t.string :titel_zensiert
      t.text :inhalt_zensiert
      t.integer :anzahl_unterstuetzer_cached, :null => false, :default => 0
      t.integer :anzahl_dagegen_cached, :null => false, :default => 0
      t.integer :anzahl_spam_cached, :null => false, :default => 0

      t.timestamps
    end

    execute "alter table petitionen add foreign key (user_id) references users;"
  end
end
