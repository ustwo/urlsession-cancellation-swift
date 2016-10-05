Pod::Spec.new do |spec|
  spec.name = 'NSURLSessionCancellationSwift'
  spec.version = '1.0.0'
  spec.license = 'MIT'
  spec.summary = 'An extension to iOS / macOS Foundation library\'s NSURLSession class to add support for cancelling specific URLs from being downloaded.'
  spec.homepage = 'https://github.com/ustwo/urlsession-cancellation-swift'
  spec.authors = {
    'Shagun Madhikarmi' => 'shagun@ustwo.com'
  }
  spec.source = {
    :git => 'https://github.com/ustwo/urlsession-cancellation-swift.git',
    :tag => 'v1.0.0'
  }
  spec.ios.deployment_target = '8.3'
  spec.source_files = 'Sources/*.swift'
  spec.requires_arc = true
end
