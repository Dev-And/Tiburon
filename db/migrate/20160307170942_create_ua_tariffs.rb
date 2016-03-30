class CreateUaTariffs < ActiveRecord::Migration
  def change
    create_table :ua_tariffs do |t|
      t.integer :load_up_to_2t
      t.integer :load_up_to_5t
      t.integer :load_up_to_10t
      t.integer :load_up_to_20t
      t.timestamps null: false
    end
  end
end
