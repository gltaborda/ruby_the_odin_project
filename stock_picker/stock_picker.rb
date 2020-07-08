def stock_picker(price_array)
  best_buy_index = 0
  best_sell_index = 0
  best_possible_profit = 0
  price_array.each_index do |current_day|
    price_array.each_index do |selling_day|
      next if current_day > selling_day

      current_profit = (price_array[selling_day] - price_array[current_day])
      if best_possible_profit < current_profit
        best_possible_profit = current_profit
        best_buy_index = current_day
        best_sell_index = selling_day
      end
    end
  end
  [best_buy_index, best_sell_index]
end

p stock_picker([17, 3, 6, 9, 15, 8, 6, 1, 10])
