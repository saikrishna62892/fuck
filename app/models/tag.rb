class Tag < ApplicationRecord
belongs_to :problem
scope :payment1, -> (payment) { where payment: payment }
scope :internship1, -> (internship) { where internship: internship }
scope :urgency1, -> (urgency) { where urgency: urgency }
scope :miscellaneous1, -> (miscellaneous) { where miscellaneous: miscellaneous }
scope :branch1, -> (branch) { where branch: branch }
scope :difficulty1, -> (difficulty) { where difficulty: difficulty }

validates :deadline,presence: true
end
