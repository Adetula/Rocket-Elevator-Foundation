class CreateInterventions < ActiveRecord::Migration[5.2]
  def change
    create_table :interventions do |t|
      t.bigint :author_id, null: false
      t.references :customer, foreign_key: true, null: false
      t.references :building, foreign_key: true, null: false
      t.references :battery, foreign_key: true
      t.references :column, foreign_key: true
      t.references :elevator, foreign_key: true
      t.references :employee, foreign_key: true
      t.datetime :start_date
      t.datetime :end_date
      t.string :result, default: "Incomplete"
      t.text :report
      t.string :status, default: "Pending"
    end
  end
end
