require "timeout"
require "socket"

class Godot
  attr_reader :host, :port
  attr_writer :interval, :timeout

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

  def initialize(host, port)
    @host = host
    @port = port
  end

  def interval
    @interval || 1
  end

  def timeout
    @timeout || 10
  end

  def wait!
    Timeout.timeout(timeout) do
      socket = nil
      until socket
        begin
          Timeout.timeout(interval) do
            socket = TCPSocket.open(host, port)
          end
        rescue Errno::ECONNREFUSED, Errno::ETIMEDOUT, Timeout::Error, Errno::EHOSTUNREACH, Errno::EHOSTDOWN
        end
      end
    end
  end

  def wait
    wait!
    true
  rescue Timeout::Error
    false
  end

  def match!(pattern, path = "", options = "-ks")
    Timeout.timeout(timeout) do
      sleep interval until `curl #{options} http://#{host}:#{port}/#{path}` =~ pattern
    end
  end

  def match(pattern, path = "", options = "-ks")
    match!(pattern, path, options)
    true
  rescue Timeout::Error
    false
  end
end
