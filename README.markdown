PigeonFu is a Ruby gem for building voice and SMS applications. It allows your web application to easily make and receive phone calls and SMS text messages using the ChinaTelecom Open API. You can build hosted IVR, PBX and SMS applications easily and quickly.

**Install**

    $ sudo gem install pigeonfu

**Usage**

Here is an example show you how to send a phone text message to some body.

    PIGEON_ACCOUNT_SID = '10003551'
    PIGEON_ACCOUNT_TOKEN = '76e9bde81f1e4e51ac8d86517e4bxxxx'

    PIGEON_CONTANCT = {
      'Awhy' => '1318698xxxx',
      'Frank' => '1515807xxxx'
    }

  
    PigeonFu.send_message :to => '1871989xxxx', :say => 'Hi!'
    PigeonFu.send_message :to => 'Awhy', :say => 'Hello?'
    PigeonFu.send_message :to => :all, :say => '信春鸽祝大家新春快乐!'
    PigeonFu.send_message_to_me 'Just testing to send a short text message from my program what I am writting now!'


**TODO**

I am working on it currently, more features will be added in later.