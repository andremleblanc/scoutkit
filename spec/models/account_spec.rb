require 'rails_helper'

RSpec.describe Account, type: :model do
  describe 'validations' do
    subject { described_class }
    it { expect(build(:account).valid?).to be true }

    describe 'name' do
      let(:name) { 'yoga' }

      describe 'rails' do
        describe 'is required' do
          it { expect(build(:account, name: nil).valid?).to be false }
        end
      end

      describe 'pg' do
        it 'is required' do
          account = subject.new(attributes_for(:account, name: nil))
          expect{ account.save!(validate: false) }.to raise_error(ActiveRecord::NotNullViolation)
        end
      end
    end

    describe 'instagram_id' do
      let(:instagram_uid) { Faker::Number.number(10) }

      describe 'rails' do
        describe 'is required' do
          it { expect(build(:account, instagram_uid: nil).valid?).to be false }
        end

        it 'is unique' do
          create(:account, instagram_uid: instagram_uid)
          expect(build(:account, instagram_uid: instagram_uid).valid?).to be false
        end
      end

      describe 'pg' do
        it 'is required' do
          account = subject.new(attributes_for(:account, instagram_uid: nil))
          expect{ account.save!(validate: false) }.to raise_error(ActiveRecord::NotNullViolation)
        end

        it 'is unique' do
          create(:account, instagram_uid: instagram_uid)
          account = subject.new(attributes_for(:account, instagram_uid: instagram_uid))
          expect{ account.save!(validate: false) }.to raise_error(ActiveRecord::RecordNotUnique)
        end
      end
    end
  end
end
