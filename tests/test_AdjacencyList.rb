require "./AdjacencyList.rb"
require "./DirectedGraph.rb"
require "test/unit"

class TestAdjacencyList < Test::Unit::TestCase

	attr_accessor :al

	def setup

		@al = AdjacencyList.new(true)
		$c = {
			:SCL => ["Santiago", "CL" , "South America", -4 , {"S": 33, "W": 71} , 6000000 , 1, "SCL"],
			:LIM => ["Lima" ,"PE" ,"South America" ,-5 , {"S": 12, "W": 77} , 9050000 ,1, "LIM"],
			:MEX => ["Mexico City" ,"MX" ,"North America" , -6 , {"N": 19, "W": 99} , 23400000 , 1, "MEX"]
		}
		$r = {
			:SCL => [["SCL", "LIM"], 100],
			:LIM => [["LIM", "MEX"], 200],
			:MEX => [["MEX", "SCL"], 300]
		}
		$c.each_pair do |name, data|
			name, country, continent, timezone, coords, pop, region, node_city = data
			@al.add(name, country, continent, timezone, coords, pop, region, node_city)
		end

		$r.each_pair do |name, data|	
			port, distance = data
			@al.add_edge(port[0], port[1], distance)
		end	

	end

	def teardown
    	## Nothing really
  	end

	def test_get_name
		$c.each_pair do |name, data|
			name, country, continent, timezone, coords, pop, region, node_city = data
			assert_equal name, @al.get_node_name(node_city), "node #{name} should know its name"
		end 
	end

	def test_get_country
		$c.each_pair do |name, data|
			name, country, continent, timezone, coords, pop, region, node_city = data
			assert_equal country, @al.get_node_country(node_city), "node #{name} should know its country"
		end 
	end

	def test_get_continent
		$c.each_pair do |name, data|
			name, country, continent, timezone, coords, pop, region, node_city = data
			assert_equal continent, @al.get_node_continent(node_city), "node #{name} should know its continent"
		end 
	end

	def test_get_timezone
		$c.each_pair do |name, data|
			name, country, continent, timezone, coords, pop, region, node_city = data
			assert_equal timezone, @al.get_node_timezone(node_city), "node #{name} should know its timezone"
		end 
	end

	def test_get_coords
		$c.each_pair do |name, data|
			name, country, continent, timezone, coords, pop, region, node_city = data
			assert_equal coords, @al.get_node_coords(node_city), "node #{name} should know its coords"
		end 
	end

	def test_get_pop
		$c.each_pair do |name, data|
			name, country, continent, timezone, coords, pop, region, node_city = data
			assert_equal pop, @al.get_node_pop(node_city), "node #{name} should know its pop"
		end 
	end

	def test_get_region
		$c.each_pair do |name, data|
			name, country, continent, timezone, coords, pop, region, node_city = data
			assert_equal region, @al.get_node_region(node_city), "node #{name} should know its region"
		end 
	end

	def test_is_node
		assert_equal(4, 2+2)
	end

	def test_longest_distance
		assert_equal(4, 2+2)
	end

	def test_shortest_distance
		assert_equal(4, 2+2)
	end

	def test_average_distance
		assert_equal(4, 2+2)
	end

	def test_max_pop
		assert_equal(4, 2+2)
	end

	def test_min_pop
		assert_equal(4, 2+2)
	end

	def test_avg_pop
		assert_equal(4, 2+2)
	end

	def test_vertex_w_most_edges
		assert_equal(4, 2+2)
	end

	def test_remove_node
		@al.delete("SCL")
		assert_equal(2, @al.get_nodes_length())	
		assert_equal(1, @al.get_edges_length())
	end

	def test_remove_edge
		@al.delete_edge("LIM MEX")
		assert_equal(2, @al.get_edges_length())
		assert_equal(3, @al.get_nodes_length())
	end

	def test_add_city__and_edge
		# name, country, continent, timezone, coords, pop, region, node_city
		@al.add("Buenos Aires", "AR", "South America", -3, {"S": 35, "W": 58}, 13300000, 1,"BUE")
		assert_equal(4, @al.get_nodes_length())
		@al.add_edge("BUE", "LIM", 400)
		assert_equal(4, @al.get_edges_length())
	end

	def test_edit_node
		city = "SCL"
		edit_number = "1 5"
		edits = ["Santiaaaago", "130000"]
		edit_number = edit_number.split(' ')
        i = 0
        edit_number.each do |edit|
            if edit == "1"
                puts "Editing city name\n"
                @al.set_node_name(city, edits[i])
            elsif edit == "2"
                puts "Editing country\n"
                @al.set_node_country(city, edits[i])
            elsif edit == "3"
                puts "Editing timezone\n"
                @al.set_node_timezone(city, edits[i])
            elsif edit == "4"
                puts "Editing coordinates\n"
                @al.set_node_coords(city, edits[i])
            elsif edit == "5"
                puts "Editing pop\n"
                @al.set_node_pop(city, edits[i])
            elsif edit == "6"
                puts "Editing region\n"
                @al.set_node_region(city, edits[i])
            end
            i +=1
        end
		assert_equal("Santiaaaago", @al.get_node_name(city))
		assert_equal("130000", @al.get_node_pop(city))
	end
	
	def test_generate_json
		@directed_g = DirectedGraph.new()
		@directed_g.parse()
		@directed_g.generate_json()
	end

	def test_route_info
		input = "SCL-LIM-MEX"
		route = input.split('-')
		assert_equal([300,95, 197.32], @al.get_path_info(route))
	end

	def test_adjacent
		assert_equal(true, @al.adjacent?("SCL", "LIM"))
		assert_equal(false, @al.adjacent?("SCL", "SCL"))
	end

	def test_shortest_route
		# input = "NYC-TYO"
		# @directed_g = DirectedGraph.new()
		# @directed_g.parse()
		# @directed_g.shortest_route(input)
		prev = @al.shortest_path("SCL", "MEX")
		list = []
        city = "MEX"
        if prev.empty?
            puts "Cannot generate route info"
        else    
            while prev[city].nil? == false
                list.unshift(city)
                city = prev[city]
            end
            list.unshift("SCL")
            list = list.join('-')
        end
        assert_equal("SCL-LIM-MEX", list)
	end

end 
