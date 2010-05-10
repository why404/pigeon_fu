### About PigeonFu

PigeonFu is a Ruby gem for building voice and SMS applications. It allows your web application to easily make and receive phone calls and SMS text messages using the ChinaTelecom Open API. You can send E-FAX by using PigeonFu or build hosted IVR, WebCall and SMS applications easily and quickly.


### Installation

    $ gem install pigeon_fu --pre


### Usage

You need to register for an authorized app-account on the ChinaTelecom open platform(http://www.189works.com/) first.

Here is an example show you how to send a phone text message to some body.

    require 'pigeon_fu'

    ENV["PIGEON_ACCOUNT_SID"]   = '1000XXXX'                         # YOUR_APP_KEY
    ENV["PIGEON_ACCOUNT_TOKEN"] = '76e9bde81f1e4e51ac8d86517e4bXXXX' # YOUR_APP_SECRET_KEY

    PigeonFu.send_sms :to  => '1318698XXXX',
                      :say => 'Just testing to send a sms from my program what I am writting now!'

See the examples/ folder for more examples.


### TODO

I am working on it currently, more features will be added in later versions, and it will support both Ruby on Rails 3.0 and Sinatra ASAP.


### Copyright

Copyright (c) 2010 why404(why404#gmail), released under the MIT license.
