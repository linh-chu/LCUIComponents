Pod::Spec.new do |s|

    s.name             = 'LCUIComponents'
    s.version          = '0.1.0'
    s.summary          = 'LCUIComponents iOS SDK 0.1.0'
    s.description      = <<-DESC
The framework supports UI components showing on top of the current content view.
DESC

    s.homepage         = 'https://github.com/linhcn/LCUIComponents'
    s.license          = { :type => 'MIT', :file => 'LICENSE.md' }
    s.author           = { 'Linh Chu' => 'cnhlinh@gmail.com' }
    s.source           = { :git => 'https://github.com/linhcn/LCUIComponents.git', :tag => s.version.to_s }

    s.ios.deployment_target = '10.0'
    s.source_files = 'LCUIComponents/Source/*.swift'

end
