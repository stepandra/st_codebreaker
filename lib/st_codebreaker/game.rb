require_relative 'matcher'

module StCodebreaker
  class Game
    attr_reader :attempts, :no_hint
    ATTEMPTS = 10
    CODE_SIZE = 4
    DIGITS = 1..6

    def initialize
      @no_hint = false
      @secret = generate_secret
      @attempts = ATTEMPTS
    end

    def compare(guess, secret = @secret)
      return 'Input error' if guess.match(/^[1-6]{4}$/).nil?
      @attempts -= 1
      matcher = Matcher.new(secret, guess)
      '+' * matcher.exact_match + '-' * matcher.number_match
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

    def generate_secret
      Array.new(CODE_SIZE) { rand(DIGITS) }.join
    end

    def no_hint?
      @no_hint
    end
  end
end
