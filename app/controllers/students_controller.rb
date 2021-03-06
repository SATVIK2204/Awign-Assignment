class StudentsController < ApplicationController
  def index
    @students = Student.all
  end

  def show
    @student = Student.find(params[:id])
    @courses = @student.courses
    @enrollments = @student.enrollments
  end
  
  def new
    @student = Student.new
  end

  def create
    @student = Student.create(params.require(:student).permit(:name, :age))
    if @student.valid?
      redirect_to(students_path)
      # redirect_to('/students/index')
    else
      flash[:errors] = @student.errors.full_messages
      redirect_to(new_student_path)
      # redirect_to('/students/new')
    end
  end

  def edit
    @student = Student.find(params[:id])
  end

  def update
    student = Student.find(params[:id])
    student_params = params.require(:student).permit(:name, :age)
    student.update(student_params)
    redirect_to student_path(student)
  end

  def destroy
    student = Student.find(params[:id])
    student.destroy
    redirect_to students_path
  end
end
