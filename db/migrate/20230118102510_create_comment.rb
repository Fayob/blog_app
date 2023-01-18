class CreateComment < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.string :text

      t.timestamps
    end
  end
  add_reference :comments, :user, null: false, foreign_key: true
  add_reference :comments, :post, null: false, foreign_key: true
end
