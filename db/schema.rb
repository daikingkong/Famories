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

ActiveRecord::Schema.define(version: 2022_09_09_132949) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
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
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "end_users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_end_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_end_users_on_reset_password_token", unique: true
  end

  create_table "group_memories", force: :cascade do |t|
    t.integer "end_user_id", null: false
    t.integer "group_id", null: false
    t.string "title", null: false
    t.text "memo", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id", "end_user_id"], name: "index_group_memories_on_group_id_and_end_user_id"
  end

  create_table "group_users", force: :cascade do |t|
    t.integer "end_user_id", null: false
    t.integer "group_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id", "end_user_id"], name: "index_group_users_on_group_id_and_end_user_id", unique: true
  end

  create_table "groups", force: :cascade do |t|
    t.string "name", null: false
    t.text "introduction", null: false
    t.integer "owner_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_groups_on_name"
  end

  create_table "join_requests", force: :cascade do |t|
    t.integer "end_user_id", null: false
    t.integer "group_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id", "end_user_id"], name: "index_join_requests_on_group_id_and_end_user_id", unique: true
  end

  create_table "memories", force: :cascade do |t|
    t.integer "end_user_id", null: false
    t.string "title", null: false
    t.text "memo", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["end_user_id", "title"], name: "index_memories_on_end_user_id_and_title"
  end

  create_table "memory_comments", force: :cascade do |t|
    t.integer "end_user_id", null: false
    t.integer "memory_id", null: false
    t.text "comment", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["memory_id", "end_user_id"], name: "index_memory_comments_on_memory_id_and_end_user_id"
  end

  create_table "memory_favorites", force: :cascade do |t|
    t.integer "end_user_id", null: false
    t.integer "memory_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["end_user_id", "memory_id"], name: "index_memory_favorites_on_end_user_id_and_memory_id", unique: true
  end

  create_table "memory_search_tags", force: :cascade do |t|
    t.integer "memory_id"
    t.integer "memory_tag_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["memory_id", "memory_tag_id"], name: "index_memory_search_tags_on_memory_id_and_memory_tag_id", unique: true
    t.index ["memory_id"], name: "index_memory_search_tags_on_memory_id"
    t.index ["memory_tag_id"], name: "index_memory_search_tags_on_memory_tag_id"
  end

  create_table "memory_tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "memory_search_tags", "memories"
  add_foreign_key "memory_search_tags", "memory_tags"
end
