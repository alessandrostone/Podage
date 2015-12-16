module Podage

	# Constants

	PODAGE_FILE_NAME 		= FileUtils.pwd + "/Podagefile"

	TEMPLATE_REPO			= "git@github.com:jensmeder/Packager.git"

	# Paths

	OUTPUT_PATH				= FileUtils.pwd + "/Frameworks"
	
	IOS_OUTPUT_PATH			= OUTPUT_PATH + '/ios'
	OSX_OUTPUT_PATH			= OUTPUT_PATH + '/osx'
	
	BUILD_PATH 				= FileUtils.pwd + "/_build"
	
	IOS_BUILD_PATH			= BUILD_PATH + '/ios'
	OSX_BUILD_PATH			= BUILD_PATH + '/osx'
	
	PODFILE_PATH 			= BUILD_PATH + "/Podfile"
	PODS_PROJECT_PATH		= BUILD_PATH + "/Pods/Pods.xcodeproj"
	XCSCHEMES_PATH 			= "xcshareddata/xcschemes"

	SIMULATOR_ARCHS			= "i386 x86_64"
	DEVICE_ARCHS			= "armv7 armv7s arm64"
	OSX_ARCHS				= "x86_64"

	SIMULATOR_PLATFORM		= "iphonesimulator"
	DEVICE_PLATFORM			= "iphoneos"
	UNIVERSAL_PLATFORM		= "universal"
	OSX_PLATFORM			= "macosx"
	
	DSYM_PATH				= "Contents/Resources/DWARF"

	SIMULATOR_BUILD_PATH 	= BUILD_PATH + '/' + SIMULATOR_PLATFORM
	DEVICE_BUILD_PATH		= BUILD_PATH + '/' + DEVICE_PLATFORM
	UNIVERSAL_BUILD_PATH 	= BUILD_PATH + '/' + UNIVERSAL_PLATFORM

	SIMULATOR_OUTPUT_PATH 	= OUTPUT_PATH + '/ios/' + SIMULATOR_PLATFORM
	DEVICE_OUTPUT_PATH		= OUTPUT_PATH + '/ios/' + DEVICE_PLATFORM
	UNIVERSAL_OUTPUT_PATH 	= OUTPUT_PATH + '/ios/' + UNIVERSAL_PLATFORM
	
end