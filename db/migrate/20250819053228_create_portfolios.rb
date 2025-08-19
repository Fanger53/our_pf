class CreatePortfolios < ActiveRecord::Migration[8.0]
  def change
    create_table :portfolios do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :slug, null: false
      t.text :description
      t.string :template, default: 'default'
      t.boolean :is_public, default: false

      t.timestamps
    end
    
    add_index :portfolios, :slug, unique: true
    add_index :portfolios, [:user_id, :is_public]
  end
end
