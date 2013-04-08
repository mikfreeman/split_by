#!/usr/bin/env ruby
require 'optparse'
require 'ostruct'

PROGRAM_VERSION = 1.0

$options = OpenStruct.new

def program_options
  [
    ['-d','--delimiter [DELIMITER]', "The delimiter to split the content by",
      lambda { |value| 
        $options.delimiter = value
      }
    ],
  	['-V','--version', "Display the program version.",
      lambda { |value|
          puts "split_by : version #{PROGRAM_VERSION}"
            exit
        }
    ]
  ]
end

option_parser = OptionParser.new do |opts|
  opts.banner = "Usage: split_by.rb [OPTION]... [FILE]"
  opts.separator ""
  opts.separator "Options are ..."
  opts.on_tail("-h", "--help", "-H", "Display this help message.") do
    puts opts
    exit
  end
  program_options.each { |args| opts.on(*args) }
end

begin
  option_parser.parse!
rescue OptionParser::ParseError => error
  puts error.message
  puts option_parser
  exit
end

ARGF.lines do |line|
  line.split($options.delimiter).each{|x|
      puts x
      STDOUT.flush
  }
end