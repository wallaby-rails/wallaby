$LOAD_PATH.push File.expand_path('lib', __dir__)

app_name = 'wallaby'
# Maintain your gem's version:
require "#{app_name}/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = app_name
  s.version = Wallaby::VERSION
  s.authors = ['Tianwen Chen']
  s.email = ['me@tian.im']
  s.homepage = "https://github.com/wallaby-rails/#{app_name}"
  s.summary = 'Autocomplete the resourceful actions and views for ORMs for admin interface and other purposes.'
  s.description = s.summary
  s.license = 'MIT'

  s.files = Dir[
    '{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc'
  ]
  s.test_files = Dir['test/**/*']

  s.add_dependency 'wallaby-core'
  s.add_dependency 'wallaby-active_record'

  s.add_dependency 'bootstrap'
  s.add_dependency 'bootstrap4-datetime-picker-rails'
  s.add_dependency 'codemirror-rails'
  s.add_dependency 'font-awesome-sass'
  s.add_dependency 'jbuilder'
  s.add_dependency 'jquery-minicolors-rails'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'momentjs-rails'
  s.add_dependency 'sass-rails'
  s.add_dependency 'summernote-rails'
  s.add_dependency 'twitter-typeahead-rails'
end
