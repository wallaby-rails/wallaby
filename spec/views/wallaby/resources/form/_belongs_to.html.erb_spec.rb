require 'rails_helper'

describe 'partial' do
  let(:partial)     { 'wallaby/resources/form/belongs_to.html.erb' }
  let(:form)        { Wallaby::FormBuilder.new object.model_name.param_key, object, view, { } }
  let(:object)      { Product.new metadata[:name] => value }
  let(:field_name)  { metadata[:name] }
  let(:value)       { Category.new id: 1, name: 'Mens' }
  let(:metadata)    do
    Hash name: "category", type: "belongs_to", label: "Category",
      is_association: true, is_polymorphic: false, is_through: false, has_scope: false, foreign_key: "category_id", polymorphic_type: nil, polymorphic_list: [], class: Category
  end

  before do
    allow(view).to receive(:model_choices) { [ [ value.name, value.id ] ] }
    render partial, form: form, object: object, field_name: field_name, value: value, metadata: metadata
  end

  it 'renders the belongs_to form' do
    expect(rendered).to eq "<div class=\"form-group \">\n  <label for=\"product_category_id\">Category</label>\n  <div class=\"row\">\n      <div class=\"col-xs-6 col-sm-3\">\n        <select class=\"form-control\" name=\"product[category_id]\" id=\"product_category_id\"><option value=\"\"></option>\n<option selected=\"selected\" value=\"1\">Mens</option></select>\n        <p class=\"help-block\">\n          Or <a class=\"text-success\" href=\"/admin/categories/new\">Create Category</a>\n        </p>\n      </div>\n  </div>\n  \n</div>\n"
    expect(rendered).to match "selected=\"selected\""
  end

  context 'when value is nil' do
    let(:object)  { Product.new }

    it 'renders the belongs_to form' do
      expect(rendered).to eq "<div class=\"form-group \">\n  <label for=\"product_category_id\">Category</label>\n  <div class=\"row\">\n      <div class=\"col-xs-6 col-sm-3\">\n        <select class=\"form-control\" name=\"product[category_id]\" id=\"product_category_id\"><option value=\"\"></option>\n<option value=\"1\">Mens</option></select>\n        <p class=\"help-block\">\n          Or <a class=\"text-success\" href=\"/admin/categories/new\">Create Category</a>\n        </p>\n      </div>\n  </div>\n  \n</div>\n"
      expect(rendered).not_to match "selected=\"selected\""
    end
  end

  context 'when it is polymorphic' do
    let(:object)      { Picture.new imageable: value }
    let(:field_name)  { :imageable_id }
    let(:value)       { Product.new id: 1, name: 'Snowboard' }
    let(:metadata) do
      Hash name: "imageable", type: "belongs_to", label: "Imageable", is_association: true,
      is_polymorphic: true, is_through: false, has_scope: false, foreign_key: "imageable_id", polymorphic_type: "imageable_type", polymorphic_list: [ Product ], class: nil
    end

    it 'renders the polymorphic form' do
      expect(rendered).to eq "<div class=\"form-group \">\n  <label for=\"picture_imageable_id\">Imageable</label>\n  <div class=\"row\">\n      <div class=\"col-xs-6 col-sm-3\">\n        <select class=\"form-control\" name=\"picture[imageable_type]\" id=\"picture_imageable_type\"><option value=\"\"></option>\n<option selected=\"selected\" value=\"Product\">Product</option></select>\n      </div>\n      <div class=\"col-xs-3\">\n        <input class=\"form-control\" type=\"text\" value=\"1\" name=\"picture[imageable_id]\" id=\"picture_imageable_id\" />\n      </div>\n  </div>\n  \n</div>\n"
      expect(rendered).to match "selected=\"selected\""
    end

    context 'when value is nil' do
      let(:object)  { Picture.new }
      let(:value)   { nil }

      it 'renders the polymorphic form' do
        expect(rendered).to eq "<div class=\"form-group \">\n  <label for=\"picture_imageable_id\">Imageable</label>\n  <div class=\"row\">\n      <div class=\"col-xs-6 col-sm-3\">\n        <select class=\"form-control\" name=\"picture[imageable_type]\" id=\"picture_imageable_type\"><option value=\"\"></option>\n<option value=\"Product\">Product</option></select>\n      </div>\n      <div class=\"col-xs-3\">\n        <input class=\"form-control\" type=\"text\" name=\"picture[imageable_id]\" id=\"picture_imageable_id\" />\n      </div>\n  </div>\n  \n</div>\n"
        expect(rendered).not_to match "selected=\"selected\""
      end
    end
  end
end
