require 'rails_helper'

RSpec.describe Merchant do 

  describe 'Relationships'do
    it {should belong_to :merchants}
  end

  describe 'Validations' do
    it {should validate_presence_of :num_items}
    it {should validate_presence_of :percent_off}
  end
  
end