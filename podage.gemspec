Gem::Specification.new do |s|

	s.name        = 'podage'
	s.version     = '0.1.0'
	s.date        = '2015-12-19'
	s.summary     = 'Package Cocoapods into Frameworks'
	s.description = 'A simple tool to package Cocoapods into Frameworks'
	s.authors     = ["Jens Meder"]
	s.email       = 'me@jensmeder.de'
	s.homepage	  = 'https://github.com/jensmeder/Podage'
	s.files       = ["lib/podage.rb",
					 "lib/podage/version.rb",
					 "lib/podage/packager.rb", 
					 "lib/podage/globals.rb", 
					 "lib/podage/builders/builder.rb", 
					 "lib/podage/builders/ios_builder.rb", 
					 "lib/podage/builders/osx_builder.rb",
					 "lib/podage/cli/command.rb",
					 "lib/podage/cli/option.rb"]

	s.license       = 'MIT'
	s.executables << 'podage'
	s.add_runtime_dependency 'cocoapods', '~> 0.39.0'
	s.add_runtime_dependency 'xcpretty', '~> 0.2.1'
	
end