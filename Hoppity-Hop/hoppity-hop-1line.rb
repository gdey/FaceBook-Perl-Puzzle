#!/usr/bin/ruby


# Only care about the first argument.
arg = ARGV[0];

numval = 0
if arg 

  # we are going to be dumb about this.
  val = ""
  File.open(arg,"r") do |infile|
    while (line = infile.gets )
      val += line
    end
  end
  
  numval = val.to_i
else
  print "#{$0} filename\n"
  exit
end

print (1..numval).to_a.map { |n| 

     if n % 3 == 0 and n % 5 == 0    
        'Hop'
     elsif n % 5 == 0    
        'Hophop' 
     elsif n % 3 == 0 
        'Hoppity' 
     else
        ''
     end

}.join("\n")

