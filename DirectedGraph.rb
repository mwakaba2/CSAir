require 'rubygems'
require 'json'
require './AdjacencyList'
# Parse the raw data that represents CSAir's route map
# into graph datastructure.

class DirectedGraph

    attr_accessor :al

    def parse()
        file = File.open("map-data.json","r")
        data = file.read()
        parsed = JSON.parse(data)

        @al = AdjacencyList.new(true)

        parsed["metros"].each do |metro|
            @al.add(metro["name"], metro["country"], metro["continent"], metro["timezone"], metro["coordinates"], metro["population"], metro["region"], metro["code"])
        end

        parsed["routes"].each do |route|
        	@al.add_edge(route["ports"][0], route["ports"][1], route["distance"])
        end

        file.close()
    end

    def generate_json()
        newHash = {"data sources" => [
                "http://www.gcmap.com/" ,
                "http://www.theodora.com/country_digraphs.html" ,
                "http://www.citypopulation.de/world/Agglomerations.html" ,
                "http://www.mongabay.com/cities_urban_01.htm" ,
                "http://en.wikipedia.org/wiki/Urban_agglomeration" ,
                 "http://www.worldtimezone.com/standard.html"
                ], "metros"=> [], "routes" => []}
        
        @al.nodes.each do |name, node|
            newHash["metros"] << {
                        :code => name,
                        :name => node.name,
                        :country => node.country,
                        :continent => node.continent,
                        :timezone =>  node.timezone,
                        :coordinates =>  node.coords,
                        :population => node.pop,
                        :region => node.region }
        end

        @al.edges.each do |city, dests|
            dests.each do |dest|
                newHash["routes"] << {
                    :ports => [city,dest.name],
                    :distance => dest.distance
                }
            end
        end
        
        File.open("updated.json","w") do |f|
            f.write(JSON.pretty_generate(newHash))
        end

    end
        
    def list_cities()
        puts @al.nodes
        @al.nodes_to_s()
    end

    def list_city_info(node_city)
        if @al.is_node(node_city)
            @al.node_info(node_city)
        else
            "City not in database"
        end
        
    end

    def longest_flight()
        @al.longest_distance()
    end

    def shortest_flight()
        @al.shortest_distance()
    end

    def average_distance()
        @al.average_distance()
    end

    def biggest_pop()
        @al.max_pop()
    end
    
    def smallest_pop()
        @al.min_pop()
    end

    def avg_pop()
        @al.avg_pop()
    end

    def list_continents()
        @al.list_continents_cities()
    end

    def hubs()
        @al.vertex_w_most_edges()
    end   

    def route_map_url()
        url = "http://www.gcmap.com/mapui?P=#{@al.get_routes()}"
        url 
    end

    def remove_city(city)
        if @al.is_node(city)
                @al.delete(city)
        else
            "City not in database"
        end
    end

    def remove_route(route)
        @al.delete_edge(route)
    end

    def add_city(city_info, coords)
        name, country, continent, timezone, pop, region, node_city = city_info.split(',')
        @al.add(name, country, continent, timezone, coords, pop, region, node_city)
    end

    def add_route(route, distance)
        city_a, city_b = route.split('-')
        @al.add_edge(city_a city_b, distance)
    end

    def edit_city(city, edit_number, edits)
        edit_number = edit_number.split(' ')
        i = 0
        edit_number.each do |edit|
            if edit == "1"
                puts "Editing city name"
                print city
                @al.set_node_name(city, edits[i])
            elsif edit == "2"
                puts "Editing country"
                @al.set_node_country(city, edits[i])
            elsif edit == "3"
                puts "Editing timezone"
                @al.set_node_timezone(city, edits[i])
            elsif edit == "4"
                puts "Editing coordinates"
                @al.set_node_coords(city, edits[i])
            elsif edit == "5"
                puts "Editing pop"
                @al.set_node_pop(city, edits[i])
            elsif edit == "6"
                puts "Editing region"
                @al.set_node_region(city, edits[i])
            end
            i +=1
        end
    end 

    def get_route_info(cities)
        list = cities.split('-')
        distance, cost, time = @al.get_path_info(list)
        time = (time / 60).round(2)
        if distance != 0
            puts "\nDistance: #{distance}
              \nCost: $#{cost}
              \nTime: #{time} hours"
        end
    end


    def shortest_route(cities)
        city_A, city_B = cities.split('-')
        prev = @al.shortest_path(city_A, city_B)
        list = []
        city = city_B
        if prev.empty?
            puts "Cannot generate route info"
        else    
            while prev[city].nil? == false
                list.unshift(city)
                city = prev[city]
            end
            list.unshift(city_A)
            list = list.join("-")
            puts "Shortest route: #{list}"
            get_route_info(list)
        end
    end

end



