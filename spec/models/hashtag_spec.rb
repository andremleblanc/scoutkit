require 'rails_helper'

RSpec.describe Hashtag, type: :model do
  describe 'validations' do
    subject { described_class }

    describe 'name' do
      let(:name) { 'yoga' }

      describe 'rails' do
        describe 'is required' do
          it { expect(build(:hashtag).valid?).to be true }
          it { expect(build(:hashtag, name: nil).valid?).to be false }
        end

        it 'is unique' do
          create(:hashtag, name: name)
          expect(build(:hashtag, name: name).valid?).to be false
        end
      end

      describe 'pg' do
        it 'is required' do
          tag = subject.new(attributes_for(:hashtag, name: nil))
          expect{ tag.save!(validate: false) }.to raise_error(ActiveRecord::NotNullViolation)
        end

        it 'is unique' do
          create(:hashtag, name: name)
          tag = subject.new(attributes_for(:hashtag, name: name))
          expect{ tag.save!(validate: false) }.to raise_error(ActiveRecord::RecordNotUnique)
        end
      end
    end
  end
end
