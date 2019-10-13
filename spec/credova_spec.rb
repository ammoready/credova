require 'spec_helper'

describe Credova do
  describe '.sandbox?' do
    it 'defaults to false' do
      expect(Credova.sandbox?).to be_falsey
    end

    it 'can be set to true' do
      Credova.sandbox = true
      expect(Credova.sandbox?).to be_truthy
    end
  end
end
