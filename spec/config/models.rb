class Address < ActiveRecord::Base
  has_many :credit_cards
  has_many :orders
  has_many :users
end

class Order < ActiveRecord::Base
  extend SafeUpdate
  belongs_to :address, safe_update: true
end

class CreditCard < ActiveRecord::Base
  extend SafeUpdate
  belongs_to :address, safe_update: true
end

class User < ActiveRecord::Base
  extend SafeUpdate
  belongs_to :address, safe_update: true
end
