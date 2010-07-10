# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{honstats}
  s.version = "2.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Lloyd Pick", "Julio Monteiro", "Pol Llovet"]
  s.date = %q{2010-07-10}
  s.description = %q{Ruby Gem for accessing Heroes of Newerth player statistics}
  s.email = %q{lloydpick@gmail.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    ".gitignore",
     "README.rdoc",
     "Rakefile",
     "lib/honstats.rb",
     "lib/honstats/account.rb",
     "lib/honstats/base.rb",
     "lib/honstats/character.rb",
     "lib/honstats/character_hero_usage.rb",
     "lib/honstats/clan/clan.rb",
     "lib/honstats/clan/member.rb",
     "lib/honstats/hero_usage.rb",
     "lib/honstats/item_usage.rb",
     "lib/honstats/match.rb",
     "lib/honstats/match/team.rb",
     "lib/honstats/match/team_player.rb",
     "lib/honstats/match/team_stat.rb",
     "lib/honstats/public_stats.rb",
     "lib/honstats/ranked_stats.rb",
     "spec/account_spec.rb",
     "spec/hon-stats_spec.rb",
     "spec/hon_xml_api.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/lloydpick/honstats}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Ruby Gem for accessing Heroes of Newerth player statistics}
  s.test_files = [
    "spec/hon_xml_api.rb",
     "spec/hon-stats_spec.rb",
     "spec/account_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.3.0"])
      s.add_runtime_dependency(%q<libxml-ruby>, [">= 1.1.4"])
      s.add_runtime_dependency(%q<eventmachine>, [">= 0.12.10"])
    else
      s.add_dependency(%q<rspec>, [">= 1.3.0"])
      s.add_dependency(%q<libxml-ruby>, [">= 1.1.4"])
      s.add_dependency(%q<eventmachine>, [">= 0.12.10"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.3.0"])
    s.add_dependency(%q<libxml-ruby>, [">= 1.1.4"])
    s.add_dependency(%q<eventmachine>, [">= 0.12.10"])
  end
end
