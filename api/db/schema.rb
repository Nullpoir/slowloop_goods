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

ActiveRecord::Schema[7.0].define(version: 2022_10_08_141602) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "good_users", force: :cascade do |t|
    t.bigint "good_id", comment: "グッズID"
    t.bigint "user_id", comment: "ユーザーID"
    t.datetime "purchased_at", comment: "購入日"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["good_id", "user_id"], name: "index_good_users_on_good_id_and_user_id", unique: true
    t.index ["good_id"], name: "index_good_users_on_good_id"
    t.index ["user_id"], name: "index_good_users_on_user_id"
  end

  create_table "goods", force: :cascade do |t|
    t.string "name", comment: "名称"
    t.string "description", comment: "説明"
    t.string "isbn", comment: "ISBN番号"
    t.string "jan", comment: "JANコード"
    t.string "shopping_url", comment: "購入可能URL"
    t.datetime "released_at", comment: "発売日"
    t.datetime "production_ended_at", comment: "生産終了日"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "email", comment: "Email"
    t.boolean "is_admin", default: false, comment: "管理者フラグ"
    t.text "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

end
