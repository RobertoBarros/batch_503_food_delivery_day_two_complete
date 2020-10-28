class OrdersView
  def list_meals(meals)
    meals.each_with_index do |meal, index|
      puts "#{index + 1} - #{meal.name} $#{meal.price}"
    end
  end

  def list_customers(customers)
    customers.each_with_index do |customer, index|
      puts "#{index + 1} - #{customer.name} - Address: #{customer.address}"
    end
  end

  def list_employees(employees)
    employees.each_with_index do |employee, index|
      puts "#{index + 1} - #{employee.username}"
    end
  end

  def list_orders(orders)
    orders.each_with_index do |order, index|
      puts "#{index + 1} - #{order.meal.name} to #{order.customer.name} delivery by #{order.employee.username}"
    end
  end


  def ask_index
    puts 'Enter index:'
    gets.chomp.to_i - 1
  end

  def display(orders)
    orders.each do |order|
      puts "Order #{order.id}: #{order.meal.name} to #{order.customer.name} delivery by #{order.employee.username}"
    end
  end
end
