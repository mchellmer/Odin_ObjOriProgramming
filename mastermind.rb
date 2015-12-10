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
    @feed = Hash.new
    @colors = ['red','green','blue','yellow','black','white']
    @cpu_colors = @colors
  
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
        if @turn == 1
          guess0 = code_generate
          guess(guess0)
          @turn += 1
        else
          guess0 = better_guess
          guess(guess0)
          @turn += 1
        end
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
          count[guess0[i]] += 1
        end
      end
      
      0.upto(3) do |i|
        if @code[i] == guess0[i]
          @feedback[i] = 'black'
        elsif @code.include?(guess0[i]) && count[guesso[i]] > @code.count(guess0[i])
          @feedback[i] = 'white'
          count[guess0[i]] += 1
        else
          @feedback[i] = 'none'
        end
      end
      @feedback.shuffle!
      @feed[guess0] = @feedback
      puts "Try again, here is your feedback: "
      @feed.each {|key,value| puts "#{key}: #{value}"}
      
    end
  end
  
  def better_guess
    # Disclude colors should an empty array feedback exist
    @feed.each do |code,score|
      if score.count('none') == 4
        0.upto(3) do |i|
          @cpu_colors.delete(code[i])
        end
      end
    end

    good = false
    until good == true
      guess0 = code_generate
      # Force guess to match entries of black
      @feed.each do |code,score|
        same = 0
        0.upto(3) do |i|
          if code[i] == guess0[i]
            same += 1
          end
        end
        if same == score.count('black')
          good = true
        else
          break
        end
      end
    end
    return guess0
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
    4.times {code0 <<  @cpu_colors[rand(@cpu_colors.length)]}
    return code0
  end
  
  def test
    return @code
  end
  
  private :code_entry, :human, :cpu, :code_generate, :guess
  
end