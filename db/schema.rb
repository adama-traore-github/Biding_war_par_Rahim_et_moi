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

ActiveRecord::Schema.define(version: 2024_09_14_155917) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "bids", force: :cascade do |t|
    t.decimal "amount"
    t.datetime "bid_date"
    t.bigint "user_id"
    t.bigint "product_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "end_time"
    t.string "image_url"
    t.datetime "finalized_at"
    t.index ["product_id"], name: "index_bids_on_product_id"
    t.index ["user_id"], name: "index_bids_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "faqs", force: :cascade do |t|
    t.string "question"
    t.text "answer"
    t.integer "role"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "parent_id"
    t.integer "answered_by_user_id"
    t.index ["user_id"], name: "index_faqs_on_user_id"
  end

  create_table "histories", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "user_id"
    t.decimal "bid_amount"
    t.datetime "bid_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_histories_on_product_id"
    t.index ["user_id"], name: "index_histories_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "user_id"
    t.text "message"
    t.string "notification_type"
    t.datetime "notification_date"
    t.boolean "viewed"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "product_id"
    t.decimal "amount"
    t.datetime "payment_date"
    t.string "payment_method"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_payments_on_product_id"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "category"
    t.decimal "initial_price"
    t.datetime "auction_start_date"
    t.datetime "auction_end_date"
    t.string "image"
    t.bigint "seller_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "category_id"
    t.index ["seller_id"], name: "index_products_on_seller_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "user_id"
    t.integer "rating"
    t.text "comment"
    t.datetime "review_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_reviews_on_product_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "address"
    t.string "phone_number"
    t.integer "role"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts"
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "last_request_at"
    t.integer "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.boolean "admin", default: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bids", "products"
  add_foreign_key "bids", "users"
  add_foreign_key "faqs", "users"
  add_foreign_key "histories", "products"
  add_foreign_key "histories", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "payments", "products"
  add_foreign_key "payments", "users"
  add_foreign_key "products", "users", column: "seller_id"
  add_foreign_key "reviews", "products"
  add_foreign_key "reviews", "users"
end
