require "pg"

class Uploader
  INSERT_AMOUNT = 2000

  def insert
    INSERT_AMOUNT.times do
      connection.exec("insert into common_dictionary (type, name, end_date, status, par_id) values ('shop', 'my shop_#{Random.rand}', current_timestamp, true, 1);");
      connection.exec("insert into common_dictionary (type, name, end_date, status, par_id) values ('card_type', 'my card_type_#{Random.rand}', current_timestamp, true, 1);");
      connection.exec("insert into common_dictionary (type, name, end_date, status, par_id) values ('event', 'my event_type_#{Random.rand}', current_timestamp, true, 1);");
      connection.exec("insert into common_dictionary (type, name, end_date, status, par_id) values ('event', 'my event_type_#{Random.rand}', current_timestamp, false, 1);");
      connection.exec("insert into common_dictionary (type, name, end_date, status, par_id) values ('adress', 'my adress_#{Random.rand}', current_timestamp, true, 1);");
    end
  end

  private

  def connection
    @connection ||= PG.connect dbname: "SMDB", user: "moskieva", password: ""
  end
end

uploader = Uploader.new
uploader.insert
