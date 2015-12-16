module Podage

	require_relative '../globals'

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
			
			FileUtils.cd ".."
		
		end
		
		private
		
		def create_podfile(version, &block)

			target_name = self.target_name

			podfile = Pod::Podfile.new do
	
				use_frameworks!
		
				target target_name do
		
					platform :ios, version
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
		
		protected
		
		def execute_cmd(cmd)
			Open3.popen2e(cmd) do |stdin, stdout_err, wait_thr|
				while line = stdout_err.gets
		
					puts line
			
				end
			end
		end
	
	end

end