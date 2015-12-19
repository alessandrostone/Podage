#
#	The MIT License (MIT)
#
#	Copyright (c) 2015 Jens Meder
#
#	Permission is hereby granted, free of charge, to any person obtaining a copy of
#	this software and associated documentation files (the "Software"), to deal in
#	the Software without restriction, including without limitation the rights to
#	use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
#	the Software, and to permit persons to whom the Software is furnished to do so,
#	subject to the following conditions:
#
#	The above copyright notice and this permission notice shall be included in all
#	copies or substantial portions of the Software.
#
#	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
#	FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
#	COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
#	IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
#	CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

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
			
			path = BUILD_PATH + '/macosx'
			
			if Dir.exists?(path)
				FileUtils.cp_r path, OUTPUT_PATH + '/osx/'
			end
			

		end
	
	end

end