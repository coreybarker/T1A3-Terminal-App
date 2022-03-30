require 'rainbow'
require 'tty-prompt'
require_relative './runsheet'

job_items = { mopping: "Incomplete", sweeping: "Incomplete" }
runsheet = RunSheet.new("Incomplete Jobs", job_items)

clear
puts
puts Header
puts Rainbow("Welcome to the virtual Job Run Sheet!").orange.center(Header_length)
puts Header
puts
print "Login require -- Type " + Rainbow("Login").green + " to continue: "

login_attempts = 0
while login_attempts < 3
    get_login = gets.chomp.capitalize

    if get_login == ""
        login_attempts += 1
        if login_attempts == 3
            clear
            puts "Application ending, retart to try again..."
        else
            puts "Incorrect login, please try again: "
        end
    else
        clear
        break
    end
end

runsheet.welcome
runsheet.print_list
puts
puts ""
# loop do
#     puts
#     puts
# end
