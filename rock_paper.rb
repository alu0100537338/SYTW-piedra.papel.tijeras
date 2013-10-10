require 'rack/request'
require 'rack/response'
require 'haml'
  
module RockPaperScissors
  class App 

    def initialize(app = nil)
      @app = app
      @content_type = :html
      @defeat = {'Piedra' => 'Tijeras', 'Papel' => 'Piedra', 'Tijeras' => 'Papel'}
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
      answer = if !@throws.include?(player_throw)
          "No olvides elegir elmento!"
        elsif player_throw == computer_throw
          "Empate! It's something!"
        elsif computer_throw == @defeat[player_throw]
          "Ganaste! #{player_throw} vence a #{computer_throw}! Bite the dust #{computer_throw}!"
        else
          "Oh no! #{computer_throw} vence a #{player_throw}! Try again, don't let #{computer_throw} win!"
        end
	
	resultado = 
		{
		:choose => @choose,
		:answer => answer,
		:throws => @throws,
		:computer_throw => computer_throw,
		:player_throw => player_throw}
      res = Rack::Response.new(haml("views/index.html.haml", resultado))
     
    end # call
  end   # App
end     # RockPaperScissors
  

