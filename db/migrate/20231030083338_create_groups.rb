class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string :name
      t.text :introduction
      t.references :owner, foreign_keys: { to_table: :group_user }

      t.timestamps
    end
  end
end
