class Interest < ApplicationRecord
  belongs_to :person, class_name: 'Person', foreign_key: 'person_id'
  belongs_to :course, class_name: 'Course', foreign_key: 'course_id'

  validates :person, presence: true
  validates :course, presence: true
  validates_uniqueness_of :course_id, :scope => :person_id
end
