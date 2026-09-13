# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2026_09_13_142309) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "claims", force: :cascade do |t|
    t.string "title", null: false
    t.string "slug", null: false
    t.string "category", null: false
    t.integer "verdict", default: 0, null: false
    t.integer "harm_score", default: 1, null: false
    t.text "scientific_summary", null: false
    t.text "regulatory_warning"
    t.jsonb "origin_vectors"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_claims_on_category"
    t.index ["harm_score"], name: "index_claims_on_harm_score"
    t.index ["slug"], name: "index_claims_on_slug", unique: true
    t.index ["verdict"], name: "index_claims_on_verdict"
  end

  create_table "evidence_citations", force: :cascade do |t|
    t.bigint "claim_id", null: false
    t.string "source", null: false
    t.string "external_id"
    t.string "title", null: false
    t.string "url", null: false
    t.text "conclusion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["claim_id"], name: "index_evidence_citations_on_claim_id"
  end

  create_table "reports", force: :cascade do |t|
    t.bigint "claim_id"
    t.string "source_url"
    t.text "claim_text", null: false
    t.string "platform"
    t.integer "status", default: 0, null: false
    t.jsonb "metadata"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["claim_id"], name: "index_reports_on_claim_id"
    t.index ["status"], name: "index_reports_on_status"
  end

  add_foreign_key "evidence_citations", "claims"
  add_foreign_key "reports", "claims"
end
