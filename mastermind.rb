# Mastermind is a game of two players, a codemaker and a codebreaker
# in this game a single player begins as the codebreaker while the computer acts
# as the codemaker
# Rules
# -The codemaker selects a 'code' consisting of four colors in a row
# -The codebreaker will guess by entering a string of four colors
# -The codemaker will give feedback on each guess
# --feedback includes a black mark for every entry within the guess correct in location
# ---and color, and a white mark for entries that are correct in color alone
# ---feedback is not given in order
# -The codebreaker will use the feedback to guess the correct sequence within a set
# --number of turns

class Mastermind
  # State who the codemaker will be, human or cpu
  def initialize(name = "cpu")
    @codemaker = name
    @code = []
    @feedback = []
    @colors = ['red','green','blue','yellow','black','white']
  end
  
  def set_code
    if @codemaker == 'human'
        human
      elsif @codemaker == 'cpu'
        cpu
      else
        puts "Improper entry: specify mastermind('human') if you want to be the codemaker"
    end
    @turn = 1
  end
  
  def human
    @code = code_entry
  end
  
  def cpu
    # Generate random code
    @code = code_generate
    puts 'Code generated'
  end
  
  def move
    case @codemaker
      when 'human'
        guess0 = code_generate
        guess(guess0)
        @turn += 1
      when 'cpu'
        guess0 = code_entry
        guess(guess0)
        @turn += 1
    end
  end
    
  def guess(guess0)
    @feedback = []
    if guess0 == @code
      puts "Code cracked on turn #{@turn}!"
      puts "#{@code}"
    else
      count = Hash.new
      @colors.each {|z| count[z] = 0}
      0.upto(3) do |i|
        if guess0[i] == @code[i]
          @feedback[i] = 'black'
          count[guess0[i]] += 1
        end
      end
      
      0.upto(3) do |i|
        if @code.include?(guess0[i]) && count[guess0[i]] < @code.count(guess0[i])
          @feedback[i] = 'white'
          count[guess0[i]] += 1
        elsif @feedback[i] == 'black'
        else
          @feedback[i] = 'none'
        end
      end
      @feedback.shuffle!
      puts "Try again, here is your feedback: #{@feedback}"
    end
  end
  
  def code_entry
    # Generate a code entered by a human
    accept = 'no'
    while accept != 'yes'
      code0 = []
      puts 'Choose your four color code'
      4.times do
        puts 'red,green,blue,yellow,white, or black?'
        entry = gets.chomp
        code0 << entry
      end
      puts "Do you accept this code [yes,no]: #{code0}?"
      accept = gets.chomp
    end
    return code0
  end
  
  def code_generate
    code0 = []
    4.times {code0 <<  @colors[rand(6)]}
    return code0
  end
  
  private :code_entry, :human, :cpu, :code_generate, :guess
  
end