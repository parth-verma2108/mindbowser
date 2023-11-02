class DiscountCalculator
  def initialize
    @items = {
      milk: 3.97,
      bread: 2.17,
      banana: 0.99,
      apple: 0.89
    }

    @sale_items = {
      milk: {
      	quantity: 2,
      	amount: 5.00 
      },
      bread: {
      	quantity: 3,
      	amount: 6.00 
      }
    }
  end

  def calculate_discount
    discount_prices = {}
    actual_prices = {}

    puts "Please enter all the items purchased separated by a comma"
    item_names = gets.chomp
    return if item_names.empty?

    cart_items = item_names.split(',').map(&:strip).map(&:downcase)

    cart_items.uniq.each do |item|
      discount_prices[item] = calculate_item_discount(item, cart_items.count(item))
      actual_prices[item] = calculate_item_price(item, cart_items.count(item))
    end

    display_cart_summary(discount_prices, cart_items)
    total_discount = actual_prices.values.sum - discount_prices.values.sum
    puts "You saved $#{sprintf('%.2f', total_discount)} today."
  end

  private

  def calculate_item_discount(item, quantity)
    if @sale_items.key?(item)
      sale_quantity = @sale_items[item][:quantity]
      sale_price = (quantity / sale_quantity) * @sale_items[item][:amount]
      remaining_price = (quantity % sale_quantity) * @items[item]
      remaining_price + sale_price
    elsif @items.key?(item)
      @items[item] * quantity
    else
      0
    end
  end

  def calculate_item_price(item, quantity)
    @items.key?(item) ? ( @items[item] * quantity ) : 0
  end

  def display_cart_summary(discount_prices, cart_items)
    puts ''
    puts 'Item     Quantity      Price'
    puts '----------------------------'
    discount_prices.keys.each do |item|
      puts "#{item}      #{cart_items.count(item)}            $#{sprintf('%.2f', discount_prices[item])}"
    end
    puts ''
    puts "Total price : $#{sprintf('%.2f', discount_prices.values.sum)}"
  end
end

discount_calculator = DiscountCalculator.new
discount_calculator.calculate_discount
