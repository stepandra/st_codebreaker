module StCodebreaker
  class Interface
    def initialize
      @game = Game.new
    end

    def greeting
      print "
      Welcome to codebreaker game.
      Here you must to guess the 4 digit code, wich numbers is from 1 to 6
      Commands:
        1 - start
        2 - statistics
        3 - exit
      "
      print '-> '
      case gets.chomp
      when '1' then play
      when '2' then show_stats
      when '3' then exit
      else print 'Incorrect input'
      end
    end

    def save_stats
      puts 'Input your name: '
      name = $stdin.gets.chomp
      @game.save(name)
      play_again
    end

    def play
      while @game.attempts > 0
        puts "You have #{@game.attempts} tries. Type 'h' for hint"
        print 'Your guess: '
        case guess = gets.chomp
        when 'h' then puts @game.hint
        else
          result = @game.compare(guess)
          puts result
          if result == '++++'
            save_stats
            break
          end
        end
      end
      play_again if @game.attempts.zero?
    end

    def read_stats
      File.read('../../stats.txt')
    end

    def play_again
      puts 'Play again? [y/n]'
      @game = Game.new
      gets.chomp == 'y' ? play : exit
    end

    def show_stats
      puts read_stats
      greeting
    end
  end
end
