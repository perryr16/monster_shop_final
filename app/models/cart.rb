class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents || {}
    @contents.default = 0
  end

  def add_item(item_id)
    @contents[item_id] += 1
  end

  def less_item(item_id)
    @contents[item_id] -= 1
  end

  def count
    @contents.values.sum
  end

  def items
    @contents.map do |item_id, _|
      Item.find(item_id)
    end
  end

  def grand_total
    grand_total = 0.0
    @contents.each do |item_id, quantity|
      if active_discount(item_id).nil?
        grand_total += Item.find(item_id).price * quantity
      else
        grand_total += discount_price(item_id) * quantity
      end
    end
    grand_total
  end

  def count_of(item_id)
    @contents[item_id.to_s]
  end

  def subtotal_of(item_id)
    if active_discount(item_id).nil?
      @contents[item_id.to_s] * Item.find(item_id).price
    else 
      discount_subtotal(item_id)
    end
  end

  def limit_reached?(item_id)
    count_of(item_id) == Item.find(item_id).inventory
  end

  def active_discount(item_id)
    item = Item.find(item_id)
    item_quantity = @contents[item_id.to_s]
    active_discount = item.merchant.discounts.where('quantity <= ?', item_quantity)
                                            .order(percent: :desc)
                                            .limit(1)
                                            .first
  end

  def discount_price(item_id)
    return Item.find(item_id).price if active_discount(item_id).nil?
    price = (1 - active_discount(item_id).percent.to_f/100) * Item.find(item_id).price
  end

  def discount_subtotal(item_id)
    return subtotal_of(item_id) if active_discount(item_id).nil?
    discount_price(item_id) * @contents[item_id.to_s]
  end
end
