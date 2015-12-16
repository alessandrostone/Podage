module Podage

	require 'podage/globals'
	require 'podage/builders/builder'

	class IOSBuilder < Builder
		
		def build(configuration, &block)
		
			super
		
			build_frameworks configuration
			generate_universal_frameworks

			copy_frameworks
		
		end
		
		private
		
		def generate_universal_dSYMs

			puts "Generating universal dSYM files".green

			dSYMs = Dir.glob(SIMULATOR_BUILD_PATH + "/*.framework.dSYM")
	
			dSYMs.each do |dSYM|
	
				name = File.basename(File.basename(dSYM, ".*"), ".*" )
		
				FileUtils.cp_r dSYM, UNIVERSAL_BUILD_PATH + "/" + File.basename(dSYM)
		
				simulator = [SIMULATOR_BUILD_PATH, File.basename(dSYM), DSYM_PATH, name].join('/')
				device = [DEVICE_BUILD_PATH, File.basename(dSYM), DSYM_PATH, name].join('/')
				output = [UNIVERSAL_BUILD_PATH, File.basename(dSYM), DSYM_PATH, name].join('/')

				execute_cmd('lipo -create "' + device +'" "' + simulator +'" -output "' + output +'"')
		
			end

		end

		def generate_universal_frameworks

			puts "Generating universal frameworks".green

			schemes = Dir.glob(SIMULATOR_BUILD_PATH + "/*.framework")
	
			FileUtils.mkdir UNIVERSAL_BUILD_PATH

			schemes.each do |scheme|
	
				name = File.basename(scheme, ".*" )
		
				FileUtils.cp_r scheme, UNIVERSAL_BUILD_PATH + "/" + File.basename(scheme)

				simulator = [DEVICE_BUILD_PATH, File.basename(scheme), name].join('/')
				device = [SIMULATOR_BUILD_PATH, File.basename(scheme), name].join('/')
				output = [UNIVERSAL_BUILD_PATH, File.basename(scheme), name].join('/')

				execute_cmd('lipo -create "' + simulator +'" "' + device +'" -output "' + output +'"')
		
			end
	
			generate_universal_dSYMs

		end
		
		def copy_frameworks

			FileUtils.rm_rf IOS_OUTPUT_PATH
			FileUtils.mkpath IOS_OUTPUT_PATH
		
			FileUtils.cp_r DEVICE_BUILD_PATH, DEVICE_OUTPUT_PATH
			FileUtils.cp_r SIMULATOR_BUILD_PATH, SIMULATOR_OUTPUT_PATH
			FileUtils.cp_r UNIVERSAL_BUILD_PATH, UNIVERSAL_OUTPUT_PATH

		end
		
		# Share all schemes

		def build_frameworks(configuration)

			schemes = Dir.glob(PODS_PROJECT_PATH + "/xcuserdata/**/*.xcscheme")

			schemes.each do |scheme|
	
				name = File.basename scheme
				no_extension = File.basename(scheme, ".*" )
	
				if !scheme.end_with?("Pods-iOS.xcscheme")
		
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
			xcodebuild_framework(project, scheme, configuration, SIMULATOR_ARCHS, SIMULATOR_BUILD_PATH, SIMULATOR_PLATFORM)
			xcodebuild_framework(project, scheme, configuration, DEVICE_ARCHS, DEVICE_BUILD_PATH, DEVICE_PLATFORM)
		end
		
		public
		
		def target_name
		
			return 'iOS'
		
		end
		
		def platform
		
			return :ios
		
		end
	
	end

end