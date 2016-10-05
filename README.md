[![License](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/ustwo/urlsession-cancellation-swift/blob/master/LICENSE)

# URLSession+Cancellation

An extension to iOS / macOS Foundation library's `NSURLSession` class to add support for cancelling specific URLs from being downloaded.

## Dependencies

* [Xcode](https://itunes.apple.com/gb/app/xcode/id497799835?mt=12#)

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate URLSessionCancellationSwift into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
platform :ios, '8.3'

use_frameworks!

pod 'URLSessionCancellationSwift', '~> 1.0.0'
```

Then, run the following command:

```bash
$ pod install
```

### Manually

- Add the `URLSession+Cancellation.swift` file to your Xcode project.

## Usage

See `ViewController.swift` for sample usage.

There are a couple of methods added to `NSURLSession` class:

### cancelAllRequests

Use the `cancelAllRequests` function to cancel all pending requests for the session.

```
session.cancelAllRequests()
```

### cancelRequestForURL

Use the `cancelRequestForURL` function to cancel a request for a specific URL

```
let url = URL(string: "http://puppygifs.tumblr.com/api/read/json")
session.cancelRequestForURL(url)
```

Note. the `NSURLSession` completion handler will be called with an error code `NSURLErrorCancelled` and domain `NSURLErrorDomain`.

## Contributors

* [Shagun Madhikarmi](mailto:shagun@ustwo.com)

## License

URLSession+Cancellation is released under the MIT License. See the LICENSE file.
