
class Student
  attr_reader :first, :last
  attr_accessor :list_of_courses, :credits

  def initialize(first, last)
    @first = first
    @last = last
    @list_of_courses = []
    @credits = {}
  end

  def name
    "#{first} #{last}"
  end

  def courses
    courses = []
    list_of_courses.each do |enrolled|
      courses << enrolled.course_name
    end

    courses
  end

  def enroll(course)
    list_of_courses.each do |enrolled|
      if enrolled.conflict_with?(course)
        p "conflict"
        return nil
      end
    end

    list_of_courses << course
    if credits.has_key? course.department
      credits[course.department] += course.credits
    else
      credits[course.department] = course.credits
    end

    course.add_student(self)
    p "succesfully enrolled"
  end

  def course_load
    credits
  end
end

class Course
  attr_reader :course_name, :department, :credits, :days, :block
  attr_accessor :list_students

  def initialize(course_name, department, credits, days, block)
    @course_name = course_name
    @department = department
    @credits = credits
    @list_students = []
    @days = days
    @block = block
  end

  def add_student(student)
    list_students << student.name
  end

  def students
    list_students
  end

  def conflict_with?(course)
    if !(days & course.days).empty? && block == course.block
      true
    else
      false
    end
  end
end

kevin = Student.new("Kevin", "Wang")
charlie = Student.new("Charlie", "Wang")

math1 = Course.new("math1","math",2, [:tue, :thu], 4)
math2 = Course.new("math2","math",2, [:mon, :tue, :wed], 4)
bio1 = Course.new("bio1","science",2, [:mon, :wed], 5)
bio2 = Course.new("bio2","science",2, [:sat], 8)

charlie.enroll(math1)
charlie.enroll(bio1)
kevin.enroll(math1)

p charlie.courses
p charlie.course_load

charlie.enroll(math2)

p math1.students
