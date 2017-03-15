#!/usr/bin/env ruby

current_ip = File.read("current_ip").strip rescue  "0.0.0.0"

REMOTE_ADDR_CHK = "http://ieserver.net/ipcheck.shtml";
new_ip = `wget -q -O - #{REMOTE_ADDR_CHK}`;

exit if new_ip == current_ip

require 'yaml'
param = YAML.load_file('config.yml')
param[:updatehost] = 1
param_string = param.map{|k,v| "#{k}=#{v}"}.join("&")

DDNS_UPDATE = "https://ieserver.net/cgi-bin/dip.cgi"
url = "#{DDNS_UPDATE}?#{param_string}"

result = `wget -q -O - '#{url}'`

if result.include?(new_ip)
  File.open("current_ip", "w"){|c| c.puts new_ip }
end
