module PigeonFu

  SESS_INTERFACE_URL = 'http://open.189works.com/InterfaceForAP/GetSessionID.aspx'
  AUTH_INTERFACE_URL = 'http://open.189works.com/InterfaceForAP/Authv1.1.aspx'
  
  SMS_INTERFACE_CODE = 10000033
  SMS_INTERFACE_URL = 'http://ims.open.ctfactory.com/ims/ghsendim.php'
  
  CALL_INTERFACE_CODE = 10000034
  CALL_INTERFACE_URL = ''
  
  IVR_INTERFACE_CODE = 10000108
  IVR_INTERFACE_URL  = ''
  
  FAX_INTERFACE_CODE = 0
  FAX_INTERFACE_URL = ''
  
  PHONE_NUMBER_REGEX = /^\d{8,13}$/ # The overwhelming majority phone numbers in China should be supported.
  
  class << self
    def send_sms(options={})
      PigeonFu::Sms.send_message(options)
    end
  end
  
  
  module Base
    # In fact it will as a class-methods module mix-in class object. For example see PigeonFu::Sms::ClassMethods
    module InstanceMethods
    end
    
  end
 
end
