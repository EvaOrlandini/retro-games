class BlackjackController < ApplicationController
  attr_accessor :player_cards, :bank_cards, :player_score, :bank_score, :result
  before_action :initialize_game_state

  CARDS = {
    "2_of_hearts" => 2, "2_of_diamonds" => 2, "2_of_clubs" => 2, "2_of_spades" => 2,
    "3_of_hearts" => 3, "3_of_diamonds" => 3, "3_of_clubs" => 3, "3_of_spades" => 3,
    "4_of_hearts" => 4, "4_of_diamonds" => 4, "4_of_clubs" => 4, "4_of_spades" => 4,
    "5_of_hearts" => 5, "5_of_diamonds" => 5, "5_of_clubs" => 5, "5_of_spades" => 5,
    "6_of_hearts" => 6, "6_of_diamonds" => 6, "6_of_clubs" => 6, "6_of_spades" => 6,
    "7_of_hearts" => 7, "7_of_diamonds" => 7, "7_of_clubs" => 7, "7_of_spades" => 7,
    "8_of_hearts" => 8, "8_of_diamonds" => 8, "8_of_clubs" => 8, "8_of_spades" => 8,
    "9_of_hearts" => 9, "9_of_diamonds" => 9, "9_of_clubs" => 9, "9_of_spades" => 9,
    "10_of_hearts" => 10, "10_of_diamonds" => 10, "10_of_clubs" => 10, "10_of_spades" => 10,
    "jack_of_hearts" => 10, "jack_of_diamonds" => 10, "jack_of_clubs" => 10, "jack_of_spades" => 10,
    "queen_of_hearts" => 10, "queen_of_diamonds" => 10, "queen_of_clubs" => 10, "queen_of_spades" => 10,
    "king_of_hearts" => 10, "king_of_diamonds" => 10, "king_of_clubs" => 10, "king_of_spades" => 10,
    "ace_of_hearts" => 11, "ace_of_diamonds" => 11, "ace_of_clubs" => 11, "ace_of_spades" => 11
  }

  def index
  end

  def start_game
    @deck = CARDS.keys.shuffle
    @player_cards = [@deck.pop, @deck.pop]
    @bank_cards = [@deck.pop, @deck.pop]
    @player_score = @player_cards.map { |card| CARDS[card] }.sum
    @bank_score = @bank_cards.map { |card| CARDS[card] }.sum
    @result = nil
    save_to_session
    render :index
  end

  def new_card
    if session[:deck].nil? || session[:deck].empty?
      start_game  # Si pas de partie en cours, on en démarre une nouvelle
    else
      initialize_game_state
      @player_cards.push(@deck.pop)
      @player_score = @player_cards.map { |card| CARDS[card] }.sum
      end_game if @player_score > 21
      save_to_session
      render :index
    end
  end

  def bank_new_card
    until @bank_score > 21 || @bank_score > @player_score
      @bank_cards.push(rand(1..11))
      @bank_score = @bank_cards.sum
    end
    end_game
    save_to_session
    render :index
  end

  def end_game
    if @player_score > 21
      @result = "Vous avez perdu"
    elsif @bank_score > 21
      @result = "Vous avez gagné"
    elsif @player_score > @bank_score
      @result = "Vous avez gagné"
    elsif @player_score < @bank_score
      @result = "Vous avez perdu"
    else
      @result = "Égalité"
    end
  end

  private

  def initialize_game_state
    @player_cards = session[:player_cards] || []
    @bank_cards = session[:bank_cards] || []
    @player_score = session[:player_score] || 0
    @bank_score = session[:bank_score] || 0
    @result = session[:result] || nil
    @deck = session[:deck] || []
  end

  def save_to_session
    session[:player_cards] = @player_cards
    session[:bank_cards] = @bank_cards
    session[:player_score] = @player_score
    session[:bank_score] = @bank_score
    session[:result] = @result
    session[:deck] = @deck
  end
end
