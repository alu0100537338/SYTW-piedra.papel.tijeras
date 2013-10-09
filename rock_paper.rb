require 'rack'
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

      res = Rack::Response.new      
    end # call
  end   # App
end     # RockPaperScissors
