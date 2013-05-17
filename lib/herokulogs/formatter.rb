module Herokulogs
  class Formatter
    FORMAT = Regexp.new([
      /(\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d+\+\d{2}:\d{2}) /,
      /([^:]+): /,
      /at=(\S+) /,
      /method=(\S+) /,
      /path=(\S+) /,
      /host=(\S+) /,
      /fwd="([^"]+)" /,
      /dyno=(\S+) /,
      /connect=(\d+)ms /,
      /service=(\d+)ms /,
      /status=(\d+) /,
      /bytes=(\d+)/
    ].join)

    OUTPUT_FORMAT_OPTIONS = {
      "2" => :status,
      "b" => :bytes,
      "c" => :connect,
      "d" => :date,
      "f" => :fwd,
      "h" => :host,
      "l" => :log_level,
      "m" => :method,
      "p" => :path,
      "s" => :service,
      "t" => :type,
      "y" => :dyno,
    }

    FORMATTER = {
      :status => "%3d",
      :bytes  => "%08d",
      :connect => "%05dms",
      :date => lambda {|e| t = Time.parse(e); t.strftime "%Y-%m-%d %H:%M:%S"},
      :fwd => "%15s",
      :host => "%20s",
      :log_level => "%5s",
      :method => "%7s",
      :path => "%-40s",
      :service => "%05dms",
      :type => "%15s",
      :dyno => "%8s"
    }

    attr_reader :output_format

    def initialize(format_string)
      output_format = format_string
      if output_format.empty?
        STDERR.puts "herokulogs format missing"
        exit(false)
      end
      @output_format = output_format.chars.map {|c| OUTPUT_FORMAT_OPTIONS[c]}.compact
    end

    def format(line)
      input = construct_input_hash(line)
      return unless input

      @output_format.map do |element|
        formatter = FORMATTER[element]
        if formatter.respond_to?(:call)
          formatter.call(input[element])
        else
          formatter % input[element]
        end
      end.join(" ")
    end

    protected
    def construct_input_hash(line)
      match = line.match(FORMAT)
      return unless match

      date, type, log_level, method, path, host, fwd, dyno, connect, service, status, bytes = match.captures
      {
        :date => date,
        :type => type,
        :log_level => log_level,
        :method => method,
        :path => path,
        :host => host,
        :fwd => fwd,
        :dyno => dyno,
        :connect => connect,
        :service => service,
        :status => status,
        :bytes => bytes
      }
    end
  end
end