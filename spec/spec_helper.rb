require 'chefspec'
require 'chefspec/berkshelf'

##################
# Monkey Patches #
##################

# silence all logging from chef-client
Chef::Log.init('/dev/null')

# silence 'warning: already initialized constant' stuff
$VERBOSE = nil

# silence the deprecation warnings
module Kernel
  def deprecated(*)
    # noop
  end
end
