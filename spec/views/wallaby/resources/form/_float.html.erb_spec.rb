# frozen_string_literal: true

require 'rails_helper'

field_name = field_name_from __FILE__
type = type_from __FILE__
describe field_name do
  it_behaves_like \
    "#{type} partial", field_name,
    value: 88.8888,
    type: 'number' do
    context 'when metadata options are given' do
      let(:metadata) { { options: { step: 2 } } }

      it 'sets step' do
        input = page.at_css(input_selector)
        expect(input['step'].to_i).to eq metadata[:options][:step]
      end
    end
  end
end
