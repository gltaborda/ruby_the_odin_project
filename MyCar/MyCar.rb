# ruby OOP practice using modules and mixins with Towable, 
# inheritance with Vehicle and its childs MyCar and MyTruck
# and a little polymorphism using to_s, which is rewritten

module Towable
  def can_tow?(pounds)
    pounds < 2000 ? true : false
  end
end

class Vehicle
  attr_accessor :color, :current_speed
  attr_reader :year
  @@number_of_vehicles = 0

  def self.number_of_vehicles
    puts "This program has created #{@@number_of_vehicles} vehicles"
  end

  def initialize(year, color, model)
    @year = year
    self.color = color
    @model = model
    self.current_speed = 0
    @@number_of_vehicles += 1
  end
  
  def speed_up(speed)
    self.current_speed +=speed
  end
  def brake(speed)
    self.current_speed -=speed
  end
  def shut_car_off
    self.current_speed = 0
  end
  def spray_paint(new_color)
    self.color = new_color
  end
  def calculate_mileage(gallons,miles)
    puts "#{miles/gallons} miles per gallon of gas"
  end
  def to_s()
    "This is a #{@model} from #{year} and it's painted #{color}."
  end
end

class MyCar < Vehicle
  def initialize (year, color, model)
    super(year, color, model)
    @number_of_wheels = 4
  end

  def to_s()
    super + " It has #{@number_of_wheels} wheels because it's a car."
  end

end

class MyTruck < Vehicle
  include Towable
  def initialize (year, color, model)
    super(year, color, model)
    @number_of_wheels = 8
  end

  def to_s()
    super + " It has #{@number_of_wheels} wheels because it's a truck."
  end

end

auto = MyCar.new("1995", "Black", "Honda Civic")
auto.speed_up(20)
puts auto.current_speed
auto.brake(10)
puts auto.current_speed
auto.shut_car_off
puts auto.current_speed

puts auto

auto.spray_paint("White")
puts auto.color

puts auto

puts auto.year

auto.calculate_mileage(10, 100)

camion = MyTruck.new("1998","Red","Scania")

puts camion

puts camion.can_tow?(1000)

Vehicle.number_of_vehicles


# a little Student exercise about access control

class Student
  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(other_student)
    grade > other_student.grade
  end

  protected

  def grade
    @grade
  end
end

joe = Student.new("Joe", 90)
bob = Student.new("Bob", 84)
puts "Well done!" if joe.better_grade_than?(bob)