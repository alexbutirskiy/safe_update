RSpec.describe SafeUpdate do
  context ".belongs_to" do
  # describe 'has self.extended hook'
  # describe 'has .belongs_to method'
  # describe 'has .belongs_to method'
  # describe 'has .belongs_to_generator private method'

    before do
      class Address < ActiveRecord::Base
        #extend SafeUpdate
        has_many :users
      end
    end

    context "when { safe_update:true } is not passed" do
      context "doesn't change standart behavior:" do
        before do
          class User < ActiveRecord::Base
            extend SafeUpdate
            belongs_to :address
          end
          @user = User.create
          @user.create_address
        end

        it "keeps id unchanged on update" do
          expect{ @user.address.update(city: 'New city') }
            .to_not change{ @user.address.id }
        end
      end
    end
    
    context "when { safe_update:true } is passed" do
      context "changes standart behavior:" do
        before do
          class User < ActiveRecord::Base
            extend SafeUpdate
            belongs_to :address, safe_update: true
          end
          @user = User.create
          @user.create_address
        end

        it "changes id on update" do
          expect{ @user.address.update(city: 'New city') }
            .to change{ @user.address.id }
        end
      end
    end
  end
end