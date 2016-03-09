COLORS = ["white","green","blue","red","black","yellow"]
class Cell
	attr_accessor :value, :is_Opened
	def initialize(input = COLORS.sample)
		@value = input
		@is_Opened = false
	end	
end	

class Board
 attr_accessor :cells, :counter		
 def initialize(input = Array.new(4){Cell.new})
 	@cells = input
 	@counter = 12
 end	

 def get_cell(num)
 	@cells[num]
 end

  def set_cell(num, value)
 	@cells[num] = value
 end

 def draw
 	@cells.each do |cell|
 		print " - " if cell.is_Opened == false
 		print cell.value if cell.is_Opened == true
 	end	
 	 		puts
 end		

 def proverka_otveta(attempt)
 	  	@counter -= 1
 	if attempt[1] == @cells[attempt[0].to_i].value
 		@cells[attempt[0].to_i].is_Opened = true
 		puts "Ugadal polnost'yu!" 
 	elsif @cells.any? {|cell| cell.value == attempt[1]}	
 		puts "Takoi cvet est' no ne na etoi posicii!"
 	else
 		puts "Vot voobshe ne ugadal" 
 	end	
 end	

 def game_over
 	return true if is_Win? || is_Lose?
 	false
 end	

  def is_Win?
 	return true if @cells.all? {|cell| cell.is_Opened == true}
 	false
 	end	
   def is_Lose?
 	return true if @counter == 0 && @cells.any? {|cell| cell.is_Opened == false}
 	false
 	end	

end	

class Player
	attr_accessor :name
	def initialize(name)
		@name = name
	end	

	def guess(position,value)
		attempt = [position, value]
	end	
end	

class Game
	attr_accessor :player, :board
	def initialize
		@board = Board.new
	end

	def play
		puts "vvedite imya pozhaluista:"
		name = gets.chomp
		@player = Player.new(name)
		print board.cells.inspect
		until board.game_over
			puts "U vas #{board.counter} popytok"
			board.draw

			puts "Vvedite posiciyu(1,2,3,4):"
			position = gets.chomp.to_i - 1
			puts "Vvedite znachenie(white,green,blue,red,black,yellow):"
			value = gets.chomp.downcase
			board.proverka_otveta(player.guess(position,value))
			puts "Da ty pobedil zasranec!" if board.is_Win?
		end	

	end	
end	

puts "Hello, in my game!"
Game.new.play