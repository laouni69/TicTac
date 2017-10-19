class BoardCase

    attr_accessor :casevalue,:boardcases

    def initialize(casevalue)       
        @casevalue = casevalue        
    end

    def case_status
        if @casevalue == "X"
            return "X"
        elsif @casevalue == "O"
            return "O"
        else 
            return @casevalue
        end        
    end

    def set_value(valeur)
        @casevalue = valeur        
    end

    def read_value(valeur)        
        return @casevalue        
    end	
end
class Cell
	attr_accessor :name, :number, :value
	def initialize (name, number, value)
		@name=name
		@number=number
		@value=value
	end

	def change_value (value)
		@value=value
		#puts @value
	end
end
class tableau

    attr_accessor :winning_positions, :tableau, :casevalue, :grille, :cases

    def initialize
        @winning_positions = [[1,2,3],[4,5,6],[7,8,9],[2,5,8],[3,6,9],[3,5,7],[1,4,7],[1,5,9]]
        @grille = [nil,nil,nil,nil,nil,nil,nil,nil,nil]  
        create_cases
    end

    def create_cases
        @cases = []
        9.times do |nombre|
            @cases[nombre] = Case.new(nombre + 1)
        end   
    end
    
    def show
        p "+---+---+---+"  
        p "| #{@cases[0].case_status} | #{@cases[1].case_status} | #{@cases[2].case_status} |"
        p "+---+---+---+"
        p "| #{@cases[3].case_status} | #{@cases[4].case_status} | #{@cases[5].case_status} |"
        p "+---+---+---+"
        p "| #{@cases[6].case_status} | #{@cases[7].case_status} | #{@cases[8].case_status} |"
        p "+---+---+---+"  
    end
    
    def show_values
        p @tableau
    end

    def add_to_tableau(id,valeur)
        @grille[id] = valeur.to_s
        @cases[id].set_value(valeur)
    end

    def show_tableau_value(value)
        return @tableau[value]
    end

    def show_winning_pos
        return @winning_positions
    end

    def show_cases
        return @cases
    end
end

class Player

    attr_accessor :name, :pawn

    def initialize (name, pawn)
        @name = name
        @pawn = pawn
    end
def user_turn
    put_line
    puts "\n  RUBY TIC TAC TOE".purple
    draw_game
    print "\n #{@user_name}, please make a move or type 'exit' to quit: ".neon
    STDOUT.flush
    input = gets.chomp.downcase.to_sym
    put_bar
    if input.length == 2
      a = input.to_s.split("")
      if(['a','b','c'].include? a[0])
        if(['1','2','3'].include? a[1])
          if @places[input] == " "
            @places[input] = @user
            put_line
            puts " #{@user_name} marks #{input.to_s.upcase.green}".neon
            check_game(@cpu)
          else
            wrong_move
          end
        else
          wrong_input
        end
      else
        wrong_input
      end
    else
      wrong_input unless input == :exit
    end
  end

    def current_player
        if @counter.even? == true
            @joueur_actuel = @player1.showname
            @pawn_actuel = @player1.pawn
        else
            @joueur_actuel = @player2.showname
            @pawn_actuel = @player2.pawn
        end
    end

    def gaming
        @counter = 0
        cases_jouees = []
        @gagnant = 0
        while @counter < 9 && @gagnant == 0
            puts "\n"
            puts "Tour numéro #{@counter +1 }"
            current_player
            puts "\n"
            @plateau.show
            puts "\n"
            loop do
                puts "Choisissez une case vide"
                @case = gets.chomp.to_i
                unless cases_jouees.include?(@case)
                    break
                else
                    puts "\nLa case est déjà prise ! \n"
                end	
            end
            cases_jouees << @case
            @case > 0 ? (@case = @case - 1) : (@case = 0)
            @plateau.add_to_table(@case,@pawn_actuel)
            gagne 
            @counter +=1	
        end
        puts "+------------------------------+"
        puts "|        FIN DE PARTIE         |"
        puts "+------------------------------+"
    end

    def new_board
        @plateau = Board.new
    end
end

morpawn = Game.new