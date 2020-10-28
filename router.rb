class Router
  def initialize(meals_controller, customers_controller, sessions_controller, orders_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @orders_controller = orders_controller
  end

  def run
    @employee = @sessions_controller.sign_in

    loop do
      if @employee.manager?
        print_actions_manager
        action = gets.chomp.to_i
        dispatch_action_manager(action)
      else
        print_actions_delivery_guy
        action = gets.chomp.to_i
        dispatch_action_delivery_guy(action)
      end
    end
  end

  private

  def print_actions_manager
    puts "1. Create Meal"
    puts "2. List all Meals"
    puts '-' * 80
    puts "3. Create Customer"
    puts "4. List all Customers"
    puts '-' * 80
    puts "5. Add new order"
    puts "6. List undelivered orders"
    puts '-' * 80
    puts "Enter your option:"
  end

  def print_actions_delivery_guy
    puts "1. List my undelivered orders"
    puts "2. Mark order as delivered"
    puts '-' * 80
    puts "Enter your option:"
  end

  def dispatch_action_manager(action)
    case action
    when 1 then @meals_controller.add
    when 2 then @meals_controller.list
    when 3 then @customers_controller.add
    when 4 then @customers_controller.list
    when 5 then @orders_controller.add
    when 6 then @orders_controller.list_undelivered_orders
    end
  end

  def dispatch_action_delivery_guy(action)
    case action
    when 1 then @orders_controller.list_my_orders(@employee)
    when 2 then @orders_controller.mark_as_delivered(@employee)
    end
  end

end