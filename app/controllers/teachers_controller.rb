class TeachersController < ApplicationController
	def index
		@teachers = Teacher.find_by_sql(["SELECT name AS name, position AS position,
                                      SUM(loading) AS sumload, COUNT(subjects.id) AS count FROM teachers
                                      LEFT JOIN subjects
                                      ON teachers.id = subjects.id_teach
                                      GROUP BY name, position
                                      ORDER BY sumload;"])
	end

  def show
    @teacher = Teacher.find(params[:id])
    session[:current_teacher] = @teacher.id

  end
end
