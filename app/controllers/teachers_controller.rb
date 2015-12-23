class TeachersController < ApplicationController
	def index
		@teachers = Teacher.find_by_sql(["SELECT name AS name, position AS position,
                                      SUM(loading) AS sumload FROM teachers
                                      LEFT JOIN subjects
                                      ON teachers.id = subjects.id_teach
                                      GROUP BY name, position;"])
	end
end
