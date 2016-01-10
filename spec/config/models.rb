class Address < ActiveRecord::Base
  has_many :credit_cards
  has_many :orders
  has_many :users
end

class Order < ActiveRecord::Base
  belongs_to :address
end

class CreditCard < ActiveRecord::Base
  belongs_to :address
end

class User < ActiveRecord::Base
  belongs_to :address
end
