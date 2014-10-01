class Player < Object
    
    attr_reader :word
    attr_reader :name
    attr_reader :current

    def initialize(list,name)
    @name = name
    @word = wordpicker(list)
    @current = []
    @letters = []
    end
    
    def save
        if Dir.exists?('saves')
            Dir.chdir('saves')
            File.open("#{name}#{Time.now.strftime("%Y-%m-%d")}.txt",'w') do |f|
                f.write "#{@name}\n"
                f.write "#{@word}\n"
                f.write "#{@current}\n"
                f.write "#{@letters}\n"
            end
            
        else
            Dir.mkdir('saves')
                Dir.chdir('saves') do
                    File.open("#{name}#{Time.now.strftime("%Y-%m-%d")}.txt",'w') do |f|
                        f.write "#{@name}\n"
                        f.write "#{@word}\n"
                        f.write "#{@current}\n"
                        f.write "#{@letters}\n"
                    end
                end
        end
        main
    end


end

def load
        
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

def wordchecker

end

def output(word, letters)
    puts word
    puts letters
end

def new_game(list)
    print "Please enter your name \n>"
    name = gets.chomp
    player1 = Player.new(list,name)
    puts player1.word
    puts player1.name
    player1.save
end

def game_loop
    
end

def credits
    puts "Hangman in Ruby v1.0 created by Brett Flanders\n\n"
end

def main
    puts "Hangman"
    puts "Loading"
    words = load_dictionary
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
        if answer == "1"
            new_game(words)
        elsif answer == "2"
            load
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