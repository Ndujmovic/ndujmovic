require 'tf_idf.rb'
require 'test/unit'

class TestTfIdf < Test::Unit::TestCase

  def test_count_tokens
     small_words = "hi la ok la la hi"
     assert_equal 0, count_tokens(small_words.tokenize).size

     distinct_words = "there are many distinct words here sizes eight"
     assert_equal 8, count_tokens(distinct_words.tokenize).size

     repeat_words = "repeat repeat again again words"
     assert_equal 3, count_tokens(repeat_words.tokenize).size

     some_punctuation = "look there's some... periods (and stuff)"
     assert_equal 5, count_tokens(some_punctuation.tokenize).size

     empty_string = ""
     assert_equal 0, count_tokens(empty_string).size
  end

  def test_get_word_counts
     assert_equal nil, get_word_counts('notafile')
  end

  def test_cosine_sim
     assert_equal nil, get_cosine_sim('notadir')
  end

  def test_create_idfs
     assert_equal nil, create_idfs('notadir')
  end
end
