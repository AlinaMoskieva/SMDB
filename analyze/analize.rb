require "pg"

class Analize
  INSERT_AMOUNT = 50
  UPDATE_AMOUNT = 4_000_000
  DESTROY_AMOUNT = 1_000_000

  def insert
    INSERT_AMOUNT.times do
      connection.exec("insert into uploads (name) values (#{Random.rand.to_s})");
    end
  end


  private

  def connection
    @connection ||= PG.connect dbname: "SMDB", user: "postgres", password: "moskieva"
  end
end

uploader = Analize.new
# uploader.insert
# uploader.update
# uploader.delete