module Herokulogs
  class CLI
    def initialize
      @formatter = Formatter.new(ARGV.first)
      @guard = Regexp.new(ARGV[1] || "")

      puts "herokulogs output format: #{@formatter.output_format.join(" ")}"
      puts "herokulogs guard: #{@guard.inspect}" if @guard != //
    end

    def run!
      STDIN.each do |line|
        if line.match(@guard)
          formatted = @formatter.format(line.chomp)
          puts formatted if formatted
        end
      end
    end
  end
end