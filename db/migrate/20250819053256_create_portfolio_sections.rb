class CreatePortfolioSections < ActiveRecord::Migration[8.0]
  def change
    create_table :portfolio_sections do |t|
      t.references :portfolio, null: false, foreign_key: true
      t.string :section_type, null: false
      t.string :title
      t.text :content
      t.integer :position, default: 0
      t.text :settings

      t.timestamps
    end
    
    add_index :portfolio_sections, [:portfolio_id, :position]
    add_index :portfolio_sections, :section_type
  end
end
