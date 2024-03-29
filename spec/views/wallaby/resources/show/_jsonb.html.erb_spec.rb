# frozen_string_literal: true

require 'rails_helper'

partial_name = 'show/jsonb'
describe partial_name do
  let(:partial)   { "wallaby/resources/#{partial_name}" }
  let(:metadata)  { {} }
  let(:value) do
    {
      'kind' => 'user_renamed',
      'change' => %w[jack john]
    }.to_json
  end

  before do
    render partial, value: value, metadata: metadata
  end

  it 'renders the jsonb' do
    expect(rendered).to include h(value)
  end

  context 'when value is nil' do
    let(:value) { nil }

    it 'renders null' do
      expect(rendered).to include view.null
    end
  end
end
