module Podage

	require 'podage/globals'

	class Builder
	
		def initialize(version) 
		
			@version = version
		
		end
		
		def build(configuration, &block)
		
			puts "Building Frameworks".green
		
			FileUtils.cd BUILD_PATH
		
			podfile = create_podfile(self.version, &block)
				
			sandbox = Pod::Sandbox.new(BUILD_PATH + "/Pods")
			installer = Pod::Installer.new(sandbox, podfile)
			installer.install!
			
			share_schemes
			
			FileUtils.cd ".."
		
		end
		
		private
		
		def share_schemes
		
			schemes = Dir.glob(PODS_PROJECT_PATH + "/xcuserdata/**/*.xcscheme")

			schemes.each do |scheme|
	
				
				name = File.basename scheme

				if !scheme.end_with?("Pods-iOS.xcscheme")
					
					FileUtils.mkdir_p PODS_PROJECT_PATH + '/' + XCSCHEMES_PATH
					FileUtils.mv(scheme, PODS_PROJECT_PATH + '/' + XCSCHEMES_PATH + '/' + name)

				end
			end
		
		end
		
		def create_podfile(version, &block)

			target_name = self.target_name
			platform = self.platform

			podfile = Pod::Podfile.new do
	
				use_frameworks!
		
				target target_name do
		
					platform platform, version
					self.instance_eval &block
		
				end
		
			end
	
			return podfile
		end
		
		public
		
		def version
		
			return @version
		
		end
		
		def target_name
		
			return nil
		
		end
		
		def platform
		
			return nil
		
		end
		
		protected
		
		def execute_cmd(cmd)
			Open3.popen2e(cmd) do |stdin, stdout_err, wait_thr|
				while line = stdout_err.gets
		
					puts line
			
				end
			end
		end
		
		def xcodebuild_framework(project, scheme, configuration, archs, build_dir, platform)
			execute_cmd('xcodebuild clean build SUPPORTED_PLATFORMS='+platform+' ONLY_ACTIVE_ARCH="NO" VALID_ARCHS="' +archs + '" ARCHS="'+archs+'" -project "' + project + '" -scheme ' + scheme + ' -sdk ' + platform +  ' -configuration ' + configuration + ' CONFIGURATION_BUILD_DIR="' + build_dir + '" | xcpretty --color')
		end
	
	end

end