# frozen_string_literal: true

require 'rails_helper'
require 'core_extensions/hash_reject_hidden'

RSpec.describe CoreExtensions::HashRejectHidden do
  before do
    Hash.include CoreExtensions::HashRejectHidden
  end

  TEST_CASES = [
    {
      title:  "does nothing to empty hashes",
      before: {},
      after:  {}
    },
    {
      title:  "hides everything at top level",
      before: {"hidden" => true},
      after:  {}
    },
    {
      title:  "preserves unhidden values",
      before: {"a" => "b"},
      after:  {"a" => "b"}
    },
    {
      title:  "removes keys for hidden subobjects",
      before: {"a" => {"hidden" => true}},
      after:  {}
    },
    {
      title:  "preserves unhidden subobjects",
      before: {"a" => {"b" => "c"}},
      after:  {"a" => {"b" => "c"}},
    },
    {
      title:  "preserved toplevel objects while removing hidden subobjects",
      before: {"b" => "c", "a" => {"hidden" => true, "b" => "c"}},
      after:  {"b" => "c"}
    }
  ]

  TEST_CASES.each do |c|
    it c[:title] do
      expect(c[:before].reject_hidden).to eq(c[:after])
    end
  end
end
