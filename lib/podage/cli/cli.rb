require 'podage/cli/option'
require 'podage/cli/command'
require 'colored'

module Podage

	class CLI
	
		attr_accessor :banner
		@commands
		@options
		
		@@indent = 20
		
		def initialize
		
			@commands = []
			@options = []
		
		end
		
		def parse(args)	
		
			args.each do |arg|
				
				@commands.each do |command|
				
					if arg == command.name
					
						command.parse args
					
					end
				
				end
				
				@options.each do |option|
				
					if arg == option.name || arg == option.short_cut
					
						option.execute
					
					end
				
				end
				
			end
		
			if args.empty?
		
				print
			
			end
		
		end
		
		def add_command(command)
		
			@commands << command
		
		end
		
		def add_option(option)
		
			@options << option
		
		end
		
		def print
		
			puts
			puts "Usage".underline
			puts
			puts "     $ ".bold + "podage " + "[command]".green.bold + " [options]".blue.bold
			puts
			puts "Commands".underline
			puts
			
			@commands.each do |command|
			
				puts "     ".green + command.name.green.bold + whitespace(command.name) + command.description	
			
			end
			
			puts
			puts "Options".underline
			puts
			
			@options.each do |option|
			
				output = option.name + ", " + option.short_cut
				puts "     " + output.bold.blue + whitespace(output) + option.description	
			
			end
			
			puts
		
		end
		
		private
		
		def whitespace(message)
		
			count = @@indent - message.length
			i = 0
			result = ""
			
			until count == i do
			
				result << " "
				i += 1

			end
			
			return result
		
		end
	
	end

end