
module Saveable

  def save
    if @id.nil?
      QuestionsDatabase.instance.execute(<<-SQL, *save_values)
        INSERT INTO
          #{table_name} #{column_names}
          VALUES
          #{values_splat}
          SQL

      @id = QuestionsDatabase.instance.last_insert_row_id
    else
      update
    end
  end

  def update
    QuestionsDatabase.instance.execute(<<-SQL)
      UPDATE
        #{table_name}
      SET
        #{update_values}
      WHERE
        id = #{@id}
    SQL
  end
end
