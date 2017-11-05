require "pg"
class JaccardCalculation
  def initialize(word_lenght, first_document_id, second_document_id)
    calculate(word_lenght, first_document_id, second_document_id)
  end

  private

  def connection
    @connection ||= PG.connect dbname: "SMDB", user: "postgres", password: "password"
  end

  def calculate(word_lenght, first_document_id, second_document_id)
    puts "Word length is #{word_lenght} \nFirst document id is #{first_document_id} \nSecond document id is #{second_document_id}"
    jaccard = connection.exec(query(word_lenght, first_document_id, second_document_id)).getvalue(0,0)
    puts "Jaccard value is #{jaccard}\n\n"
  end

  def query(word_lenght, first_document_id, second_document_id)
    "select (
      select count(*)::real from(
        (select word from shingles where document_id = #{first_document_id} and word_lenght = #{word_lenght})
        intersect
        (select word from shingles where document_id = #{second_document_id} and word_lenght = #{word_lenght})
      ) as result )
      /
      (
        select (select count(*) from (
          (select word from shingles where document_id = #{first_document_id} and word_lenght = #{word_lenght})
          union
          (select word from shingles where document_id = #{second_document_id} and word_lenght = #{word_lenght})
        ) as result)
      )"
  end
end

JaccardCalculation.new(2, 84, 85)
JaccardCalculation.new(5, 86, 87)
JaccardCalculation.new(9, 88, 89)
