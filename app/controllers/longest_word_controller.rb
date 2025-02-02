require 'open-uri'
require 'json'

class LongestWordController < ApplicationController
  attr_accessor :letters
  before_action :initialize_game_state

  VOWELS = %w(A E I O U Y)

  def new
    @letters = Array.new(10) { VOWELS.sample }
    @letters += Array.new(10) { (('A'..'Z').to_a - VOWELS).sample }
    @letters.shuffle!
    save_to_session
    render :index
  end

  def score
    @letters = params[:letters].split
    @word = (params[:word] || "").upcase
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)

    respond_to do |format|
      format.html
      format.text { render partial: "games/result", formats: [:html], layout: false }
    end
  end

  private

  def initialize_game_state
    @letters = session[:letters] || []
  end

  def save_to_session
    session[:letters] = @letters
  end

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = URI.open("https://dictionary.lewagon.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  rescue
    false
  end
end
