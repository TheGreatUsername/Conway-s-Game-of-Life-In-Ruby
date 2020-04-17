#Conway's Game of Life
#an interactive cellular automata simulator

class String
    #method to check if string is integer
    def is_i?
       /\A[-+]?\d+\z/ === self
    end
end

def newboard(width, height)
    board = []
    for i in 0..height+1
        board.append([0] * (width + 2))
    end
    board
end

#creates a randomized board
def randomboard(width, height)
    board = newboard(width, height)
    for i in 1..height
        for j in 1..width
            board[i][j] = rand(0..1)
        end
    end
    board
end    

def printboard(board)
    for i in 1..board.length-2
        row = board[i]
        for j in 1..row.length-2
            cell = row[j]
            if cell == 1
                print("#")
            else
                print(".")
            end
        end
        print("\n")
    end
end

#counts alive cells near target cell
def countnear(board, x, y)
    result = 0
    for i in x-1..x+1
        for j in y-1..y+1
            result += board[i][j]
        end
    end
    result -= board[x][y] #remove center point
    result
end

#creates new board representing next generation "Geordi, beam me up!"
def generation(board)
    height = board.length - 2
    width = board[0].length - 2
    result = newboard(height, width)
    for i in 1..height
        for j in 1..width
            near = countnear(board, i, j)
            if near == 3
                result[i][j] = 1
            elsif near == 2
                result[i][j] = board[i][j]
            end
        end
    end
    result
end

def main()
    puts("Enter width of board")
    width = gets.chomp.to_i
    puts("Enter height of board")
    height = gets.chomp.to_i
    board = randomboard(width, height)
    printboard(board)
    puts("")
    loop do
        puts("Press enter for next generation.")
        puts("Type coordinates separated by a space to modify cell.")
        puts("Type \"exit\" to exit.")
        input = gets.chomp()
        #checks if coordinates were entered
        if input.include? " "
            sp = input.split(" ")
            xs = sp[0]
            ys = sp[1]
            #make sure both are integers
            if xs.is_i? && ys.is_i?
                x = xs.to_i
                y = ys.to_i
                board[y+1][x+1] = board[y+1][x+1] == 1 ? 0 : 1
            else
                puts("Invalid input.")
            end
        elsif input == "exit"
            break
        elsif input == ""
            board = generation(board)
        else
            puts("Invalid input.")
        end
        printboard(board)
    end
end

main()