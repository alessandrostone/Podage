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
	require 'podage/builders/ios_builder'
	require 'podage/builders/osx_builder'

	class Packager
	
		public
		
		def build(configuration = "Debug")
		
			if !File.file?('Podagefile')
				puts "No Podagefile found!".red
				exit
			end
		
			# Clean _build folder

			FileUtils.rm_rf BUILD_PATH
			FileUtils.rm_rf OUTPUT_PATH

			# Download Template

			puts "Preparing build environment".green
			`git clone #{TEMPLATE_REPO} _build`

			puts "Loading Podagefile".green
			load_podage_file

			#FileUtils.rm_rf BUILD_PATH
		
		end
		
		def package(platform, version, configuration = "Debug", &block)
		
			if platform == :ios
			
				builder = Podage::IOSBuilder.new version
				builder.build(configuration, &block)
			
			elsif platform == :osx
			
				builder = Podage::OSXBuilder.new version
				builder.build(configuration, &block)
			
			end
		
		end

		private

		# Create Pods project

		def load_podage_file

			if !File.file?('Podagefile')
				puts "No Podagefile found!".red
				exit
			end
		
			eval File.read(PODAGE_FILE_NAME)
	
		end

	
	end

end