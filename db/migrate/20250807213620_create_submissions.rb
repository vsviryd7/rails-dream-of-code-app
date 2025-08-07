class CreateSubmissions < ActiveRecord::Migration[8.0]
  def change
    create_table :submissions do |t|
      t.references :enrollment
      t.references :lesson
      t.references :mentor

      t.timestamps
    end
  end
end
