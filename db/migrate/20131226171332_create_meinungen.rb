class CreateMeinungen < ActiveRecord::Migration
  def change
    create_table :meinungen do |t|
      t.integer :user_id, :null => false
      t.integer :petition_id, :null => false
      t.datetime :datum, :null => false
      t.boolean :bin_unterstuetzer, :null => false, :default => false
      t.boolean :bin_dagegen, :null => false, :default => false
      t.boolean :ist_spam, :null => false, :default => false

      t.timestamps
    end
    execute "alter table meinungen add foreign key (user_id) references users;"
    execute "alter table meinungen add foreign key (petition_id) references petitionen;"
  end
end
