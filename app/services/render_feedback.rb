module Services
  class RenderFeedack

    DEFINITIONS = {
      cannot_join: 'You cannot join your own game',
      full_game: 'Game is full!',
      joined_game: 'Joined game!',
      unauthorized: 'Unauthorized'
    }

    # returns game api feedback
    def initialize(options)
      @msg = options.fetch(:msg)
      @status = options.fetch(:status, :ok)
      @start_game = options.fetch(:start_game, false)
      @custom = options.fetch(:custom, '')
    end

    def render_message
      message = @custom ? @custom : DEFINITIONS[@msg]
      render json: { message: message, start_game: @start_game }, status: @status and return
    end
  end
end
