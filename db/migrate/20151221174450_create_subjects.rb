class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.integer :id_disc
      t.integer :id_type
      t.integer :id_teach
      t.integer :loading
    end
  end
end
