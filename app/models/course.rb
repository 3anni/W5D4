# == Schema Information
#
# Table name: courses
#
#  id            :bigint           not null, primary key
#  name          :string           not null
#  prereq_id     :bigint
#  instructor_id :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Course < ApplicationRecord
  validates :name, presence:true
  validates :prereq_id, presence:false # do we need presence:false here?
  validates :instructor_id, presence:true

  has_many :enrollments,
    primary_key: :id,
    foreign_key: :course_id,
    class_name: :Enrollment,
    dependent:  :destroy # include any time you have has many and not has many through

  # Referencing its own class
  # Because of this, we include optional: true
  belongs_to :prerequisite,
    primary_key: :id,
    foreign_key: :prereq_id,
    class_name: :Course,
    optional: true

  belongs_to :instructor,
    primary_key: :id,
    foreign_key: :instructor_id,
    class_name: :User

  # Need to put at end. Rails will throw error if you try to run before the association you're using was defined
  has_many :enrolled_students,
    through: :enrollments,
    source: :user

    # has_many :students,
  #   primary_key: :id,
  #   foreign_key: :student_id,
  #   class_name: :Enrollment



end
