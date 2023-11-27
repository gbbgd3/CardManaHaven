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

ActiveRecord::Schema[7.1].define(version: 2023_11_27_115519) do
  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.integer "resource_id"
    t.string "author_type"
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "card_faces", force: :cascade do |t|
    t.string "name"
    t.string "mana"
    t.string "type_line"
    t.string "oracle_text"
    t.integer "power"
    t.integer "toughness"
    t.string "image"
    t.string "flavour_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "m_sets", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.date "release_date"
    t.integer "card_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mcfs", force: :cascade do |t|
    t.integer "mtg_id", null: false
    t.integer "card_face_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_face_id"], name: "index_mcfs_on_card_face_id"
    t.index ["mtg_id"], name: "index_mcfs_on_mtg_id"
  end

  create_table "mtgs", force: :cascade do |t|
    t.string "name"
    t.string "mana"
    t.string "type_line"
    t.string "oracle_text"
    t.string "flavour_text"
    t.integer "artist_id", null: false
    t.string "layout"
    t.integer "power"
    t.string "toughness"
    t.integer "m_set_id", null: false
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_mtgs_on_artist_id"
    t.index ["m_set_id"], name: "index_mtgs_on_m_set_id"
  end

  create_table "products", force: :cascade do |t|
    t.integer "category_id"
    t.integer "price_cents"
    t.integer "sale_price_cents"
    t.text "product_detail"
    t.string "image_url"
    t.integer "stock"
    t.string "product_name"
    t.string "brand"
    t.string "productable_type"
    t.integer "productable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["productable_type", "productable_id"], name: "index_products_on_productable"
    t.index ["productable_type", "productable_id"], name: "product_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "yugioh_card_sets", force: :cascade do |t|
    t.integer "yugioh_card_id"
    t.integer "yugioh_set_id"
    t.string "set_code"
    t.string "set_rarity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["yugioh_card_id", "yugioh_set_id"], name: "unique_card_set_index", unique: true
    t.index ["yugioh_card_id"], name: "index_yugioh_card_sets_on_yugioh_card_id"
    t.index ["yugioh_set_id"], name: "index_yugioh_card_sets_on_yugioh_set_id"
  end

  create_table "yugioh_cards", force: :cascade do |t|
    t.integer "card_id"
    t.string "name"
    t.string "card_type"
    t.integer "level"
    t.string "attribute_of_card"
    t.string "archetype"
    t.text "description_of_card"
    t.integer "atk"
    t.integer "def"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "yugioh_sets", force: :cascade do |t|
    t.integer "set_id"
    t.string "set_name"
    t.string "set_code"
    t.date "release_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "mcfs", "card_faces"
  add_foreign_key "mcfs", "mtgs"
  add_foreign_key "mtgs", "artists"
  add_foreign_key "mtgs", "m_sets"
  add_foreign_key "yugioh_card_sets", "yugioh_cards"
  add_foreign_key "yugioh_card_sets", "yugioh_sets"
end
