class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.date :game_date
      t.string :opponent
      t.string :comment
      t.integer :price
      t.string :place
      t.integer :user_id

      t.timestamps
    end
  end
end
