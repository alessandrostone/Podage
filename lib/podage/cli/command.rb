module Podage

	class Command
	
		attr_accessor :name
		attr_accessor :description
		
		@block
		@options
		
		def initialize(name, description, &block)
		
			@name = name
			@description = description
			@block = block
			
			@options = []
		
		end
		
		def add_option(option)
		
			@options << option
		
		end
		
		def parse(args)
		
			@block.call
		
		end
	
	end
	
end