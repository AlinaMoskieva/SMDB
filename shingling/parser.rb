require "pg"

class Parser
  def initialize(file_name, word_lenght)
    insert_document(file_name)
    parse(file_name, word_lenght)
    close_connection
  end

  private

  def parse(file_name, word_lenght)
    contents = File.open(file_name, "r").read.gsub("\n", "")
    word_lenght.times do |i|
      insert(contents.slice(i..contents.length).scan(/.{#{word_lenght}}/).uniq)
    end
  end

  def document_id
    @document_id ||= connection.exec("SELECT id FROM documents ORDER BY id DESC LIMIT 1").getvalue(0,0)
  end

  def connection
    @connection ||= PG.connect dbname: "SMDB", user: "postgres", password: "moskieva"
  end

  def insert_document(file_name)
    connection.exec "INSERT INTO documents (name) VALUES('#{file_name}')"
  end

  def insert(values)
    values.each do |value|
      connection.exec "INSERT INTO shingles (word, document_id, word_lenght) VALUES('#{value}', #{document_id}, #{value.length})"
    end
  end

  def close_connection
    connection.close if connection
  end
end

Parser.new("Genome_1.txt", 2)
Parser.new("Genome_2.txt", 2)
Parser.new("Genome_1.txt", 5)
Parser.new("Genome_2.txt", 5)
Parser.new("Genome_1.txt", 9)
Parser.new("Genome_2.txt", 9)
