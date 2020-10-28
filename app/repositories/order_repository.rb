require_relative '../models/order'

class OrderRepository
  CSV_OPTIONS = { headers: :first_row, header_converters: :symbol }

  def initialize(csv_file, meal_repository, customer_repository, employee_repository)
    @csv_file = csv_file

    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository

    @orders = []
    load_csv if File.exist?(@csv_file)
    @next_id = @orders.empty? ? 1 : @orders.last.id + 1
  end

  def create(order)
    order.id = @next_id
    @next_id += 1
    @orders << order
    save_csv
  end

  def all
    @orders
  end

  def find(id)
    @orders.select { |order| order.id == id }.first
  end

  def undelivered_orders
    @orders.reject { |order| order.delivered? }
  end

  def save_csv
    CSV.open(@csv_file, 'wb', CSV_OPTIONS) do |file|
      file << %i[id meal_id customer_id employee_id delivered] # CSV HEADER

      @orders.each do |order|
        file << [order.id,
                 order.meal.id,
                 order.customer.id,
                 order.employee.id,
                 order.delivered?]
      end
    end
  end

  private

  def load_csv
    CSV.foreach(@csv_file, CSV_OPTIONS) do |row|

      meal = @meal_repository.find(row[:meal_id].to_i)
      customer = @customer_repository.find(row[:customer_id].to_i)
      employee = @employee_repository.find(row[:employee_id].to_i)

      order = Order.new(id: row[:id].to_i,
                        meal: meal,
                        customer: customer,
                        employee: employee,
                        delivered: row[:delivered] == 'true')
      @orders << order
    end
  end


end