require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = (0...12).map { (65 + rand(26)).chr }
  end

  def score
    # Parse the JSON from the api and store it in a variable called dictionary
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    dictionary_serialized = open(url).read
    dictionary = JSON.parse(dictionary_serialized)

    # Through the form we capture the letters defined in the "new" method
    # with the hidden field
    # and call those letters with param[:letter] and remove every space
    @letters = params[:letters].delete(' ')
    @answer = params[:word].upcase

    # Transform answer and letters in an array
    @answer_array = @answer.split('').sort
    @letters_array = @letters.split('').sort

    # Compare if each letter is included in the letters array
    # Find that letter in the letters_array and can't be higher
    # Total number of that letter can't be higher than in the letters_array

    count_letters = @answer_array.all? { |letter| @answer_array.count(letter) <= @letters_array.count(letter) }
      if count_letters
        if dictionary['found']
          @result = 'Cool answer'
        else
          @result = 'Not English'
        end
      else
        @result = "That's word does't have the size!"
      end

    # if @letters_array.include?(element) && dictionary['found'] && count_letters
    #   @result = 'Cool answer'
    # elsif @answer.size > @letters.size
    #   @result = "That's word does't have the size!"
    # else
    #   @result = 'Not English'
    # end

    # # Checking if the answer has the correct size
    # if @answer.size > @letters.size
    #   @result = "That's an invalid answer! You loose!"
    # # Checking if the word does exist and if the letters are the same than provided
    # elsif dictionary["found"] &&
    #   @result = "Cool answer"
    # else
    #   @result = "Sorry that's not an English word!"
    # end
  end
end
