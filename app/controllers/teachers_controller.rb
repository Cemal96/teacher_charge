class TeachersController < ApplicationController
	def index
		@teachers = Teacher.find_by_sql(["SELECT teachers.id AS id, name AS name, position AS position,
                                      SUM(loading) AS sumload, COUNT(subjects.id) AS count FROM teachers
                                      LEFT JOIN subjects
                                      ON teachers.id = subjects.id_teach
                                      GROUP BY teachers.id ,name, position
                                      ORDER BY sumload;"])
	end

  def show
    if params[:id]
      @teacher = Teacher.find(params[:id])
      session[:current_teacher] = @teacher.id
    else
      session[:current_teacher] = nil
    end
    @subjects = Subject.find_by_sql(["SELECT subjects.id AS id,
                                      disciplines.name AS dname,type AS type, 
                                      teachers.name AS tname, position AS position, 
                                      loading AS loading FROM subjects
                                      LEFT JOIN disciplines
                                      ON subjects.id_disc = disciplines.id
                                      LEFT JOIN types
                                      ON subjects.id_type = types.id
                                      LEFT JOIN teachers
                                      ON subjects.id_teach = teachers.id
                                      WHERE id_teach IS NULL"])
  end

  def update
    @subject = Subject.find(params[:id])
    @teacher = Teacher.find_by id: session[:current_teacher]
    if @teacher.position == "Асистент"
      if @subject.id_type != 2 && @subject.id_type != 3
        redirect_to teachers_path
      else
        t_id = @teacher.id
        s_id = @subject.id

        sql = ActiveRecord::Base.connection()
        sql.execute("update subjects set id_teach= #{t_id} where id=#{s_id}")
        redirect_to teachers_path
      end 
    else
      t_id = @teacher.id
      s_id = @subject.id

      sql = ActiveRecord::Base.connection()
      sql.execute("update subjects set id_teach= #{t_id} where id=#{s_id}")
      redirect_to teachers_path
    end
  end

  def show_delete
    @teacher = Teacher.find(params[:id])
  end

  def delete
    sql = ActiveRecord::Base.connection()
    sql.execute("DELETE FROM teachers
                WHERE id = #{params[:id]};")
    redirect_to teachers_path
  end

  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.find_by name: params[:name]
      if @teacher == nil
        @teacher = Teacher.new
        sql = ActiveRecord::Base.connection()
        sql.execute("INSERT INTO teachers 
                   (name,position)
                    VALUES ('#{params[:teacher][:name]}', '#{params[:teacher][:position]}');")
      end
    redirect_to teachers_path
  end
end
