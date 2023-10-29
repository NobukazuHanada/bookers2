class CreateDms < ActiveRecord::Migration[6.1]
  def change
    create_table :dms do |t|
      t.references :from, foreign_key: { to_table: :users }
      t.references :to, foreign_key: { to_table: :users }
      t.text :body

      t.timestamps
    end
  end
end
