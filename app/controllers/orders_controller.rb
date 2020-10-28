require_relative '../views/orders_view'

class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository = order_repository

    @view = OrdersView.new
  end

  def add
    meals = @meal_repository.all
    @view.list_meals(meals)
    index = @view.ask_index
    meal = meals[index]

    customers = @customer_repository.all
    @view.list_customers(customers)
    index = @view.ask_index
    customer = customers[index]

    employees = @employee_repository.all_delivery_guys
    @view.list_employees(employees)
    index = @view.ask_index
    employee = employees[index]

    new_order = Order.new(meal: meal, customer: customer, employee: employee)
    @order_repository.create(new_order)
  end

  def list_undelivered_orders
    orders = @order_repository.undelivered_orders
    @view.display(orders)
  end

  def list_my_orders(employee)
    orders = @order_repository.undelivered_orders.select { |order| order.employee.id == employee.id }
    @view.display(orders)
  end

  def mark_as_delivered(employee)
    orders = @order_repository.undelivered_orders.select { |order| order.employee.id == employee.id }

    @view.list_orders(orders)
    index = @view.ask_index
    order = orders[index]

    order.deliver!
    @order_repository.save_csv



  end


end
