require 'sinatra'
require 'sinatra/reloader'
require_relative 'lib/game_logic.rb'

set :number , 0

def reset
  settings.number = rand(1..100)
  @@count   = 6
  @@correct = false
end

reset

get '/' do
  @@count -= 1

  guess = params["guess"]
  cheat = params["cheat"]

  if params["retry"] == "true" || @@count < 0
    reset
    redirect "/"
  end

  cheat = cheat ? settings.number : ""

  message = check_guess(guess, settings.number, @@count)

  erb :index, :locals => { :number=>settings.number, :message=>message, :cheat=>cheat }
end


