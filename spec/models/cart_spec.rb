require "rails_helper"

describe Cart do
  let(:category) do
    Category.create(name: "Plants",
                    description: "Plants category description",
                    slug: "plants")
  end

  let(:product) do
    category.products.create(name:        "Plant 1",
                             description: "Plant 1 description",
                             price:       29.99)
  end

  context "#cart_items" do
    it "returns an array of CartItems" do
      data = Hash.new(0)
      data[product.id] = 2
      cart = Cart.new(data)

      expect(cart.cart_items.first).to be_a_kind_of(CartItem)
    end
  end

  context "#items" do
    it "returns an array of Products" do
      data = Hash.new(0)
      data[product.id] = 2
      cart = Cart.new(data)

      expect(cart.items.first).to be_a_kind_of(Product)
    end
  end

  context "#data" do
    it "returns a hash with the product id and quantity" do
      input_data = {}
      input_data[product.id.to_s] = 2
      cart = Cart.new(input_data)

      expect(cart.data).to eq(product.id.to_s => 2)
    end
  end

  context "#add_item" do
    it "updates the data method when a product is added" do
      cart = Cart.new(nil)
      cart.add_item(product)
      expect(cart.data).to eq(product.id.to_s => 1)

      cart.add_item(product)
      expect(cart.data).to eq(product.id.to_s => 2)
    end
  end

  context "#update_item_quantity" do
    it "updates the data method when a product is added" do
      input_data = {}
      input_data[product.id.to_s] = 2
      cart = Cart.new(input_data)

      expect(cart.data).to eq(product.id.to_s => 2)

      cart.update_item_quantity(product, 4)
      expect(cart.data).to eq(product.id.to_s => 4)
    end
  end

  context "#delete_item" do
    it "removes the product from data" do
      input_data = {}
      input_data[product.id.to_s] = 2
      cart = Cart.new(input_data)

      expect(cart.data).to eq(product.id.to_s => 2)

      cart.delete_item(product)
      expect(cart.data).to eq({})
    end
  end

  context "#total_price" do
    it "returns the total price for the cart" do
      cart = Cart.new(nil)
      cart.add_item(product)
      cart.add_item(product)

      expect(cart.total_price).to eq(59.98)
    end
  end
end
