class SubjectsController < ApplicationController
	def index
	  @subjects = Subject.find_by_sql(["SELECT subjects.id AS id,
                              disciplines.name AS dname,type AS type, 
                              teachers.name AS tname, position AS position, 
                              loading AS loading FROM subjects
                              LEFT JOIN disciplines
                              ON subjects.id_disc = disciplines.id
                              LEFT JOIN types
                              ON subjects.id_type = types.id
                              LEFT JOIN teachers
                              ON subjects.id_teach = teachers.id;"])
	end
  def edit
    @subject = Subject.find_by_sql(["SELECT subjects.id AS id, 
                              disciplines.name AS dname,type, 
                              teachers.name AS tname, position AS position, 
                              loading AS loading FROM subjects
                              LEFT JOIN disciplines
                              ON subjects.id_disc = disciplines.id
                              LEFT JOIN types
                              ON subjects.id_type = types.id
                              LEFT JOIN teachers
                              ON subjects.id_teach = teachers.id
                              WHERE subjects.id = :id;", {:id => params[:id]}])
  end
  def update
    @subject = Subject.find(params[:id])
    @teacher = Teacher.find_by id: params[:subject][:tname]
    t_id = @teacher.id
    s_id = @subject.id

    sql = ActiveRecord::Base.connection()
    sql.execute("update subjects set id_teach= #{t_id} where id=#{s_id}")
    redirect_to subject_path
  end
end

        #Subject.connection.update(“update subjects set id_teach=#{@teacher.id} where id=#{@subject.id}”)
        #@subject.update(id_teach: @teacher.id)