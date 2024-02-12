class Match < ApplicationRecord

  after_commit -> { 
    broadcast_replace_later_to "matches_scoreboard_1", partial: "scoreboards/scoreboard", target: "match_scoreboard_1", locals: { match: self }
    broadcast_replace_later_to "matches_show_1", partial: "matches/ongoing_match", target: "match_1", locals: { match: self }
  }

  ROUND_LABELS = [
    "Final", "Semi-final", "Quarter-final", "Round of 16", "Round of 32", 
    "Round of 64", "Round of 128", "Round of 256", "Round of 512", "Round of 1024"
  ]

  enum win_type: {
    points: 0,
    submission: 1,
    disqualification: 2,
    walkover: 3,
    no_show: 4,
    decision: 5,
  }

  enum status: {
    not_started: 0,
    in_bull_pen: 1,
    playing: 2,
    finished: 3
  }
  
  validate :competitors_must_be_different
  validate :winner_must_be_competitor
  
  belongs_to :bracket
  belongs_to :competitor1, class_name: 'User', optional: true
  belongs_to :competitor2, class_name: 'User', optional: true
  belongs_to :winner, class_name: 'User', optional: true
  
  # WORKS: has_one :next_match, class_name: 'Match', foreign_key: 'next_match_id', dependent: :nullify
  belongs_to :next_match, class_name: 'Match', foreign_key: 'next_match_id', optional: true

  def competitor1_name
    if round == bracket.rounds - 1
      competitor1.nil? ? "BYE" : competitor1.full_name
    else
      competitor1.nil? ? "Waiting..." : competitor1.full_name
    end
  end

  def competitor2_name
    if round == bracket.rounds - 1
      competitor2.nil? ? "BYE" : competitor2.full_name
    else
      competitor2.nil? ? "Waiting..." : competitor2.full_name
    end
  end

  def loser
    if winner == competitor1
      return competitor2
    elsif winner == competitor2
      return competitor1
    end
    nil
  end

  def time_remaining_minutes_and_seconds
    time = time_remaining # in seconds
    minutes = (time / 60).to_i
    seconds = (time % 60).to_i
    "#{minutes.to_s.rjust(2, '0')}:#{seconds.to_s.rjust(2, '0')}"
  end

  def time_remaining
    time_remaining = timer_value

    if !timer_last_started_at.nil?
      if timer_running
        time_remaining = (time_remaining - (Time.now - timer_last_started_at)).round(2)
        if time_remaining <= 0
          time_remaining = 0
        end
      end
    end
    time_remaining
  end

  def start_timer
    if !timer_running
      self.update(
        timer_running: true, 
        status: "playing", 
        timer_last_started_at: Time.now
      )
    end
  end

  def pause_timer
    if timer_running
      self.update(
        timer_running: false, 
        timer_value: time_remaining
      )
    end
  end  


  private
  def competitors_must_be_different
    if competitor1 == competitor2 && competitor1
      errors.add(:base, "Competitors must be different")
    end
  end

  def winner_must_be_competitor
    if winner && (winner != competitor1 && winner != competitor2)
      errors.add(:winner, "must be one of the competitors or nil")
    end
  end
end
