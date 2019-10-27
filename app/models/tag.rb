class Tag < ApplicationRecord

scope :payment1, -> (payment) { where payment: payment }
scope :internship1, -> (internship) { where internship: internship }
scope :urgency1, -> (urgency) { where urgency: urgency }
scope :miscellaneous1, -> (miscellaneous) { where miscellaneous: miscellaneous }
scope :branch1, -> (branch) { where branch: branch }
scope :difficulty1, -> (difficulty) { where difficulty: difficulty }
belongs_to :problem
<<<<<<< HEAD

=======
>>>>>>> 3655feb514f7e3a1f7181e7cbd25c8908fbbafc4
validates :deadline,presence: true
end
