class DiscountCalculator
	def discount_calculator
		@items = {
		  :milk => 3.97,
		  :bread => 2.17,
		  :banana => 0.99,
		  :apple => 0.89
		}

		@sale_items = { 
			:milk => { :quantity => 2, :amount => 5.00 },
			:bread => { :quantity => 3, :amount => 6.00 }
		}

		discount_prices = Hash.new
		actual_prices = Hash.new

		puts "Please enter all the items purchased separated by a comma"
		item_names = gets.chomp
		return if item_names.empty?
		
		cart_items = item_names.split(',').map(&:strip).map(&:downcase)
		
		cart_items.uniq.each do |item|
		discount_prices[item] = discount_price(item.to_sym, cart_items.count(item))
		actual_prices[item] = actual_price(item.to_sym, cart_items.count(item))
		end

		puts "Total price : $#{discount_prices.values.sum}"
		puts "You saved $#{sprintf("%.2f", actual_prices.values.sum - discount_prices.values.sum)} today."
	end

	def discount_price(item, quantity)
		total_price = 0

		if @sale_items.keys.include?(item)
			sale_quantity = @sale_items[item][:quantity]
			sale_price = (quantity / sale_quantity) * @sale_items[item][:amount]
			remaining_price = (quantity % sale_quantity) * @items[item]
			total_price = remaining_price + sale_price
		else
			total_price = @items[item] * quantity
		end

		total_price
	end

	def actual_price(item, quantity)
		total_price = 0

		if @items.keys.include?(item)
			total_price = @items[item] * quantity
		end

		return total_price
	end
end

discount_calculator = DiscountCalculator.new
calculate = discount_calculator.discount_calculator
