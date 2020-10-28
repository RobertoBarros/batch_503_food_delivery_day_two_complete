class MealsView

  def ask_name
    puts 'Enter meal name'
    gets.chomp
  end

  def ask_price
    puts 'Enter meal price'
    gets.chomp.to_i
  end

  def display(meals)
    meals.each do |meal|
      puts "#{meal.name} - $#{meal.price}"
    end
  end

end