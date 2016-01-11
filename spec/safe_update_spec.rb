RSpec.describe SafeUpdate do
  context ".belongs_to" do
  # describe 'has self.extended hook'
  # describe 'has .belongs_to method'
  # describe 'has .belongs_to method'
  # describe 'has .belongs_to_generator private method'

    let(:new_city) { Faker::Address.city }
    let(:new_street) { Faker::Address.street_name }

    before(:all) do
      class Address < ActiveRecord::Base
        extend SafeUpdate
        has_many :users
        has_many :orders
        has_many :credit_cards
      end

      class User < ActiveRecord::Base
        extend SafeUpdate
        belongs_to :address, safe_update: true
      end

      class Order < ActiveRecord::Base
        extend SafeUpdate
        belongs_to :address
      end

      class CreditCard < ActiveRecord::Base
        belongs_to :address
      end
    end

    before(:each) do
      @user = User.create(name: Faker::Name.name)
      @user.create_address(
        city: Faker::Address.city, 
        street: Faker::Address.street_name )
      @order = Order.create(name: Faker::Commerce.product_name)
      @order.create_address(
        city: Faker::Address.city, 
        street: Faker::Address.street_name )
    end


    
    context "when #update calling and { safe_update:true } is passed" do
      it "upadates requested attributes" do
        address = @user.address
        expect{ address.update(city: new_city) }
          .to change{ address.city }.to(new_city)

        expect { address.update(street: new_street) }
          .to change{ address.street }.to(new_street)
      end

      it "upadates 'updated_at' attribute" do
        address = @user.address
        expect{ address.update(city: new_city) }
          .to change{ address.updated_at }
      end

      it "upadates 'id' attribute" do
        expect{ @user.address.update(city: new_city) }
          .to change{ @user.address.id }
      end

      it "keeps other attributes unchganged" do
        address = @user.address
        attr_before = address.attributes.except("id", "updated_at", "city")
        address.update(city: new_city)
        attr_after = address.attributes.except("id", "updated_at", "city")
        expect(attr_after).to eq(attr_before)
      end

      it "really creates new record" do
        address = @user.address
        address.update(city: new_city)
        expect(Address.find(address.id)).to eq(address)
      end

      it "correctly updates referense key of dependent model" do
        address = @user.address
        expect { address.update(city: new_city) }.to change { @user.address.id }
        expect(@user.address.id).to eq(address.id)
      end

      it "doesn't change previous record" do
        address = @user.address
        id = address.id
        expect{ address.update(city: new_city) }.to_not change{ Address.find(1) }
      end
    end

    context "when #update calling and { safe_update:true } is not passed" do
      it "keeps id unchanged on update" do
        expect{ @order.address.update(city: 'New city') }
          .to_not change{ @order.address.id }
      end
    end
  end
end