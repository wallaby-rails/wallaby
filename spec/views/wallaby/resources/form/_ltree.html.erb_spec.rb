require 'rails_helper'

describe 'partial' do
  let(:partial)     { "wallaby/resources/form/#{ field_name }.html.erb" }
  let(:form)        { Wallaby::FormBuilder.new object.model_name.param_key, object, view, { } }
  let(:object)      { AllPostgresType.new field_name => value }
  let(:field_name)  { :ltree }
  let(:value)       { 'Top.Science.Astronomy.Cosmology' }
  let(:metadata)    { Hash.new }

  before { render partial, form: form, object: object, field_name: field_name, value: value, metadata: metadata }

  it 'renders the ltree form' do
    expect(rendered).to eq "<div class=\"form-group \">\n  <label for=\"all_postgres_type_ltree\">Ltree</label>\n  <input class=\"form-control\" type=\"text\" value=\"Top.Science.Astronomy.Cosmology\" name=\"all_postgres_type[ltree]\" id=\"all_postgres_type_ltree\" />\n  \n</div>\n"
  end

  context 'when value is nil' do
    let(:value) { nil }
    it 'renders empty input' do
      expect(rendered).to eq "<div class=\"form-group \">\n  <label for=\"all_postgres_type_ltree\">Ltree</label>\n  <input class=\"form-control\" type=\"text\" name=\"all_postgres_type[ltree]\" id=\"all_postgres_type_ltree\" />\n  \n</div>\n"
    end
  end
end
