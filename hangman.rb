class Player < Object
    
    #player object holds all stats regarding the players active game
    
    attr_reader :word
    attr_reader :name
    attr_accessor :current
    attr_accessor :letters

    def initialize(list,name, word = wordpicker(list), current = [], letters = [])
    @name = name
    @word = word
    @current = current
    @letters = letters
    end
    
    def save(other)
    # Output seralization for the current games data saves to a txt file each
    # line representing one aspect of the players data
        
        if Dir.exists?('saves')
            Dir.chdir('saves') do 
                File.open("#{name}#{Time.now.strftime("%Y-%m-%d")}.txt",'w') do |f|
                    f.write "#{@name}\n"
                    f.write "#{@word}\n"
                    f.write "#{@current}\n"
                    f.write "#{@letters}\n"
                    f.write "#{other.guesses}\n"
                end
            end
        else
            Dir.mkdir('saves')
            Dir.chdir('saves') do
                File.open("#{name}#{Time.now.strftime("%Y-%m-%d")}.txt",'w') do |f|
                    f.write "#{@name}\n"
                    f.write "#{@word}\n"
                    f.write "#{@current}\n"
                    f.write "#{@letters}\n"
                    f.write "#{other.guesses}\n"
                end
            end
        end
        main
    end
end
    
class Game < Object
    
    attr_accessor :guesses
    
    def initialize
        @guesses = 6 
    end
    
    def wordchecker

    end

    def update_hand
        
    end
    
    def output(player1)
        puts "You have #{self.guesses} left"
        puts "Your answer so far: #{player1.current.join}"
        puts "Your letters #{player1.letters.join}"
    end

    def new_game(list)
        print "Please enter your name \n>"
        name = gets.chomp
        puts ""
        player1 = Player.new(list,name)
        game_loop(player1)
    end

    def game_loop(player1)
        output(player1)
        
    end

    def load
        file_list = []
        result = []
        puts "Please select a save file: "
        Dir.foreach('./saves') do |item|
            if item == "." or item == ".."
                next
            else
                file_list << item
            end
        end
        selection = ""
        until selection.to_i > 0 and selection.to_i < file_list.size
            file_list.each do |item|
                puts "#{file_list.index(item) +1}: #{item}"
            end
            print'>'
            selection = gets.chomp.to_i
        end
            puts 'Loading'
            File.open("./saves/#{file_list[selection-1]}") do |f|
                f.readlines do |line|
                    result << line
                end
            end
        name = result[0]
        word = result[1]
        current = result[2]
        letters = result[3]
        self.guesses = result[4]
        player1 = Player.new(name,word,letters,current)
        game_loop
    end
end

def load_dictionary
    result = []
    dictionary = open('5desk.txt', 'r')
    dictionary.readlines.each do |line|
        result << line.chomp
    end
    result
end

def wordpicker(list)
    chosey = rand(list.count)+1
    return list[chosey]
end

def credits
    puts "Hangman in Ruby v1.0 created by Brett Flanders\n\n"
end

def main
    puts "Hangman"
    words = ''
    unless words.size > 0
        puts "Loading"
        words = load_dictionary
    end
    answer = ""
    until answer.to_i > 0 and answer.to_i < 5
    puts "Welcome please select from this list:"
        puts"\n"
        puts"1 New Game"
        puts"2 Load Game"
        puts"3 Credits"
        puts"4 Exit"

        puts"\n"
        print">"
        answer = gets.chomp 
        puts" "
        if answer == "1"
            game = Game.new
            game.new_game(words)
        elsif answer == "2"
            game = Game.new
            game.load
        elsif answer == "3"
            answer = ""
            credits
        elsif answer == "4"
            puts "Thank you for playing!!"
            exit
        else
            puts "Incorrect selection please try again.\n\n"
        end
    end
end

main