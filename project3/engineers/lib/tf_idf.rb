#############################################
# Project 1
# Feature Set #1 - Basic TF-IDF in Ruby (40%)
# Nancy Dujmovic
# October 14, 2009
#############################################

require 'additional_functions.rb'

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
    line_tokens = tokenize(line)
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
# get_cosine_sim SAVE
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
       # cosine = dot_product / ( Math.sqrt(v1.values.mag) * Math.sqrt(v2.values.mag) )
        cosine = dot_product / ( Math.sqrt(array_mag(v1.values)) * Math.sqrt(array_mag(v2.values)))
        cosine_sims["(#{file1} and #{file2})"] = cosine
            end
    }
}
cosine_sims
end

####################################################################
# create_idf() SAVE
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
        tf_ij = cont.to_f / array_sum(word_count.values).to_f
        #tf_ij = count.to_f / word_count.values.sum.to_f
            w[term] =  tf_ij * idfs[term]
    }
w
end


