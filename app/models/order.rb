class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  enum pay_type: {
    "Check" => "Check",
    "Credit card" => "Credit card",
    "Purchase order" => "Purchase order",
  }
  validates :name, :address, :email, :phone, presence: true
  validates :pay_type, inclusion: pay_types.keys
  validates :phone, numericality: true

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
end
