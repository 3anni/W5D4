# == Schema Information
#
# Table name: enrollments
#
#  id         :bigint           not null, primary key
#  course_id  :bigint           not null
#  student_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Enrollment < ApplicationRecord
  validates :course_id, presence: true
  validates :student_id, presence: true

  belongs_to :course,
    primary_key: :id,
    foreign_key: :course_id,
    class_name: :Course

  # any time there's a foreign key, it's a belongs_to
  belongs_to :student, # arbitrary - can call it anything. call class name by default
    primary_key: :id,
    foreign_key: :student_id,
    class_name: :User
end



# Steps
# 1) foreign keys
# 2) belongs_to
# 3) has_manys
# 4) has_many throughs

