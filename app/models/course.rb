class Course < ApplicationRecord
  has_many :enrollments
  has_many :students, through: :enrollments
  has_many :interests
  belongs_to :teacher, class_name: 'Person', foreign_key: 'person_id'

  validates :teacher, presence: true

  validates :title, {
    length: { minimum: 3,  maximum: 30 },
    presence: true,
    uniqueness: true,
  }

  validates :code, {
    length: { minimum: 3,  maximum: 10 },
    presence: true,
    uniqueness: true,
  }

  validates :quota, {
    presence: true,
    numericality: true,
  }

  def to_s
    return title
  end
end
