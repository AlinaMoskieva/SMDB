class Parser
  attr_accessor :file

  def initialize
    @file = File.new("per_transaction_log.csv", "w")
    set_headers_to_output
  end

  def parse(path)
    File.open(path).each do |line|
      file.write(line.gsub(" ", ";"))
    end
    file.close
  end

  private

  def set_headers_to_output
    file.write("client_id;transaction_no;time;file_no;time_epoch;time_us")
  end
end

parser = Parser.new
parser.parse("pgbench_log.10985")