require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "require_assets"
    gem.summary = 'Ruby on Rails helpers to add asset links to views.'
    gem.description = 'Ruby on Rails helpers to add asset links to views. Extracted from merb-assets Merb plugin.'
    gem.email = "jeremy.burks@gmail.com"
    gem.homepage = "http://github.com/jrun/require_assets"
    gem.authors = ["Jeremy Burks"]
    gem.add_development_dependency "rspec", ">= 1.2.9"
    gem.add_development_dependency "yard", ">= 0"
    gem.add_development_dependency 'grancher', '> 0'
    gem.files += FileList['rails/*']

    desc "Install development dependencies."
    task :setup do
      gems = ::Gem::SourceIndex.from_installed_gems
      gem.dependencies.each do |dep|
        if gems.find_name(dep.name, dep.version_requirements).empty?
          puts "Installing dependency: #{dep}"
          system %Q|gem install #{dep.name} -v "#{dep.version_requirements}"  --development|
        end
      end
    end
    
    desc "Build and reinstall the gem locally."
    task :reinstall => :build  do
      version = File.read('VERSION')
      if (system("gem list #{gem.name} -l") || "")  =~ /#{gem.name}-#{version}/
        system "gem uninstall #{gem.name}"
      end
      system "gem install --no-rdoc --no-ri -l pkg/#{gem.name}-#{version}"
    end
  end

  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies
task :default => :spec
task :build => [:spec, :yard]

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end

begin
  require 'grancher/task'
  Grancher::Task.new do |g|
    g.branch = 'gh-pages'
    g.push_to = 'origin'
    g.directory 'doc'
  end
rescue LoadError
  task :publish do
    abort "grancher is not available. Run 'rake setup' to install all development dependencies."
  end
end
