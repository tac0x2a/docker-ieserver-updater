#!/usr/bin/env ruby

REMOTE_ADDR_CHK = "http://ieserver.net/ipcheck.shtml"
DDNS_UPDATE     = "https://ieserver.net/cgi-bin/dip.cgi"

def run_ip_update(param_string, current_ip_file, logger)
  current_ip = File.read(current_ip_file).strip rescue  "0.0.0.0"
  new_ip = `wget -q -O - #{REMOTE_ADDR_CHK}`
  if new_ip == current_ip
    logger.info("Skipped update. IP #{current_ip} => #{new_ip}")
    return
  end

  url = "#{DDNS_UPDATE}?#{param_string}"

  result = `wget -q -O - '#{url}'`
  if result.include?(new_ip)
    File.open(current_ip_file, "w"){|c| c.puts new_ip }

    logger.info("Updated. IP #{current_ip} => #{new_ip}")
  end
end

require 'optparse'
opts = ARGV.getopts("u:d:p:", "c:'current_ip'", "s:*/5 * * * *", "l:logfile.log")

require 'logger'
logger = Logger.new(opts["l"], 7)
logger.info("Start ddns-update.rb #{opts}")

param = {
  username: opts["u"],
  domain:   opts["d"],
  password: opts["p"],
  updatehost: 1
}
param_string = param.map{|k,v| "#{k}=#{v}"}.join("&")

require 'rufus-scheduler'
schedule = opts['s']
scheduler = Rufus::Scheduler.new
scheduler.cron schedule do
  run_ip_update(param_string, opts['c'], logger)
end

scheduler.join
