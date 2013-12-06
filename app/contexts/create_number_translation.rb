# Context to retreive a certain number translation
#
# Author::    Shadley Wentzel

class CreateNumberTranslation
  attr_reader :number

  def self.call(number)
    CreateNumberTranslation.new(number).call
  end

  def initialize(number)
    @number = number
  end

  def call   
    translated_number = NumberToEnglishHelper::to_English(@number)
    Number.create(:number => @number, :presentations => %w[#{translated_number}])   
    translated_number   
  end
end