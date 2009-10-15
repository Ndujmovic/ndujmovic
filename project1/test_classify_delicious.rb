require 'test/unit'
require 'classify_delicious.rb'

class ProjectOneTest < Test::Unit::TestCase
   def test_classify_user_links
      bayes = Classifier::Bayes.new 'programming', 'travel'
      classify_user_links(bayes, "user", "password," "nope")
   end
end
