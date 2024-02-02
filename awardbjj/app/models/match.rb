class Match < ApplicationRecord
  # enum status: { pending: 'Pending', ongoing: 'Ongoing', completed: 'Completed' }
  # enum win_type: { submission: 'Submission', points: 'Points', advantages: 'Advantages', penalties: 'Penalties' }
  validate :competitors_must_be_different
  validate :winner_must_be_competitor
  # validate :first_competitor_must_be_present
  
  belongs_to :bracket
  belongs_to :competitor1, class_name: 'Registration'
  belongs_to :competitor2, class_name: 'Registration', optional: true
  belongs_to :winner, class_name: 'Registration', optional: true

  private
    def first_competitor_must_be_present
      if competitor1.nil?
        errors.add(:base, "First competitor can't be not present")
      end
    end

    def competitors_must_be_different
      if competitor1 == competitor2
        errors.add(:base, "Competitors must be different")
      end
    end

    def winner_must_be_competitor
      if winner && (winner != competitor1 && winner != competitor2)
        errors.add(:winner, "must be one of the competitors or nil")
      end
    end
end
