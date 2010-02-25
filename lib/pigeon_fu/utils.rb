class String
  def is_a_phone_number?
    self =~ PigeonFu::PHONE_NUMBER_REGEX
  end
end