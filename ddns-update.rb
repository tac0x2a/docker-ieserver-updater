#!/usr/bin/env ruby

require 'optparse'
opts = ARGV.getopts("u:d:p:", "c:'current_ip'")

current_ip = File.read(opts["c"]).strip rescue  "0.0.0.0"

REMOTE_ADDR_CHK = "http://ieserver.net/ipcheck.shtml";
new_ip = `wget -q -O - #{REMOTE_ADDR_CHK}`;

exit if new_ip == current_ip

require 'yaml'
param = {
  username: opts["u"],
  domain:   opts["d"],
  password: opts["p"],
  updatehost: 1
}
param_string = param.map{|k,v| "#{k}=#{v}"}.join("&")

DDNS_UPDATE = "https://ieserver.net/cgi-bin/dip.cgi"
url = "#{DDNS_UPDATE}?#{param_string}"

result = `wget -q -O - '#{url}'`

if result.include?(new_ip)
  File.open(opts["c"], "w"){|c| c.puts new_ip }
end
