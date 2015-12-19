# Podage

Podage bundles any Cocoapod and its dependencies into a framework - without using cocoapods in your project setup. 

## Overview

1. [Features](README.md#1-features)
2. [Installation](README.md#2-installation)
3. [Usage](README.md#3-usage)
4. [License](README.md#4-license)

## 1. Features

* build and use any Cocoapod without messing with your project or workspace
* compatible with iOS 8.0+ and OSX (tvOS and watchOS coming soon)
* builds frameworks for iOS devices and iOS Simulator architectures as well as universal frameworks for both (including dSYMs) for maximum flexibility
* supports development pods and private specs repositories

## 2. Installation

Podage is built with Ruby and can be installed via ruby gems. If you use the default Ruby installation on Mac OS X, `gem install` can require you to use `sudo` when installing gems. 

```ruby
$ gem install podage
```

## 3. Usage

### 3.1 Init the Podagefile

The Podagefile specifies all Cocoapods you want to bundle as frameworks. Run `podage init` to create a new Podagefile in the current directory. Then add all pods you want to package and run `podage build` to build them. The frameworks will be copied to the `Frameworks` folder in the same folder where your Podagefile is stored.

### 3.2 Podagefile structure

A Podagefile consists of one or more packages. A package is a collection of pods for a specific platform, version, and configuration (_optional_). 

```ruby
package :ios, '8.0', 'Release' do

	pod 'DarkLightning', '~> 0.4.0'
	pod 'Alamofire'
	
end

package :osx, '10.9' do

	pod 'DarkLightning', '~> 0.4.0'
	
end
```

You can use any pod syntax that you would use in a Podfile. See https://guides.cocoapods.org/syntax/podfile.html#pod for more information.

```ruby
package :ios, '8.0', 'Debug' do

	pod 'DarkLightning/OSX', :path => '/Users/jens/Documents/Projects/DarkLightning'
	pod 'Alamofire', :git => 'git@github.com:jensmeder/DarkLightning'
	
end
```

You can also specify a private specs repo.

```ruby
package :osx, '10.9' do

	source 'https://www.github.com/jensmeder/specs.git'

	pod 'DarkLightning', '~> 0.4.0'
	
end
```

## 4. License

The MIT License (MIT)

Copyright (c) 2015 Jens Meder

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
