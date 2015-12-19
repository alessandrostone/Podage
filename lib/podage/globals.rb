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