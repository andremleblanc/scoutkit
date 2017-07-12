require 'rails_helper'
require 'support/shared_examples/controllers'

RSpec.describe TrackersController, type: :controller do
  include_examples "authenticated index"
  include_examples "authenticated new"
  let(:user) { create(:user) }
end
