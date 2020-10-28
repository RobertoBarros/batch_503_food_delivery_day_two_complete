require_relative '../views/meals_view'

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @view = MealsView.new
  end

  def add
    # Ask user meal name
    name = @view.ask_name
    # Ask user meal price
    price = @view.ask_price
    # create new meal
    new_meal = Meal.new(name: name, price: price)
    # Add meal to repository
    @meal_repository.create(new_meal)
  end

  def list
    # Get all meal from repository
    meals = @meal_repository.all
    # send to view
    @view.display(meals)
  end

end