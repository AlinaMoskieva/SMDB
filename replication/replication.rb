require "pg"

class Replication
  def copy
    connection.exec("select destination_id, table_name, action, changes, created_at from logs where replied = false").each_row do |row|
      send("#{row[2].downcase}_row", row)
      set_replied_as_true(row)
    end
  end

  private
  
  def insert_row(row)
    hash = eval(row[3])
    fields = hash.keys.join(', ')
    values = hash.values.join("', '")
    connection.exec("insert into stand_by_table (#{fields}) values ('#{values}')")
  end
  
  def update_row(row)
    hash = eval(row[3])
    updates = hash.map { |k, v| "#{k} = '#{v}'" }.join(", ")
    connection.exec("update stand_by_table set #{updates} where id = #{row[0]}")
  end
  
  def delete_row(row)
    connection.exec("delete from stand_by_table where id = #{row[0]}")
  end

  def set_replied_as_true(row)
    connection.exec("update logs set replied = true where table_name = '#{row[1]}' and created_at = '#{row.last}'")
  end

  def connection
    @connection ||= PG.connect dbname: "SMDB", user: "moskieva", password: ""
  end
end

replica = Replication.new
replica.copy