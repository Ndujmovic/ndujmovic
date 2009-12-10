#############################################
# Project 1
# Feature Set #1 - Basic TF-IDF in Ruby (40%)
# Nancy Dujmovic
# October 14, 2009
#############################################


###########################################
# Additional Array functions
#
# calculates the sum and magnitude **squared**
# of an array of integers
###########################################
class Array; def sum; inject( nil ) { |sum,x| sum ? sum+x : x }; end; end
class Array; def mag; inject( nil ) { |mag,x| mag ? mag+x*x : x*x}; end; end


############################################################################
# Additional String functions and get_word_counts (below)
#
# [30 Points] Tokenize an input file, removing stop words and punctuation, 
# and build a Map of all document terms and the occurrence count of each term.
############################################################################

class String

# a list of words to not include as a token
@@stop_words = %w{the is a on this and or any from if be do at with not as that}

########################################
# strip_html - strips generic html tags
########################################
def strip_html
gsub(/<[^>]*(>+|\s*\z)/m, '');
end

########################################
# strip_script_tag - strips script tag
#    and javascript inside of it
########################################
def strip_script_tag
gsub(/<script.*<\/script>/i, '');
end

########################################
# strip_style_tag - strips style tag
#    and css inside of it
########################################
def strip_style_tag
gsub(/<style.*<\/style>/i, '');
end

########################################
# tokenize - removes punctuation and
#    capitalization, splits words
#    into tokens, and rejects some
#    generic and short words
########################################
def tokenize
terms = self.gsub(/(\s|\d|\W)+/u,' ').rstrip.strip.downcase.split(' ')
terms.reject!{|term| @@stop_words.include?(term) || term.length < 3}
terms
end

end # end additional string functions


########################################
# count_tokens - finds unique tokens and
#    counts the amount of times they
#    occur
########################################
def count_tokens(tokens)
h = Hash.new
begin
tokens.each {|x|  h[x] = h[x].nil? ? 1 : h[x] + 1 }
h
rescue
puts "** Error: Could not count tokens"
return h
end
end

####################################################################
# get_word_counts
#
# opens a file, concatenates the line, and finds all unique tokens
# and the # of occurrences
# 
# returns a hashmap h[term] = # occurrences
####################################################################
def get_word_counts(filename)
    #tokens = Array.new
    h = Hash.new
    if File.file?(filename) then
    File.foreach(filename) do |line|
    #whole_file += line
    #tokens = tokens | line.tokenize
    line_tokens = line.tokenize
    line_tokens.each {|x| h[x] = h[x].nil? ? 1 : h[x] + 1}
    end
    else
        return nil
    end
    h
    #count_tokens(tokens)
end

def is_file(dirname,filename)
   File.file?(dirname + "/" + filename) and filename[0,1] != "."
end


####################################################################
# get_cosine_sim
#
# opens a directory, reads all of the files, and finds the weight
# vector for each file
####################################################################
def get_cosine_sim(dirname)
    weights = Hash.new
    # check if directory exists
    return nil unless(File.directory?(dirname))
    # first, get idfs
    begin
    idfs = create_idfs(dirname)
    Dir.foreach(dirname) { |x|
        filename = dirname + "/" + x
            if(is_file(dirname, x)) then
                weights[filename] = get_weight_vector(filename, dirname, idfs)
            else
                puts "not a file! " + x
                    end
    }
    rescue
       puts "** Error in calculating cosine similarity."
    end

cosine_sims = Hash.new
# now calculate cosine similarities with each other
weights.each { |file1, v1|
    weights.each { |file2, v2|
        if( (file1 <=> file2) == 1) then
            dot_product = 0
                unique_words = v1.keys | v2.keys
                unique_words.each{ |term|
                    if(v1.key?(term) && v2.key?(term))
                    dot_product = dot_product + v1[term]*v2[term]
                    end
                }
        cosine = dot_product / ( Math.sqrt(v1.values.mag) * Math.sqrt(v2.values.mag) )
        cosine_sims["(#{file1} and #{file2})"] = cosine
            end
    }
}
cosine_sims
end

####################################################################
# create_idf()
#
# [25 Points] Given a directory of files, process each file to build 
# a set of reference information containing all terms found, and the 
# number of documents a term is seen in. Provide a routine to return 
# the Document Frequency (DF) for a term
#
####################################################################
def create_idfs(dirname)
    idfs = Hash.new
    num_files = 0
    Dir.foreach(dirname) { |x|
        filename = dirname + "/" + x
            if(is_file(dirname, x)) then
                num_files = num_files + 1
                word_count = get_word_counts(filename)
                    word_count.each{ |a,b|
                        idfs[a] = idfs[a].nil? ? 1 : idfs[a] + 1 
                    }
                    
        end 
    }
    # now we should calcultage log(num_total_docs / num_matching_docs)
    idfs.each{ |i,j|
       idfs[i] = Math.log(num_files.to_f/j)
    }
idfs
end

###########################
# get_weight_vector
#
# calculates the weight = tf_ij * idf of each term
# in a file
###########################
def get_weight_vector(filename, dirname, idfs)
    w = Hash.new
    word_count = get_word_counts(filename)
    if(word_count.nil? or word_count.empty?) then
        puts "word_count is nil!"
    return nil
    end
    word_count.each { |term,count|
    
        tf_ij = count.to_f / word_count.values.sum.to_f
            w[term] =  tf_ij * idfs[term]
    }
w
end

########################
# find_outliers  - find the outliers
#    (those words that are more than
#    two standard devs away)
#######################
def find_outliers(tokens_count)
   outliers = Array.new

   if(tokens_count.nil? or tokens_count.empty?) 
       return outliers
   end

   # first we find the mean
   mean = tokens_count.values.sum.to_f / tokens_count.values.size
   # then the standard deviation
   std_dev = 0
   tokens_count.each{ |token, count|
      std_dev = std_dev +  ( (count - mean) ** 2 )
   }
   std_dev = Math.sqrt(std_dev/tokens_count.values.size.to_f)

   print "means #{mean} and std_dv is #{std_dev}"
   # now find tokens that are more than two std devs away from expected
   # frequency (or the mean)
   tokens_count.each{ |token, count|
      if((count - mean).abs > 2*std_dev)
          outliers << token
       end
   }
   outliers
end


def print_outliers(outliers)
   if(outliers.nil? == false)
       outliers.each { |x|
          puts "#{x}"
       }
    end
end


