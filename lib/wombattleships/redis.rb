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

  private
  # @param feature_name [String] a required feature name to namespace your redis key
  # @param identifier [String] a required unique identifier for the key
  # @example when mixed into the User model
  #   generate_key('first_player', '200')
  #   # => 'game:first_player:200'

  def generate_redis_key(feature_name, identifier)
    klass = self.is_a?(Class) ? self.to_s.underscore : self.class.name.underscore
    "#{klass}:#{feature_name}:#{identifier}"
  end
end