require_relative 'matcher'

module StCodebreaker
  class Game
    attr_reader :attempts
    ATTEMPTS = 10

    def initialize
      # @hint = '****'
      @no_hint = false
      @secret = (1..4).map { rand(1..6) }.join
      @attempts = ATTEMPTS
    end

    def compare(guess, secret = @secret)
      return 'Input error' if guess.match(/^[1-6]{4}$/).nil?
      @attempts -= 1
      matcher = Matcher.new(secret, guess)
      result = '+' * matcher.exact_match + '-' * matcher.number_match
      result
    end

    def save(name)
      File.open('../../stats.txt', 'a+') do |file|
        file.puts("(Name: #{name} - attempts: #{@attempts} - Secret code: #{@secret} - Play date: #{Time.now})" )
      end
    end

    def hint
      return 'No more hints' if no_hint?
      @no_hint = true
      hint = '****'
      hint_index = rand(0..3)
      hint[hint_index] = @secret[hint_index]
      hint
    end

    private

    def no_hint?
      @no_hint
    end
  end
end
