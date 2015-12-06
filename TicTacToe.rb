class TicTacToe
  def initialize
    puts "Who goes first?"
    @player1 = gets.chomp
    puts "And second?"
    @player2 = gets.chomp
    
    @turn = [@player1,@player2]
    @turnN = 1
    @mark = ['x','o']
    
    @row1 = ' _|_|_'
    @row2 = ' _|_|_'
    @row3 = '  | | '
    puts ' _|_|_' + "\n" + ' _|_|_' + "\n" + '  | | '
  end
  
  def move
    puts "Ok #{@turn[(@turnN + 1) % 2]}, where would you like to go?"
    puts 'Row 1,2,or 3?'
    row = gets.chomp
    
    if [1,2,3].include?(row.to_i) == false
      puts 'Invalid integer entry, try again'
      
    else
      puts 'Column 1,2,or 3?'
      column = gets.chomp
      if [1,2,3].include?(column.to_i) == false
        puts 'Invalid integer entry, try again'
      else
        case row.to_i
          when 1
            if @mark.include?(@row1[column.to_i*2-1])
              puts 'That space is taken'
            else
              @row1[column.to_i*2-1] = @mark[(@turnN + 1) % 2]
              @turnN += 1
            end
          when 2
            if @mark.include?(@row2[column.to_i*2-1])
              puts 'That space is taken'
            else
              @row2[column.to_i*2-1] = @mark[(@turnN + 1) % 2]
              @turnN += 1
            end
          when 3
            if @mark.include?(@row3[column.to_i*2-1])
              puts 'That space is taken'
            else
              @row3[column.to_i*2-1] = @mark[(@turnN + 1) % 2]
              @turnN += 1
            end
        end
        puts "#{@row1}"
        puts "#{@row2}"
        puts "#{@row3}"
        
        if @row1[1] == @row1[3] && @row1[1] == @row1[5] && @row1[1] != '_'
          puts "#{@turn[(@turnN + 1)%2]} has won!!!"
        elsif @row2[1] == @row2[3] && @row2[1] == @row2[5] && @row2[1] != '_'
          puts "#{@turn[(@turnN + 1)%2]} has won!!!"
        elsif @row3[1] == @row3[3] && @row3[1] == @row3[5] && @row3[1] != ' '
          puts "#{@turn[(@turnN + 1)%2]} has won!!!"
        elsif @row1[1] == @row2[1] && @row1[1] == @row3[1] && @row1[1] != '_'
          puts "#{@turn[(@turnN + 1)%2]} has won!!!"
        elsif @row1[3] == @row2[3] && @row1[3] == @row3[3] && @row1[3] != '_'
          puts "#{@turn[(@turnN + 1)%2]} has won!!!"
        elsif @row1[5] == @row2[5] && @row1[5] == @row3[5] && @row1[5] != '_'
          puts "#{@turn[(@turnN + 1)%2]} has won!!!"
        elsif @row1[1] == @row2[3] && @row1[1] == @row3[5] && @row1[1] != '_'
          puts "#{@turn[(@turnN + 1)%2]} has won!!!"
        elsif @row3[1] == @row2[3] && @row3[1] == @row1[5] && @row1[5] != '_'
          puts "#{@turn[(@turnN + 1)%2]} has won!!!"
        end
      end
    end
  end
end
