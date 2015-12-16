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

			# Download Template

			puts "Preparing build environment".green
			`git clone #{TEMPLATE_REPO} _build`

			puts "Loading Podagefile".green
			load_podage_file

			FileUtils.rm_rf BUILD_PATH
		
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