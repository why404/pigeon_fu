#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/../lib"))

require 'pigeon_fu'

PIGEON_ACCOUNT_SID = '1000XXXX' # YOUR_APP_KEY
PIGEON_ACCOUNT_TOKEN = '76e9bde81f1e4e51ac8d86517e4bXXXX' # YOUR_APP_SECRET_KEY

PIGEON_IMS = {
  '生产部' => '02861802802',
  '销售部' => '02884756670',
  '客服部' => '02884756671'
}

# PIGEON_CONTANCT = '1318698XXXX'

PIGEON_CONTANCT = {
  'Awhy' => '1318698XXXX'
  'Frank' => '1515807XXXX'
}

PigeonFu.send_message :to => 'Frank', :say => 'Hello,there!'
PigeonFu.send_message_to_me 'Just testing to send a short text message from my program what I am writting now!'
PigeonFu.send_message :to => :all, :say => '信春鸽祝大家新春快乐!', :from => '客服部'