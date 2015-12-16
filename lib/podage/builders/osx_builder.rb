module Podage

	require 'podage/globals'
	require 'podage/builders/builder'

	class OSXBuilder < Builder
		
		def build(configuration, &block)
		
			super
			
			build_frameworks configuration
			
			copy_frameworks
		
		end
		
		def target_name
		
			return 'OSX'
		
		end
		
		def platform
		
			return :osx
		
		end
		
		private
		
		def build_frameworks(configuration)

			schemes = Dir.glob(PODS_PROJECT_PATH + "/xcshareddata/**/*.xcscheme")

			schemes.each do |scheme|
	
				if !scheme.end_with?("Pods-OSX.xcscheme")
					name = File.basename scheme
					no_extension = File.basename(scheme, ".*" )
	
					puts ""
					puts "Building ".bold + no_extension.green
					puts ""
				
					xcodebuild_framework(BUILD_PATH + "/Pods/Pods.xcodeproj", no_extension, configuration, OSX_ARCHS, BUILD_PATH + '/macosx', OSX_PLATFORM)
				end
			end
		end

		# Build Frameworks
		
		def copy_frameworks
		
			FileUtils.mkpath OUTPUT_PATH + '/osx'
			FileUtils.cp_r BUILD_PATH + '/macosx', OUTPUT_PATH + '/osx/'

		end
	
	end

end