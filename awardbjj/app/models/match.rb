class Match < ApplicationRecord
  # enum status: { pending: 'Pending', ongoing: 'Ongoing', completed: 'Completed' }
  # enum win_type: { submission: 'Submission', points: 'Points', advantages: 'Advantages', penalties: 'Penalties' }
  validate :competitors_must_be_different
  validate :winner_must_be_competitor
  
  belongs_to :bracket
  belongs_to :competitor1, class_name: 'User', optional: true
  belongs_to :competitor2, class_name: 'User', optional: true
  belongs_to :winner, class_name: 'User', optional: true
  
  has_one :next_match, class_name: 'Match', foreign_key: 'next_match_id', dependent: :nullify

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
