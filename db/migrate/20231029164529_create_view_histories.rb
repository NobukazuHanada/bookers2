class CreateViewHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :view_histories do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
