require "godot/version"
require "timeout"
require "socket"

class Godot
  attr_reader :host, :port
  attr_accessor :trace, :interval, :timeout

  def self.wait!(host, port)
    new(host, port).wait!
  end

  def self.wait(host, port)
    new(host, port).wait
  end

  def self.match!(host, port, pattern, path = "", options = "-ks")
    new(host, port).match!(pattern, path, options)
  end

  def self.match(host, port, pattern, path = "", options = "-ks")
    new(host, port).match(pattern, path, options)
  end

  def initialize(host, port, options = {})
    @host = host
    @port = port
    @interval = options[:interval] || 1
    @trace = options[:trace] || false
    @timeout = options[:timeout] || 10
  end

  def wait!
    socket = nil
    Timeout.timeout(timeout) do
      until socket
        begin
          Timeout.timeout(interval) do
            socket = TCPSocket.open(host, port)
          end
        rescue Errno::ECONNREFUSED, Errno::ETIMEDOUT, Timeout::Error, Errno::EHOSTUNREACH, Errno::EHOSTDOWN
          $stderr.putc "." if trace
        end
      end
    end
  ensure
    socket.close if socket
  end

  def wait
    wait!
    true
  rescue Timeout::Error
    false
  end

  def match!(pattern, path = "", options = "-ks")
    Timeout.timeout(timeout) do
      sleep interval until curl(host, port, path, options) =~ pattern
    end
  end

  def match(pattern, path = "", options = "-ks")
    match!(pattern, path, options)
    true
  rescue Timeout::Error
    false
  end

  def curl(host, port, path, options)
    `curl #{options} http://#{host}:#{port}/#{path}`.tap do |result|
      $stderr.puts "\n>>>>>\n" + result + "\n<<<<<\n\n" if ENV['GODOT_DEBUG']
    end
  end
end
