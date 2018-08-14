require "open-uri"
require "json"


class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  # The new action will be used to display a new random grid and a form.
  #The form will be submitted (with POST) to the score action.
  end

  def score
    @word = params[:word].upcase
    word_splited = @word.split('')
    @letters = params[:letters].split('')
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)
    if user['found'] == false
      return @score = "Sorry but #{@word} does not seem to be a valid English word..."
    elsif (user['found'] == true) && ((word_splited.all? { |k| @letters.include? k }) == true)
      return @score = "Congratulations! #{@word} is a valid English word!"
    elsif ((word_splited.all? { |k| @letters.include? k }) == false)
      return @score = "Sorry but #{@word} can't be built out of #{@letters}"
    end
  end
end
