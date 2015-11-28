#
# this module is needed for any class/module that tries to access the Wombattleships
# top level namespace before it has been defined.
# eg:  lib/wombattleships/redis.rb
#

module Wombattleships
end
