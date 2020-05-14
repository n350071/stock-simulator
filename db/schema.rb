# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_13_234402) do

  create_table "month_simulations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "start_month_id"
    t.bigint "end_month_id"
    t.bigint "badget"
    t.string "strategy"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "total_badget", comment: "累積投入予算"
    t.integer "asset_ave", comment: "総資産の平均値"
    t.integer "asset_sigma", comment: "総資産の標準偏差"
    t.integer "asset_mean", comment: "総資産の中央値"
    t.string "strategy_params"
    t.index ["end_month_id"], name: "index_month_simulations_on_end_month_id"
    t.index ["start_month_id"], name: "index_month_simulations_on_start_month_id"
  end

  create_table "months", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.date "month_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "months_tf_stocks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "ticker_id"
    t.bigint "month_id"
    t.integer "open"
    t.integer "high"
    t.integer "low"
    t.integer "close"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "volume"
    t.index ["month_id"], name: "index_months_tf_stocks_on_month_id"
    t.index ["ticker_id"], name: "index_months_tf_stocks_on_ticker_id"
  end

  create_table "performances", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "report_id"
    t.bigint "month_id"
    t.bigint "total_asset"
    t.bigint "cash"
    t.integer "sum_valuation", comment: "保有銘柄の評価額"
    t.integer "sum_price", comment: "保有銘柄の買付額"
    t.integer "buy", comment: "今月の購入額"
    t.integer "sell", comment: "今月の売却額"
    t.integer "total_buy", comment: "累積の購入額"
    t.integer "total_sell", comment: "累積の売却額"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "ticker_count", comment: "保有銘柄数"
    t.index ["month_id"], name: "index_performances_on_month_id"
    t.index ["report_id"], name: "index_performances_on_report_id"
  end

  create_table "report_tickers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "report_id"
    t.bigint "ticker_id"
    t.bigint "price"
    t.integer "valuation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "month_id"
    t.index ["month_id"], name: "index_report_tickers_on_month_id"
    t.index ["report_id"], name: "index_report_tickers_on_report_id"
    t.index ["ticker_id"], name: "index_report_tickers_on_ticker_id"
  end

  create_table "reports", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "month_simulation_id"
    t.bigint "month_id"
    t.integer "term"
    t.bigint "total_asset"
    t.bigint "cash"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["month_id"], name: "index_reports_on_month_id"
    t.index ["month_simulation_id"], name: "index_reports_on_month_simulation_id"
  end

  create_table "tickers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "symbol"
    t.integer "market"
    t.integer "field33"
    t.integer "field17"
    t.integer "scale"
    t.datetime "reflashed_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_tickers_on_deleted_at"
  end

  add_foreign_key "month_simulations", "months", column: "end_month_id"
  add_foreign_key "month_simulations", "months", column: "start_month_id"
end
