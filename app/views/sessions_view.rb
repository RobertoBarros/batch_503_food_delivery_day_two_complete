class SessionsView
  def ask_username
    puts 'Enter your username:'
    gets.chomp
  end

  def ask_password
    puts 'Enter your password:'
    gets.chomp
  end

  def welcome
    puts "Welcome to my Food Delivery!"
  end

  def wrong_credentials
    puts "Wrong credentials... try again."
  end
end
