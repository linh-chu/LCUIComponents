Pod::Spec.new do |s|

    s.name             = 'LCUIComponents'
    s.version          = '1.1.5'
    s.summary          = 'Transient windows showing on top of other content onscreen.'
    s.description      = <<-DESC
The framework supports UI components such as popover showing on top of the current content view.
DESC

    s.homepage         = 'https://github.com/linhcn/LCUIComponents'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Linh Chu' => 'cnhlinh@gmail.com' }
    s.source           = { :git => 'https://github.com/linhcn/LCUIComponents.git', :tag => s.version.to_s }

    s.ios.deployment_target = '9.0'
    s.source_files = 'LCUIComponents/Source/*.swift'

end
