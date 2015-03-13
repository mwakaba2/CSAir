class AdjacencyList

    Node = Struct.new(:name, :country, :continent, :timezone, :coords, :pop, :region, :distance)
    Edge = Struct.new(:name, :distance)

    attr_accessor :edges, :nodes
    
    # Returns a new Adjacency List
    def initialize(named=false)
        @nodes = {}
        @edges = {}
    end
    
    # Add a new node with extra info
    def add(name, country, continent, timezone, coords, pop, region, node_city, edges=Array.new)
        node = Node.new(name, country, continent, timezone, coords, pop, region)
        @nodes[node_city] = node
        @edges[node_city] = edges
        self
    end
    
    # Delete node
    def delete(node_city)
        #delete city in nodes
        @nodes[node_city] = nil
        @nodes.delete_if { |k, v| v.nil? }

        #delete the edge list for the city
        @edges[node_city] = nil
        @edges.delete_if { |k, v| v.nil? }

        #delete all route including the city
        @edges.each do |city, dests|
            dests.each do |dest|
                if dest.name == node_city
                    @edges[city].delete(dest)
                    if @edges[city].length == 0
                        @edges[city] = nil
                        @edges.delete_if { |k, v| v.nil? }  
                    end  
                end
            end
        end 
    end
    
    # Delete edge
    def delete_edge(route)
        city_a, city_b = route.split(' ')

        # Find specific route and delete
        all_edges = @edges[city_a]
        all_edges.each do |edge|
            if edge.name = city_b
                all_edges.delete(edge)
                if @edges[city_a].length == 0
                    @edges[city_a] = nil
                    @edges.delete_if { |k, v| v.nil? }  
                end 
            end
        end
    end
    
    def get_nodes_length()
        @nodes.length
    end

    def get_edges_length()
        @edges.length
    end

    # Returns the code of the node with node_city
    def get_node_name(node_city)
        @nodes[node_city].name
    end

    # Returns the country of the node with node_city
    def get_node_country(node_city)
        @nodes[node_city].country
    end
    
    # Returns the continent of the node with node_city
    def get_node_continent(node_city)
        @nodes[node_city].continent
    end

    # Returns the timezone of the node with node_city
    def get_node_timezone(node_city)
        @nodes[node_city].timezone
    end

    # Returns the coords of the node with node_city
    def get_node_coords(node_city)
        @nodes[node_city].coords
    end
    
    # Returns the population of the node with node_city
    def get_node_pop(node_city)
        @nodes[node_city].pop
    end

    # Returns the region of the node with node_city
    def get_node_region(node_city)
        @nodes[node_city].region
    end

    # Returns the distance of the node with node_city
    def get_node_distance(node_city)
        @nodes[node_city].distance
    end

    # Returns edge city
    def get_edge_city(node_city)
        @edges[node_city].name
    end

    # Returns distance
    def get_edge_distance(node_city_A, node_city_B)
        dist = 0
        @edges[node_city_A].each do |edge|
            if edge.name == node_city_B
                dist = edge.distance.to_i
            end
        end
        dist
    end

    # Set with name of node at the specific city
    def set_node_name(node_city, name)
        @nodes[node_city].name = name
    end

    # Set with country of node at the specific city
    def set_node_country(node_city, country)
        @nodes[node_city].country = country
    end
    # Set with continent of node at the specific city
    def set_node_continent(node_city, continent)
        @nodes[node_city].continent = continent
    end
    # Set with timezone of node at the specific city
    def set_node_timezone(node_city, timezone)
        @nodes[node_city].timezone = timezone
    end
    # Set with coords of node at the specific city
    def set_node_coords(node_city, coords)
        @nodes[node_city].coords = coords
    end
    # Set with pop of node at the specific city
    def set_node_pop(node_city, pop)
        @nodes[node_city].pop = pop
    end
    # Set with region of node at the specific city
    def set_node_region(node_city, region)
        @nodes[node_city].region = region
    end
    # Set with distance of node at the specific city
    def set_node_distance(node_city, distance)
        @nodes[node_city].distance = distance
    end
    # Set with name of edge at the specific city
    def set_edge_name(node_city, name)
        @edges[node_city].name = name
    end
     # Set with distance of edge at the specific city
    def set_edge_distance(node_city, distance)
        @edges[node_city].distance = distance
    end

    # Adds an edge from node_city_A to node_city_B
    def add_edge(node_city_A, node_city_B, distance)
        @edges[node_city_A] << Edge.new(node_city_B, distance)
    end

    # Checks if there is a route from city A to city B
    def adjacent?(node_city_A, node_city_B)
        bool = false
        if(node_city_B.nil?)
            bool = false
        else
            @edges[node_city_A].each do |edge|
                if edge.name == node_city_B
                    bool = true
                end
            end
        end
        bool
    end

    # Return a string representation of the graph
    def graph_to_s
        string = ""
        @nodes.each do |name, node|
            string +="#{name}:\n\t(#{node.name}, #{node.country}, #{node.continent} #{node.timezone}, #{node.coords}, #{node.pop}, #{node.region}) => #{@edges[name]} \n"
        end
        string
    end        

    #Returns a string representation of all nodes
    def nodes_to_s
        string = ""
        @nodes.each do |name, node|
            string +="#{name}:\n\t(#{node.name})\n"
        end
        string
    end   

    #Checks if node exists in graph
    def is_node(node_city)
        if @nodes[node_city].nil?
            false
        else
            true
        end
    end

    #Returns specific info about a particular city
    def node_info(node_city)
        node = @nodes[node_city]
        info = "#{node_city}:\n\tCity Name: #{node.name} \n\tCountry: #{node.country}, \n\tContinent: #{node.continent} \n\tTimezone: #{node.timezone} \n\tCoordinates: #{node.coords} \n\tPopulation: #{node.pop} \n\tRegion: #{node.region} \n\tRoutes:"
        
        if @edges[node_city].empty? 
            info += "\n\tNo Routes"
        else 
            @edges[node_city].each do |edge|
                info += "\n\t#{edge.name}, #{edge.distance} miles"
            end
        end
        info 
    end

    #Returns the longest distance and the cities
    def longest_distance()
        max = 0
        s = ""
        @edges.each do |city, dests|
            dests.each do |dest|
                if max < dest.distance
                    max = dest.distance
                    s = "#{city} to #{dest.name}"
                end
            end
        end
        "Longest distance is #{max} from #{s}"
    end

    #Returns the shortest distance and the cities
    def shortest_distance()
        min = 1000000
        s = ""
        @edges.each do |city, dests|
            dests.each do |dest|
                if min > dest.distance
                    min = dest.distance
                    s = "#{city} to #{dest.name}"
                end
            end
        end
        "Shortest distance is #{min} from #{s}"
    end

    def average_distance()
        avg = 0
        flights = 0
        @edges.each do |city, dests|
            dests.each do |dest| 
                avg += dest.distance
                flights +=1
            end
        end
        avg /= flights
        "Average distance is #{avg} miles"
    end

    def max_pop()
        max = 0
        city = ''
        @nodes.each do |name, node| 
            if max < node.pop
                max = node.pop
                city = node.name
            end
        end
        "Biggest city is #{city} with population #{max}"
    end      

    def min_pop()
        min = 150000000
        city = ''
        @nodes.each do |name, node| 
            if min > node.pop
                min = node.pop
                city = node.name
            end
        end
        "Smallest city is #{city} with population #{min}"
    end 

    def avg_pop()
        avg = 0
        city = ''
        @nodes.each do |name, node| 
            avg += node.pop
        end
        avg = avg/@nodes.length
        "Average population of all cities is #{avg}"
    end

    def list_continents_cities()
        continents = {}
        string = ''
        @nodes.each do |name, node|
            if continents[node.continent].nil?
                continents[node.continent] = node.name
            else
                continents[node.continent] << " ,#{node.name}"
            end
        end && false 
        
        string += "Continents and cities:"
        continents.each do |continent|
            string+="\n\t#{continent[0]}: #{continent[1]}"
        end
        string

    end

    def vertex_w_most_edges()
        hubs = @edges.max_by(5){ |name, edge| edge.length}
        top_hubs = ''
        hubs.each do |name, edge|
            top_hubs += "\n\t#{get_node_name(name)}"
        end
        "Hub cities are #{top_hubs}"
    end
    
    def get_routes()
        routes = ""
        @edges.each do |city, dests|
            dests.each do |dest|
                routes+= "#{city}-#{dest.name}"
                routes+= ",+"
            end
        end
        routes = routes.slice(0..routes.length-3)
        routes
    end

    def get_cost(distance, multiplier)
        # reduce cost by 0.05 for each leg
        cost_each_km = 0.35 - (multiplier * 0.05) 
        cost = distance * cost_each_km
        cost
    end

    def get_time(distance, outbounds, last)
        acc = 0.39 #0.39km/min^2
        layover = 120 - ( (outbounds - 1) * 0.167 )# subtract from 2hours depending on the number of outbounds
        tot_time = 0
        set_dist = 200
        if distance <= 400
            half = distance / 2
            tot_time += 2 * Math.sqrt( (2*half) / acc ) 
        else # greater than 400
            tot_time += 2 * Math.sqrt( (2*set_dist) / acc ) 
            tot_time += (distance - (2 * set_dist) ) / 12.5
        end

        if last
            tot_time.round(2)
        else
            tot_time += layover
            tot_time.round(2)
        end

    end


    def get_path_info(list)
        tot_dist = 0
        tot_cost = 0
        tot_time = 0
        #todo implement calculating costs, time, distance 
        length = list.length - 2
        list[0..length].each_with_index do |city, index|
            leg = index+1
            dest_city = list[index+1]
            outbounds = @edges[dest_city].length
            last = false
            if adjacent?( city, dest_city )
                if index+1 == list.length-1
                    last = true
                end
                dist = get_edge_distance(city, dest_city)
                tot_dist += dist
                tot_cost += get_cost(dist, index)
                tot_time += get_time(dist, outbounds, last)
            else
                puts "No such route!"
                break
            end
        end
        [tot_dist, tot_cost, tot_time]
    end

    def find_min_dist(cities)
        min_dist = 10000000000
        ret = cities[0]
        code = ""

        cities.each do |name, node|
            if node.distance < min_dist
                min_dist = node.distance
                ret = node
                code = name
            end
        end
        [code, ret]
    end


    def shortest_path(source, target)
        prev = {} #previous pointer array
        @nodes[source].distance = 0
        q = [] #queue to keep track of unvisited nodes

        # set up graph before checking
        @nodes.each do |name, node|
            if name != source
                @nodes[name].distance = 100000000000
                prev[name] = nil
            end
            q << [name,node]
        end

        while q.nil? == false
            u_code, u = find_min_dist(q)
            if u_code == target
                return prev
            end
            q.delete([u_code,u])
            q.compact

            if @edges[u_code].nil?
                puts "No such path"
                prev = {}
                return prev
            else 
                @edges[u_code].each do |edge| 
                    alt = u.distance + get_edge_distance(u_code, edge.name)
                    if alt < @nodes[edge.name].distance
                        set_node_distance(edge.name, alt)
                        prev[edge.name] = u_code
                    end
                end
            end
        end
        puts prev
        return prev
            
    end


end

