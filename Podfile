# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'blockchain-eos' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for blockchain-eos
  pod 'OHHTTPStubs/Swift'

  def testing_pods
    pod 'Quick'
    pod 'Nimble'
  end

  target 'blockchain-eosTests' do
    inherit! :search_paths
    # Pods for testing
    testing_pods
  end

  target 'blockchain-eosUITests' do
    # Pods for testing
    testing_pods
  end

end
