require 'rubygems'
require 'classifier'
require 'yaml'
require 'get_delicious.rb'

##########################################
# Project 1
# Feature Set #3 - Machine classification (20%)
# Nancy Dujmovic
# October 14, 2009
##########################################

###################
# classify_user_links
#
# given a classifier, username,
# password, and tag name,
# classify the links
###################
def classify_user_links(bayes, login, password, tag_name)
    urls = GetDelicious.created_sorted_url_list_hpricot_by_tag(login, password, tag_name)
    urls.each{ |url|
       url_body = GetDelicious.get_html(url)
       if(url_body.nil? == false)
           tag = bayes.classify url_body
           puts "URL: #{url}"
           puts "AUTO CLASSIFIED: #{tag}"
           puts "USER CLASSIFIED: #{tag_name}"
           puts "MATCHES" unless (tag.downcase != tag_name.downcase)
           puts "====\n"
        end
     }
end

me_user = 'jhu_ndujmovic'
me_passwd = 'abc123'

bayes = Classifier::Bayes.new 'programming', 'travel'

# train programming links
my_urls = GetDelicious.created_sorted_url_list_hpricot_by_tag(me_user, me_passwd, 'programming')
my_urls.each{ |url|
   url_body = GetDelicious.get_html(url)
   if(url_body.nil? == false)
   bayes.train_programming(GetDelicious.get_html(url))
   end
}


# train travel links
my_urls = GetDelicious.created_sorted_url_list_hpricot_by_tag(me_user, me_passwd, 'travel')
my_urls.each{ |url|
   url_body = GetDelicious.get_html(url)
   if(url_body.nil? == false)
   bayes.train_travel(GetDelicious.get_html(url))
   end
}

# now let's classify other links
@students = YAML.load_file("students.yml")

threads = Array.new
@students.each_pair do |login, password|
threads << Thread.new(login, password) do |user, passwd|
    classify_user_links(bayes, login, password, "programming")
    classify_user_links(bayes, login, password, "travel")
end
end

threads.each { |aThread| aThread.join }

