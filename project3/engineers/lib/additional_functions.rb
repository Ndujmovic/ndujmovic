
def array_sum(array)
   sum = 0
   array.each { |x|
      sum = sum + x
   }
   sum
end

def array_mag(array)
   mag = 0;
   array.each{ |x|
      mag = mag + x*x
   }
   mag
end

# a list of words to not include as a token
@@stop_words = %w{the is a on this and or any from if be do at with not as that}

########################################
# strip_html - strips generic html tags
########################################
def strip_html (s)
s.gsub(/<[^>]*(>+|\s*\z)/m, '');
end

########################################
# strip_script_tag - strips script tag
#    and javascript inside of it
########################################
def strip_script_tag (s)
s.gsub(/<script.*<\/script>/i, '');
end

########################################
# strip_style_tag - strips style tag
#    and css inside of it
########################################
def strip_style_tag (s)
s.gsub(/<style.*<\/style>/i, '');
end

########################################
# tokenize - removes punctuation and
#    capitalization, splits words
#    into tokens, and rejects some
#    generic and short words
########################################
def tokenize(s)
terms = s.gsub(/(\s|\d|\W)+/u,' ').rstrip.strip.downcase.split(' ')
terms.reject!{|term| @@stop_words.include?(term) || term.length < 3}
terms
end

