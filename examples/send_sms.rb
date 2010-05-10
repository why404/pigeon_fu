#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/../lib"))

require 'pigeon_fu'

ENV["PIGEON_ACCOUNT_SID"] = '10003551' # YOUR_APP_KEY
ENV["PIGEON_ACCOUNT_TOKEN"] = '76e9bde81f1e4e51ac8d86517e4bd852' # YOUR_APP_SECRET_KEY

PigeonFu.send_sms :to  => '13186988528',
                  :say => 'Just testing to send a sms from my program what I am writting now!'
