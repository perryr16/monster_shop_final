require 'rails_helper'

RSpec.describe Discount do 

  describe 'Relationships'do
    it {should belong_to :merchant}
  end

  describe 'Validations' do
    it {should validate_presence_of :quantity}
    it {should validate_presence_of :percent}
  end
  
end