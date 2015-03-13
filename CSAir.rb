require './DirectedGraph'

class CSAir 
	@directed_g = DirectedGraph.new()

	@directed_g.parse()
	prompt = "> "
	instruction = "----------------------------------------------
					\nEnter 'list' for list of all the cities.
					\nEnter 'exit' to leave.
					\nEnter city code to obtain specific info.
					\nEnter 'LSF' for the longest single flight.
					\nEnter 'SSF' for the shortest single flight.
					\nEnter 'AVGD for the average distance of all the flights.
					\nEnter 'bPOP' for the biggest city by population.
					\nEnter 'sPOP' for the smallest city by population.
					\nEnter 'aPOP' for the average city by population.
					\nEnter 'continents' for list of all continents and cities.
					\nEnter 'hubs' for hub cities.
					\nEnter 'map' to generate route map.
					\nEnter 'rm city' to remove a city and it's routes.
					\nEnter 'rm route' to remove a route.
					\nEnter 'add city' to add a new city.
					\nEnter 'add route' to add a new route.
					\nEnter 'edit city' to edit existing city.
					\nEnter 'save' to save the network disk.
					\nEnter 'route info' to obtain information about a specific route.
					\nEnter 'shortest route' to obtain route info of the shortest route of two cities.
					\nEnter 'merge' to merge new data into the current network
					\n------------------------------------------"
	city_instruction = "Enter city name, country, continent, timezone, pop, region, code in order"
	edit_instruction = "\nEnter 1 to edit city-name
						\nEnter 2 to edit country
						\nEnter 3 to edit continent
						\nEnter 4 to edit timezone
						\nEnter 5 to edit pop
						\nEnter 6 to edit region
						\nIf editing several sections seperate the list of number by space"
	puts instruction
	print prompt

	while user_input = gets.chomp # loop while getting user input

		# list of all the cities that CSAir flies to
		if user_input == "list"
			puts @directed_g.list_cities()
			puts instruction
			print prompt # print the prompt, so the user knows to re-enter input

		# Get longest single flight
		elsif user_input == "LSF"
			puts @directed_g.longest_flight()
			puts instruction
			print prompt

		# Get shortest flight
		elsif user_input == "SSF"
			puts @directed_g.shortest_flight()
			puts instruction
			print prompt

		# Open browser to show route map
		elsif user_input == "map"
			url = @directed_g.route_map_url()
			system('open', url)
			puts instruction
			print prompt

		# specific information about a specific city
		elsif user_input.length == 3
			puts @directed_g.list_city_info(user_input)
			puts instruction
			print prompt # print the prompt, so the user knows to re-enter input

		# Get average distance of all flights
		elsif user_input == "AVGD"
			puts @directed_g.average_distance()
			puts instruction
			print prompt

		# Get city with the largest population
		elsif user_input == "bPOP"
			puts @directed_g.biggest_pop()
			puts instruction
			print prompt

		# Get city with the smallest population
		elsif user_input == "sPOP"
			puts @directed_g.smallest_pop()
			puts instruction
			print prompt

		# Get the average size of all the cities
		elsif user_input == "aPOP"
			puts @directed_g.avg_pop()
			puts instruction
			print prompt

		# List the continents with the relevant cities
		elsif user_input == "continents"
			puts @directed_g.list_continents()
			puts instruction
			print prompt

		# Get CSAir's hub cities
		elsif user_input == "hubs"
			puts @directed_g.hubs()
			puts instruction
			print prompt

		# Remove city
		elsif user_input == "rm city"
			puts "Enter city code"
			city = gets.chomp
			@directed_g.remove_city(city)

		#remove route
		elsif user_input == "rm route"
			puts "Enter route"
			route = gets.chomp
			@directed_g.remove_route(route)

		elsif user_input == "add city"
			puts city_instruction
			new_city = gets.chomp
			puts "Enter coordinates: "
			coords = gets.chomp
			@directed_g.add_city(new_city, coords)

		elsif user_input == "add route"
			puts "Enter city code - city code: "
			route = gets.chomp
			puts  "Enter distance: "
			distance = gets.chomp
			if(distance < 0 )
				puts "Invalid distance"
			else
				@directed_g.add_route(route, distance)
			end

		elsif user_input == "edit city"
			# edit pop
			puts "Enter city code to edit: "
			print prompt
			city = gets.chomp
			puts edit_instruction
			print prompt
			edit_number = gets.chomp.split(' ')
			edits = []
			print edit_number
			edit_number.each do |edit|
				if edit == "1"
					puts "\nEnter new city name: "
					edits << gets.chomp
				elsif edit == "2"
					puts "\nEnter new country: "
					edits << gets.chomp
				elsif edit == "3"
					puts "\nEnter new continent: "
					edits << gets.chomp
				elsif edit == "4"
					puts "\nEnter new timezone: "
					edits << gets.chomp
				elsif edit == "5"
					puts "\nEnter new pop: "
					edits << gets.chomp
				elsif edit == "6"
					puts "\nEnter new region: "
					edits << gets.chomp
				else
					puts "Please follow the instruction"
					puts edit_instruction
					print prompt
					break
				end
			end

			if @directed_g.edit_city(city, edit_number, edits)
				puts "edit complete!"
				print prompt	
			else 
				puts "edit failed!"
			  	print prompt
			end 

		elsif user_input == "save"
			@directed_g.generate_json()
			puts instruction
			print prompt

		elsif user_input == "route info"
			puts "Enter cities"
			cities = gets.chomp
			@directed_g.get_route_info(cities)
			puts instruction
			print prompt

		elsif user_input == "shortest route"
			puts "Enter two cities: "
			cities = gets.chomp
			@directed_g.shortest_route(cities)
			puts instruction
			print prompt

		elsif user_input == "merge"
			puts "Enter json file name:"
			input = gets.chomp
			@directed_g.merge_json(input)
			puts instruction
			print prompt

		# Exit from the interface
		elsif user_input == "exit" 
			puts "Good bye!"
			break

		# Ask for valid request if invalid
		else
			puts "Sorry what did you say? Enter input again please."
			puts instruction
			print prompt # print the prompt, so the user knows to re-enter input
		end
	end
end



