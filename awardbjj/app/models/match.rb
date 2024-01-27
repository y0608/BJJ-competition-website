class Match < ApplicationRecord
    # enum status: { pending: 'Pending', ongoing: 'Ongoing', completed: 'Completed' }
    # enum win_type: { submission: 'Submission', points: 'Points', advantages: 'Advantages', penalties: 'Penalties' }
    
    belongs_to :bracket
    belongs_to :competitor1, class_name: 'Registration'
    belongs_to :competitor2, class_name: 'Registration'
    belongs_to :winner, class_name: 'Registration', optional: true
end
