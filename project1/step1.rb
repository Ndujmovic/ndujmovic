require 'yaml'
require 'get_delicious.rb'
require 'tf_idf.rb'


#
# STEP ONE: grab all the user's tagged pages
# and strip the html.  then output it to
# the temp directory
#
puts "STEP ONE: grab all the delicious files."

mydir = "tempdir"
    begin
    Dir.mkdirs(mydir) unless(File.directory?(mydir))

    @students = YAML.load_file("students.yml")
    threads = Array.new
    @students.each_pair do |login, password|
    threads << Thread.new(login, password) do |user, passwd|

    urls = GetDelicious.created_sorted_url_list_hpricot(login, password)
    urls.each { |u|
        if(File.directory?(mydir)) then
         # create the files w/o html
         puts "Reading #{u}..."
            if(GetDelicious.get_html(u).nil? == false)
                out = File.new("#{mydir}/#{user}.txt", "a")
                    out.puts GetDelicious.get_html(u).strip_html
                    out.close
             end
         end
    }
end
end
threads.each { |aThread| aThread.join }

rescue
puts "*** Could not execute."
end

