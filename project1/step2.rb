require 'tf_idf.rb'

mydir = "tempdir"

#
# STEP TWO: calculate cosine similarities of users' tagged pages
#
puts "STEP TWO: calculation cosine similarities...\n"
cosine_sims = get_cosine_sim(mydir)
cosine_sims.each {|file_pair, cosine|
   puts "#{file_pair}: #{cosine}"
}

puts "\n"

#
# find outliers for files
#
#puts "find outliers for a file...\n"
#word_counts = get_word_counts("#{mydir}/jhu_ndujmovic.txt")
#outliers = print_outliers(find_outliers(word_counts))
#puts "word count is #{word_counts.size}"
