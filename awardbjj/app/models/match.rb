class Match < ApplicationRecord
  # enum win_type: { submission: 'Submission', points: 'Points', advantages: 'Advantages', penalties: 'Penalties' }
  after_commit -> { 
    broadcast_replace_later_to self,
    partial: "matches/ongoing_match", target: self
  }

  before_save 

  enum match_status: {
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
  
  has_one :next_match, class_name: 'Match', foreign_key: 'next_match_id', dependent: :nullify

  def competitor1_name
    competitor1.nil? ? "BYE" : competitor1.full_name
  end

  def competitor2_name
    competitor2.nil? ? "BYE" : competitor2.full_name
  end

  # return 00:00
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
        match_status: "playing", 
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
