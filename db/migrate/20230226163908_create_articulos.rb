class CreateArticulos < ActiveRecord::Migration[7.0]
  def change
    create_table :articulos do |t|
      t.string :title,
      t.text :description,
      t.integer :price,

      t.timestamps
    end
  end
end
