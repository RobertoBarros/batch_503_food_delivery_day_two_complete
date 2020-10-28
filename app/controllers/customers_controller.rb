require_relative '../views/customers_view'

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @view = CustomersView.new
  end

  def add
    # Ask user customer name
    name = @view.ask_name
    # Ask user customer address
    address = @view.ask_address
    # create new customer
    new_customer = Customer.new(name: name, address: address)
    # Add customer to repository
    @customer_repository.create(new_customer)
  end

  def list
    # Get all customer from repository
    customers = @customer_repository.all
    # send to view
    @view.display(customers)
  end
end
