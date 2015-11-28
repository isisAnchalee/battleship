module Services
  class RecordKeeper
    include Wombattleships::Redis
    
    def initialize(options)
      @game_prefix = options.fetch(:game_prefix)
      @game_id = options.fetch(:game_id)
    end

    # Increments number of password-reset emails that have been requested per day
    def increment
      redis.setex(key, TTL, value)
    end

    # @return [Fixnum] number of keys deleted
    # Delete failed_attempt key for user after successful request
    def reset
      redis.del(key)
    end

    # @return [Fixnum] count of user invalid attempts from Redis
    def failed_attempts
      find_value || 0
    end

    # @return [Boolean] true if rate limit for each email has been exceeded
    def rate_limit_exceeded?
      failed_attempts >= @max_attempts
    end

    # @return [Time] how long until user can request more password reset emails
    def locked_until
      distance_of_time_in_words(get_ttl)
    end

    # @return [Integer] time until stored value expires
    def get_ttl
      redis.ttl(key)
    end

    private

    def find_value
      redis.get(key).to_i
    end

    def key
      generate_redis_key(@target, @user.email)
    end
  end
end