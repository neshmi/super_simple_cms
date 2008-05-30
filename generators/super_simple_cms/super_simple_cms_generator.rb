class SuperSimpleCmsGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.migration_template 'migration.rb', 'db/migrate', :migration_file_name=>'create_super_simple_cms'
    end
  end
end
