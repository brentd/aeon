# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{dm-sweatshop}
  s.version = "0.9.11"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ben Burkert"]
  s.date = %q{2009-03-29}
  s.description = %q{DataMapper plugin for building pseudo random models}
  s.email = ["ben [a] benburkert [d] com"]
  s.extra_rdoc_files = ["README.textile", "LICENSE", "TODO", "History.txt"]
  s.files = ["History.txt", "LICENSE", "Manifest.txt", "README.textile", "Rakefile", "TODO", "lib/dm-sweatshop.rb", "lib/dm-sweatshop/model.rb", "lib/dm-sweatshop/sweatshop.rb", "lib/dm-sweatshop/unique.rb", "lib/dm-sweatshop/version.rb", "spec/dm-sweatshop/model_spec.rb", "spec/dm-sweatshop/sweatshop_spec.rb", "spec/dm-sweatshop/unique_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "tasks/install.rb", "tasks/spec.rb"]
  s.homepage = %q{http://github.com/sam/dm-more/tree/master/dm-sweatshop}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{datamapper}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{DataMapper plugin for building pseudo random models}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<dm-core>, ["= 0.9.11"])
      s.add_runtime_dependency(%q<randexp>, ["~> 0.1.4"])
    else
      s.add_dependency(%q<dm-core>, ["= 0.9.11"])
      s.add_dependency(%q<randexp>, ["~> 0.1.4"])
    end
  else
    s.add_dependency(%q<dm-core>, ["= 0.9.11"])
    s.add_dependency(%q<randexp>, ["~> 0.1.4"])
  end
end
