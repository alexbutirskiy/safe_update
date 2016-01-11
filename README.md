# SafeUpdate
An ActiveReccord extender

## Usage
### Models
```ruby
class Address < ActiveRecord::Base
  has_many :users
  has_many :orders
end

class User < ActiveRecord::Base
  extend SafeUpdate
  belongs_to :address, safe_update: true
end

class Order < ActiveRecord::Base
  extend SafeUpdate
  belongs_to :address, safe_update: true
end
```
### Initializtion
```ruby
2.2.0 :001 > address = Address.create city: 'Dnipro', street: 'Pushkina'
 => #<Address id: 3, city: "Dnipro", street: "Pushkina", created_at: "2016-01-11 16:29:59", updated_at: "2016-01-11 16:29:59"> 
2.2.0 :002 > User.create name: 'Alex', address: address
 => #<User id: 3, name: "Alex", address_id: 3, created_at: "2016-01-11 16:30:31", updated_at: "2016-01-11 16:30:31"> 
2.2.0 :003 > Order.create name: 'First order', address: address
 => #<Order id: 3, name: "First order", address_id: 3, created_at: "2016-01-11 16:32:03", updated_at: "2016-01-11 16:32:03"> 
```

### Updating
```ruby
2.2.0 :009 > Order.last.address
 => #<Address id: 3, city: "Dnipro", street: "Pushkina", created_at: "2016-01-11 16:29:59", updated_at: "2016-01-11 16:29:59">
2.2.0 :005 > address = User.last.address
 => #<Address id: 3, city: "Dnipro", street: "Pushkina", created_at: "2016-01-11 16:29:59", updated_at: "2016-01-11 16:29:59"> 
2.2.0 :006 > address.update city: 'Dnipro City'
 => true 
2.2.0 :007 > address
 => #<Address id: 4, city: "Dnipro City", street: "Pushkina", created_at: "2016-01-11 16:29:59", updated_at: "2016-01-11 16:34:22"> 
2.2.0 :008 > User.last.address
 => #<Address id: 4, city: "Dnipro City", street: "Pushkina", created_at: "2016-01-11 16:29:59", updated_at: "2016-01-11 16:34:22"> 
2.2.0 :009 > Order.last.address
 => #<Address id: 3, city: "Dnipro", street: "Pushkina", created_at: "2016-01-11 16:29:59", updated_at: "2016-01-11 16:29:59"> 
```
###TODO
* Delete records without links
* Redefine ```#has_many``` class method to disable direct record changing (```Address.find(1).update```)