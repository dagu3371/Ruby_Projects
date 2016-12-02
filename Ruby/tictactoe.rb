$status = "ongoing"

class Board #Reading and writing to the board
  def initialize()
    @@boards = Array.new(3){Array.new(3,0)}
    @@turn =1
    @@token = "x"
    
  end

	def diagcheck(r,c)
	    if  [@@boards[0][0], @@boards[1][1], @@boards[2][2]].uniq.length==1 && @@boards[1][1]!=0
	    	win(r,c)
	    end

	 	if  [@@boards[2][0], @@boards[1][1], @@boards[0][2]].uniq.length==1 && @@boards[1][1]!=0
		    win(r,c)
		end

	    if [@@boards[1][0], @@boards[1][1], @@boards[1][2]].uniq.length==1 && @@boards[1][1]!=0
	      win(r,c) 
	    end
	  
		if [@@boards[0][1], @@boards[1][1], @@boards[2][1]].uniq.length==1 && @@boards[1][1]!=0     
	    	win(r,c)
	    end  

 		#left column
    	if [@@boards[0][0], @@boards[1][0], @@boards[2][0]].uniq.length==1 && @@boards[1][0]!=0
			win(r,c)  
    	end
    	#top
    	if [@@boards[0][0], @@boards[0][1], @@boards[0][2]].uniq.length==1 && @@boards[0][1]!=0
			win(r,c)  
    	end
    	#right
    	if [@@boards[0][2], @@boards[1][2], @@boards[2][2]].uniq.length==1 && @@boards[1][2]!=0
			win(r,c)  
    	end
    	#bottom
    	if [@@boards[2][0], @@boards[2][1], @@boards[2][2]].uniq.length==1 && @@boards[2][1]!=0
			win(r,c)  
    	end
  	end
  
  def centrecheck2 #Vertical centre check  
    if @@boards[2][1]== @@boards[1][1] && @@boards[2][1]== @@boards[0][1]
      r =2
      c=1
      win(r,c)  
    end  
  end



  def win(r,c)
    if @@boards[r][c]=="x"
      puts "Player 1 wins!"
      $status ="won"
    else 
      puts "Player 2 wins!"
      $status="won"
    end
  end
  
  def board1(r,c) #board inputs for players
      if @@turn.odd?
        @@token = "x"
      else
        @@token = "$"
      end
      if @@game= "ongoing"
        @@boards[r][c]= @@token
      else
        puts "Game Over"
      end
      diagcheck(r,c)
      @@boards.each { |x| puts x.join(" ")}
      puts ("   ")

      @@turn+=1
  end

end

class Players<Board #Interactions between game and players go here
 	def initialize()
 	  @@player = Board.new
 	  #@@move = move
 	  @@turn = 1
 	end
 	def move_list()
 	  
 	  case @@move
 	  when "1"
 	      move1(0,0) 
 	  when "2"
 	      move1(0,1)
 	  when "3"  
 	      move1(0,2)  
 	  when "4"  
 	      move1(1,0)
 	  when "5" 
 	      move1(1,1)
 	  when "6"  
 	      move1(1,2)
 	  when "7"  
 	      move1(2,0)
 	  when "8"  
 	      move1(2,1)
 	  when "9"  
 	      move1(2,2)
 	  else 
 	    puts "invalid move"
 	  end
 

 	end

  def firstplayer(name ="Mr")
    puts "Please input a move #{name}."
    @@move =gets.chomp
    move_list()
  end
 	def secondplayer(name ="Mrs")
    puts "Please input a move #{name}."
    @@move =gets.chomp
    move_list()
  end
  
 	def move1(x=0,y=0)
 	    @@player.board1(x,y)
 	end

end

class Game <Players
  def initialize
  @@gamer = Players.new  
  @@turn_number = 1
  end
  def begin
    puts "what is player 1's name?"
    @@player1 = gets.chomp
    puts "what is player 2's name?"
    @@player2 =gets.chomp
    while $status=="ongoing"
      turns(@@turn_number)
    end
  end
  def turns(turn_number)
  	#puts "Turn number #{turn_number}"
  	if @@turn_number >9
  		puts "Game is a draw."
  		$status ="draw"
  	elsif @@turn_number.odd?
      @@gamer.firstplayer(@@player1)
      @@turn_number += 1
    else
      @@gamer.secondplayer(@@player2)
      @@turn_number += 1
  	end

  end
end
new =Game.new
new.begin





