# frozen_string_literal: true

require 'uri'
require 'net/http'
require './lib/stats'

# input parameters
url = ARGV[0] || 'https://google.com'
time = (ARGV[1] || 10).to_f
sleep_interval = (ARGV[2] || 3).to_f

# init http
uri = URI(url)
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = uri.scheme == 'https'

start_time = Time.now
path = uri.path ? '/' : uri.path

# init stats
stats = Stats.new(start_time)

# process ctrl_c nicely and display monitoring stats
Signal.trap('INT') do
  puts stats.totals
  abort '>> Interrupted by user'
end

# run probes in a loop with sleeping between probes
while Time.now - start_time < time
  start_probe_time = Time.now
  http.get(path)
  puts stats.probe(url, start_probe_time, Time.now)
  sleep(sleep_interval)
end

# display monitoring stats
puts stats.totals
