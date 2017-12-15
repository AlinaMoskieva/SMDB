require "pg"

class ViewRefresher
  def refresh
    connection.exec("refresh materialized view concurrently master_table_logs_view")
  end

  private

  def connection
    @connection ||= PG.connect dbname: "SMDB", user: "moskieva", password: ""
  end
end

view = ViewRefresher.new
view.refresh