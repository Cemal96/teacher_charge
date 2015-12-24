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
                              ON subjects.id_teach = teachers.id
                              ORDER BY disciplines.name, type;"])
	end

  def disc_loading
    @subjects = Subject.find_by_sql(["SELECT name AS name,
                                      SUM(loading) AS sumload FROM disciplines
                                      LEFT JOIN subjects
                                      ON disciplines.id = subjects.id_disc
                                      GROUP BY name
                                      ORDER BY sumload;"])
  end

  def edit
    find_subject
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new
    @disciplines = Discipline.all
    @types = Type.all
    @teachers = Teacher.all
  end

  def create
    @subject = Subject.new
    @discipline = Discipline.find_by id: params[:subject][:id_disc]
    @type = Type.find_by id: params[:subject][:id_type]
    #@teacher = Teacher.find_by id: params[:subject][:id_teach]
    if @discipline == nil || @type == nil
      sql = ActiveRecord::Base.connection()
      sql.execute("INSERT INTO subjects 
                 (id_disc,id_type,id_teach,loading)
                  VALUES (#{params[:subject][:id_disc]}, #{params[:subject][:id_type]}, #{params[:subject][:id_teach]}, #{params[:subject][:loading]});")
    end
    redirect_to subjects_path
  end

  def update

    @subject = Subject.find(params[:id])
    @teacher = Teacher.find_by id: params[:subject][:tname]
    if @teacher != nil
      t_id = @teacher.id
      s_id = @subject.id

      sql = ActiveRecord::Base.connection()
      sql.execute("update subjects set id_teach= #{t_id} where id=#{s_id}")
    else
      @subject = Subject.find(params[:id])
      s_id = @subject.id

      sql = ActiveRecord::Base.connection()
      sql.execute("update subjects set id_teach= NULL where id=#{s_id}")
    end
    redirect_to subjects_path
  end

  def delete
    sql = ActiveRecord::Base.connection()
    sql.execute("DELETE FROM subjects
                WHERE id = #{params[:id]};")
    redirect_to subjects_path
  end



  private
    def find_subject
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
end
