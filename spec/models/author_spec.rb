require 'rails_helper'

RSpec.describe Author, type: :model do
  describe 'validations' do
    subject do
      described_class.new(first_name: 'Bill',
                          last_name: 'Gates',
                          email: 'gates@microsoft.com')
    end

    it 'returns first_name=Bill&last_name=Gates when to_s invoked' do
      expect(subject.to_s).to eql('first_name=Bill&last_name=Gates')
    end

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid if first_name is missing' do
      subject.first_name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid if last_name is missing' do
      subject.last_name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid if email is missing' do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid if email format is invalid' do
      subject.email = 'email.com'
      expect(subject).to_not be_valid
    end
  end
end
