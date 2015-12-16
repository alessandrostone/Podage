module Podage

	require_relative '../globals'
	require_relative 'builder'

	class OSXBuilder < Builder
		
		def build(configuration, &block)
		
			super
		
		end
		
		def target_name
		
			return 'OSX'
		
		end
	
	end

end