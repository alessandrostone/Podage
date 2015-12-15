module Podage

	# Constants

	SIMULATOR_ARCHS			= "i386 x86_64"
	DEVICE_ARCHS			= "armv7 armv7s arm64"

	SIMULATOR_PLATFORM		= "iphonesimulator"
	DEVICE_PLATFORM			= "iphoneos"
	UNIVERSAL_PLATFORM		= "universal"

	PODAGE_FILE_NAME 		= FileUtils.pwd + "/Podagefile"

	TEMPLATE_REPO			= "git@github.com:jens-meder/Packager.git"

	# Paths

	OUTPUT_PATH				= FileUtils.pwd + "/Frameworks"
	BUILD_PATH 				= FileUtils.pwd + "/_build"
	PODFILE_PATH 			= BUILD_PATH + "/Podfile"
	PODS_PROJECT_PATH		= BUILD_PATH + "/Pods/Pods.xcodeproj"
	XCSCHEMES_PATH 			= "xcshareddata/xcschemes"

	SIMULATOR_BUILD_PATH 	= BUILD_PATH + '/' + SIMULATOR_PLATFORM
	DEVICE_BUILD_PATH		= BUILD_PATH + '/' + DEVICE_PLATFORM
	UNIVERSAL_BUILD_PATH 	= BUILD_PATH + '/' + UNIVERSAL_PLATFORM

	SIMULATOR_OUTPUT_PATH 	= OUTPUT_PATH + '/' + SIMULATOR_PLATFORM
	DEVICE_OUTPUT_PATH		= OUTPUT_PATH + '/' + DEVICE_PLATFORM
	UNIVERSAL_OUTPUT_PATH 	= OUTPUT_PATH + '/' + UNIVERSAL_PLATFORM

	DSYM_PATH				= "Contents/Resources/DWARF"

	class Packager
	
		def initialize		
			
		
		end
		
		def build(configuration = "Debug")
		
			# Clean _build folder

			FileUtils.rm_rf BUILD_PATH

			# Download Template

			`git clone #{TEMPLATE_REPO} _build`

			puts "Installing Pods".green
			install_pods

			puts "Building Frameworks".green
			build_frameworks configuration
			build_universal_frameworks

			copy_frameworks

			FileUtils.rm_rf BUILD_PATH
		
		end
		
		def package(platform, version, &block)
		
			FileUtils.cd BUILD_PATH
		
			if platform == :ios
			
				podfile = create_podfile(platform, version, &block)
				
				sandbox = Pod::Sandbox.new(BUILD_PATH + "/Pods")
				installer = Pod::Installer.new(sandbox, podfile)
				installer.install!
			
			elsif platform == :osx
			
				
			
			end
			
			FileUtils.cd ".."
		
		end

	private

	# Build Podfile from Podagefile

	def create_podfile(os, version, &block)

		podfile = Pod::Podfile.new do
	
			use_frameworks!
		
			target 'Packager' do
		
				platform os, version
				self.instance_eval &block
		
			end
		
		end
	
		return podfile

	end

	# Create Pods project

	def install_pods

		eval File.read(PODAGE_FILE_NAME)
	
	end

	# Share all schemes

	def build_frameworks(configuration)

		schemes = Dir.glob(PODS_PROJECT_PATH + "/xcuserdata/**/*.xcscheme")

		schemes.each do |scheme|
	
			name = File.basename scheme
			no_extension = File.basename(scheme, ".*" )
	
			if !scheme.end_with?("Pods-Packager.xcscheme")
		
				FileUtils.mkdir_p PODS_PROJECT_PATH + '/' + XCSCHEMES_PATH
				FileUtils.mv(scheme, PODS_PROJECT_PATH + '/' + XCSCHEMES_PATH + '/' + name)
			
				puts name.green
				build_framework("_build/Pods/Pods",no_extension, configuration)

			end
		end
	end

	# Build Frameworks

	def build_framework_archs(project, scheme, configuration, archs, build_dir, platform)

		execute_cmd('xcodebuild ONLY_ACTIVE_ARCH="NO" VALID_ARCHS="' +archs + '" ARCHS="' + archs + '" -project ' + project + '.xcodeproj -scheme ' + scheme + ' -sdk ' + platform + ' -configuration ' + configuration + ' clean build CONFIGURATION_BUILD_DIR=' + build_dir)

	end

	def build_framework(project, scheme, configuration)

		build_framework_archs(project, scheme, configuration, SIMULATOR_ARCHS, SIMULATOR_BUILD_PATH, SIMULATOR_PLATFORM)
	
		build_framework_archs(project, scheme, configuration, DEVICE_ARCHS, DEVICE_BUILD_PATH, DEVICE_PLATFORM)

	end

	def execute_cmd(cmd)
		Open3.popen2e(cmd) do |stdin, stdout_err, wait_thr|
			while line = stdout_err.gets
		
				puts line
			
			end
		end
	end

	def build_universal_dSYMs

		dSYMs = Dir.glob(SIMULATOR_BUILD_PATH + "/*.framework.dSYM")
	
		dSYMs.each do |dSYM|
	
			name = File.basename(File.basename(dSYM, ".*"), ".*" )
	
			puts "Build universal dSYM for " + name.green
		
			FileUtils.cp_r dSYM, UNIVERSAL_BUILD_PATH + "/" + File.basename(dSYM)
		
			simulator = [SIMULATOR_BUILD_PATH, File.basename(dSYM), DSYM_PATH, name].join('/')
			device = [DEVICE_BUILD_PATH, File.basename(dSYM), DSYM_PATH, name].join('/')
			output = [UNIVERSAL_BUILD_PATH, File.basename(dSYM), DSYM_PATH, name].join('/')

			execute_cmd('lipo -create "' + device +'" "' + simulator +'" -output "' + output +'"')
		
		end

	end

	def build_universal_frameworks

		schemes = Dir.glob(SIMULATOR_BUILD_PATH + "/*.framework")

		FileUtils.mkdir UNIVERSAL_BUILD_PATH

		schemes.each do |scheme|
	
			name = File.basename(scheme, ".*" )
	
			puts "Build universal framework for " + name.green
		
			FileUtils.cp_r scheme, UNIVERSAL_BUILD_PATH + "/" + File.basename(scheme)

			simulator = [DEVICE_BUILD_PATH, File.basename(scheme), name].join('/')
			device = [SIMULATOR_BUILD_PATH, File.basename(scheme), name].join('/')
			output = [UNIVERSAL_BUILD_PATH, File.basename(scheme), name].join('/')

			execute_cmd('lipo -create "' + simulator +'" "' + device +'" -output "' + output +'"')
		
		end
	
		build_universal_dSYMs

	end

	def copy_frameworks

		FileUtils.rm_rf OUTPUT_PATH
		FileUtils.mkdir OUTPUT_PATH
	
		FileUtils.cp_r DEVICE_BUILD_PATH, DEVICE_OUTPUT_PATH
		FileUtils.cp_r SIMULATOR_BUILD_PATH, SIMULATOR_OUTPUT_PATH
		FileUtils.cp_r UNIVERSAL_BUILD_PATH, UNIVERSAL_OUTPUT_PATH

	end

	
	end

end