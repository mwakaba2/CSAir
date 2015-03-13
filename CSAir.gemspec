# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "CSAir"
  spec.version       = '1.0'
  spec.authors       = ["Mariko Wakabayashi"]
  spec.email         = ["mwakaba2@illinois.com"]
  spec.summary       = %q{Launching an airline.}
  spec.description   = %q{You are a senior software engineer for a new international airline, CSAir. 
                          Before CSAir launches passenger service across the globe, they first need to 
                          start selling tickets to passengers. But before that can happen, some software needs 
                          to be written to manage the extensive route map. }
  spec.homepage      = "https://github.com/mwakaba2/CSAir"
  spec.license       = "UIUC"

  spec.files         = ['lib/CSAir.rb', 'lib/AdjacencyList.rb', 'lib/DirectedGraph.rb']
  spec.executables   = ['bin/CSAir', 'bin/AdjacencyList', 'bin/DirectedGraph']
  spec.test_files    = ['tests/test_CSAir.rb', 'tests/test_AdjacencyList.rb']
  spec.require_paths = ["lib"]
end

