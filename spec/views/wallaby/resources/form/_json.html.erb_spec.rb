require 'rails_helper'

describe 'partial' do
  let(:partial)     { "wallaby/resources/form/#{ field_name }.html.erb" }
  let(:form)        { Wallaby::FormBuilder.new object.model_name.param_key, object, view, { } }
  let(:object)      { AllPostgresType.new field_name => value }
  let(:field_name)  { :json }
  let(:value) do
    {
      "kind" => "user_renamed",
      "change" => ["jack", "john"]
    }
  end
  let(:metadata)    { Hash.new }

  before do
    expect(view).to receive :content_for
    render partial, form: form, object: object, field_name: field_name, value: value, metadata: metadata
  end

  it 'renders the json form' do
    expect(rendered).to eq "<div class=\"form-group \">\n  <label for=\"all_postgres_type_json\">Json</label>\n  <textarea class=\"form-control\" data-init=\"codemirror\" data-mode=\"javascript\" name=\"all_postgres_type[json]\" id=\"all_postgres_type_json\">\n{\n  &quot;kind&quot;: &quot;user_renamed&quot;,\n  &quot;change&quot;: [\n    &quot;jack&quot;,\n    &quot;john&quot;\n  ]\n}</textarea>\n  \n</div>\n\n"
  end

  context 'when value is nil' do
    let(:value) { nil }
    it 'renders empty input' do
      expect(rendered).to eq "<div class=\"form-group \">\n  <label for=\"all_postgres_type_json\">Json</label>\n  <textarea class=\"form-control\" data-init=\"codemirror\" data-mode=\"javascript\" name=\"all_postgres_type[json]\" id=\"all_postgres_type_json\">\n</textarea>\n  \n</div>\n\n"
    end
  end
end