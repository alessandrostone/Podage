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

			schemes = Dir.glob(PODS_PROJECT_PATH + "/xcuserdata/**/*.xcscheme")

			schemes.each do |scheme|
	
				name = File.basename scheme
				no_extension = File.basename(scheme, ".*" )
	
				if !scheme.end_with?("Pods-OSX.xcscheme")
		
					FileUtils.mkdir_p PODS_PROJECT_PATH + '/' + XCSCHEMES_PATH
					FileUtils.mv(scheme, PODS_PROJECT_PATH + '/' + XCSCHEMES_PATH + '/' + name)
			
					puts ""
					puts "Building ".bold + no_extension.green
					puts ""
				
					build_framework(BUILD_PATH + "/Pods/Pods.xcodeproj",no_extension, configuration)

				end
			end
		end

		# Build Frameworks

		def build_framework(project, scheme, configuration)
			execute_cmd('xcodebuild ONLY_ACTIVE_ARCH="NO" -project "' + project + '" -scheme ' + scheme + ' -sdk macosx -configuration ' + configuration + ' clean build CONFIGURATION_BUILD_DIR="' + BUILD_PATH + '/osx' + '" | xcpretty --color')
		end
		
		def copy_frameworks
		
			FileUtils.cp_r BUILD_PATH + '/osx', OUTPUT_PATH + '/osx'

		end
	
	end

end