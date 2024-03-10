Pod::Spec.new do |s|

s.name = 'SwiftyAds'
s.version = '16.0.0'
s.license = 'MIT'
s.summary = 'A Swift library to display Google AdMob ads. GDPR, COPPA and App Tracking Transparency compliant.'
s.homepage = 'https://github.com/crashoverride777/swifty-ads'
s.authors = { 'Dominik Ringler' => 'overrideinteractive@icloud.com' }

s.ios.deployment_target = '13.0'

s.requires_arc = true
s.static_framework = true
s.swift_versions = ['5.6', '5.7']

s.source = {
    :git => 'https://github.com/crashoverride777/swifty-ads.git',
    :tag => s.version
}

s.source_files = 'Sources/**/*.{h,m,swift}'

s.dependency 'Google-Mobile-Ads-SDK', '~> 11.1.0'

end
