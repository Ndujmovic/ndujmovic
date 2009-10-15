require 'rubygems'
require 'hpricot'
require 'open-uri'
require 'uri'
require 'net/http'
require 'net/https'

#############################################
# Project 1
# Feature Set #2 - Score users based on tagged pages (40%)
# Nancy Dujmovic
# October 14, 2009
#############################################


################
# [25 Points] Develop classes that can retrieve all 
#   web pages linked to by a specific user. 
################
class GetDelicious

def self.created_sorted_url_list_hpricot_by_tag(user, passwd, tag)

    res = Net::HTTP.post_form(URI.parse("http://#{user}:#{passwd}@api.del.icio.us/v1/posts/get?meta=yes&tag=#{tag}"), {})

    urls = Array.new

doc = Hpricot::XML(res.body)
    (doc/:post).each do |post|
    urls << post[:href]
    end

    urls.sort
    end

def self.created_sorted_url_list_hpricot(user, passwd)
   GetDelicious.created_sorted_url_list_hpricot_by_tag(user, passwd, "")
end


def self.get_html(urlstr)
    begin
url = URI.parse(urlstr)
    url_path = url.path.empty? ? "/index.html" : url.path
req = Net::HTTP::Get.new(url_path)
    res = Net::HTTP.start(url.host, url.port) {|http|
        http.request(req)
    }
if(res.code != "200")
puts "*** Error: bad response code (#{res.code}): #{urlstr}."
return
end
res.body
rescue
puts "*** Error: could not retrieve html: #{urlstr}."
nil
end
end

end

