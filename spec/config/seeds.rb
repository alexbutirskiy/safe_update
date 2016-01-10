Address.create!([
  { city: "Dnipro", street: nil },
  { city: "Kyiv", street: nil }
])

CreditCard.create!([
  { name: 'Credit Card #1', address_id: 1 },
  { name: 'Credit Card #2', address_id: 2 }
])

Order.create!([
  { name: "First order", address_id: 1 },
  { name: "Second order", address_id: 2 }
])

User.create!([
  { name: "Alex", address_id: 1 },
  { name: "Olha", address_id: 1 }
])