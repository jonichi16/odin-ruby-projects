def stock_picker(prices)

  buy_sell = []
  days_selected = []
  highest_profit = 0

  prices.combination(2) do |combination|
    buy_sell.push(combination)
  end

  buy_sell.each do |days|

    if (days[1] - days[0]) > highest_profit
      highest_profit = days[1] - days[0]
      days_selected = days
    end
  end
  
  days_selected = [prices.index(days_selected[0]), prices.index(days_selected[1])]

end

p stock_picker([17,3,6,9,15,8,6,1,10])
# => [1, 4]