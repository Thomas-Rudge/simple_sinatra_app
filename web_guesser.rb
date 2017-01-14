require 'sinatra'
require 'sinatra/reloader'

number = rand(1..100)

get '/' do
  guess = params["guess"]
  message = check_guess(guess, number)
  erb :index, :locals => { :number=>number, :message=>message }
end

def check_guess(guess, number)
  message = "I am thinking of a number between 1 and 100.<br />Can you guess what it is?"
  unless guess.nil?
    if (guess =~ /^\d{1,3}/) && (guess.to_i.between? 1, 100)
      message = case number - guess.to_i
                when 0           then "That's right! I was thinking of #{number}."
                when (-100..-31) then "Way too high. Try again."
                when (-30..-21)  then "Too high. Try again."
                when (-20..-10)  then "Just a bit too high. Try again."
                when (-9..0)     then "Really close! Just a bit lower"
                when (0..9)      then "Really close! Just a bit higher."
                when (10..20)    then "Just a bit too low. Try again."
                when (21..30)    then "Too low. Try again."
                when (31..100)   then "Way too low. Try again."
                else "Woops"
                end
    else
      message = "It has to be a number between 1 and 100."
    end
  end

  message
end
