require 'rack/request'
require 'rack/response'
require 'haml'
  
module RockPaperScissors
  class App 

    def initialize(app = nil)
      @app = app
      @content_type = :html
      @defeat = {'rock' => 'scissors', 'paper' => 'rock', 'scissors' => 'paper'}
      @throws = @defeat.keys
      
    end

    def haml(template, resultado)
      template_file = File.open(template, 'r')
      Haml::Engine.new(File.read(template_file)).render({},resultado)
    end

    def call(env)
      req = Rack::Request.new(env)

      req.env.keys.sort.each { |x| puts "#{x} => #{req.env[x]}" }

      computer_throw = @throws.sample
      player_throw = req.GET["choice"]
      anwser = if !@throws.include?(player_throw)
          "Choose one of the following:"
        elsif player_throw == computer_throw
          "You tied with the computer"
        elsif computer_throw == @defeat[player_throw]
          "Nicely done; #{player_throw} beats #{computer_throw}"
        else
          "Ouch; #{computer_throw} beats #{player_throw}. Better luck next time!"
        end
	
	resultado = 
		{
		:choose => @choose,
		:anwser => anwser,
		:throws => @throws,
		:computer_throw => computer_throw,
		:player_throw => player_throw}
      res = Rack::Response.new(haml("views/index.html.haml", resultado))
     
    end # call
  end   # App
end     # RockPaperScissors
  

