
ActiveRecord::Migration.verbose = false

ActiveRecord::Schema.define() do
  create_table 'addresses', force: :cascade do |t|
    t.string   'city'
    t.string   'street'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'credit_cards', force: :cascade do |t|
    t.string   'name'
    t.integer  'address_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_index 'credit_cards', ['address_id'], name: 'index_credit_cards_on_address_id'

  create_table 'orders', force: :cascade do |t|
    t.string   'name'
    t.integer  'address_id'
    t.datetime 'created_at',   null: false
    t.datetime 'updated_at',   null: false
  end

  add_index 'orders', ['address_id'], name: 'index_orders_on_assress_id'

  create_table 'users', force: :cascade do |t|
    t.string   'name'
    t.integer  'address_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_index 'users', ['address_id'], name: 'index_users_on_assress_id'
end
