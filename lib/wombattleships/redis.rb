module Wombattleship::Redis
  #
  # singleton connection to Redis
  # @example usage
  #    class Klass
  #      include Wombattleship::Redis
  #
  #      # use as instance method
  #      def my_method
  #        redis.set('key', 'value')
  #      end
  #    end
  #
  #    klass = Klass.new
  #
  #    # use at instance level
  #    klass.redis.set('key', 'value')
  #
  #    # use as method
  #    klass.my_method
  #
  #    # use as class method
  #    Klass.redis.set('key', 'value')
  #
  # allow {redis} method to be used at class or instance level
  #
  def self.included(base)
    base.extend(Wombattleship::Redis)
  end
end