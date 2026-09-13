class CreateCorePseudoscienceSchema < ActiveRecord::Migration[7.2]
  def change
    create_table :claims do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.string :category, null: false
      t.integer :verdict, null: false, default: 0
      t.integer :harm_score, null: false, default: 1
      t.text :scientific_summary, null: false
      t.text :regulatory_warning
      t.jsonb :origin_vectors

      t.timestamps
    end

    add_index :claims, :slug, unique: true
    add_index :claims, :category
    add_index :claims, :verdict
    add_index :claims, :harm_score

    create_table :evidence_citations do |t|
      t.references :claim, null: false, foreign_key: true, index: true
      t.string :source, null: false
      t.string :external_id
      t.string :title, null: false
      t.string :url, null: false
      t.text :conclusion

      t.timestamps
    end

    create_table :reports do |t|
      t.references :claim, foreign_key: true, null: true, index: true
      t.string :source_url
      t.text :claim_text, null: false
      t.string :platform
      t.integer :status, null: false, default: 0
      t.jsonb :metadata

      t.timestamps
    end

    add_index :reports, :status
  end
end
