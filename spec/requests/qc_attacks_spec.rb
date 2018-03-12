# frozen_string_literal: true

require 'rails_helper'
require 'support/shared_examples/character_trait'

RSpec.describe 'QcAttacks', type: :request do
  it_behaves_like 'character trait', :qc_attack, 'qcs'
end
