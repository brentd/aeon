# DO NOT MODIFY THIS FILE
module Bundler
  dir = File.dirname(__FILE__)

  ENV["GEM_HOME"] = dir
  ENV["GEM_PATH"] = dir
  ENV["PATH"]     = "#{dir}/../bin:#{ENV["PATH"]}"
  ENV["RUBYOPT"]  = "-r#{__FILE__} #{ENV["RUBYOPT"]}"

  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/activesupport-2.3.3/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/activesupport-2.3.3/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/addressable-2.0.2/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/addressable-2.0.2/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/change_class-1.0.1/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/change_class-1.0.1/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/data_objects-0.9.12/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/data_objects-0.9.12/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/dm-ar-finders-0.9.11/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/dm-ar-finders-0.9.11/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/dm-core-0.9.11/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/dm-core-0.9.11/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/dm-sweatshop-0.9.11/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/dm-sweatshop-0.9.11/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/dm-timestamps-0.9.11/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/dm-timestamps-0.9.11/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/dm-validations-0.9.11/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/dm-validations-0.9.11/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/do_sqlite3-0.9.12/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/do_sqlite3-0.9.12/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/eventmachine-0.12.8/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/eventmachine-0.12.8/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/extlib-0.9.12/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/extlib-0.9.12/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/randexp-0.1.4/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/randexp-0.1.4/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/rspec-1.2.8/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/rspec-1.2.8/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/RubyInline-3.8.3/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/RubyInline-3.8.3/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/term-ansicolor-1.0.4/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/term-ansicolor-1.0.4/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/ZenTest-4.1.4/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/ZenTest-4.1.4/lib")

  @gemfile = "#{dir}/../../Gemfile"

  require "rubygems"

  @bundled_specs = {}
  @bundled_specs["activesupport"] = eval(File.read("#{dir}/specifications/activesupport-2.3.3.gemspec"))
  @bundled_specs["activesupport"].loaded_from = "#{dir}/specifications/activesupport-2.3.3.gemspec"
  @bundled_specs["addressable"] = eval(File.read("#{dir}/specifications/addressable-2.0.2.gemspec"))
  @bundled_specs["addressable"].loaded_from = "#{dir}/specifications/addressable-2.0.2.gemspec"
  @bundled_specs["change_class"] = eval(File.read("#{dir}/specifications/change_class-1.0.1.gemspec"))
  @bundled_specs["change_class"].loaded_from = "#{dir}/specifications/change_class-1.0.1.gemspec"
  @bundled_specs["data_objects"] = eval(File.read("#{dir}/specifications/data_objects-0.9.12.gemspec"))
  @bundled_specs["data_objects"].loaded_from = "#{dir}/specifications/data_objects-0.9.12.gemspec"
  @bundled_specs["dm-ar-finders"] = eval(File.read("#{dir}/specifications/dm-ar-finders-0.9.11.gemspec"))
  @bundled_specs["dm-ar-finders"].loaded_from = "#{dir}/specifications/dm-ar-finders-0.9.11.gemspec"
  @bundled_specs["dm-core"] = eval(File.read("#{dir}/specifications/dm-core-0.9.11.gemspec"))
  @bundled_specs["dm-core"].loaded_from = "#{dir}/specifications/dm-core-0.9.11.gemspec"
  @bundled_specs["dm-sweatshop"] = eval(File.read("#{dir}/specifications/dm-sweatshop-0.9.11.gemspec"))
  @bundled_specs["dm-sweatshop"].loaded_from = "#{dir}/specifications/dm-sweatshop-0.9.11.gemspec"
  @bundled_specs["dm-timestamps"] = eval(File.read("#{dir}/specifications/dm-timestamps-0.9.11.gemspec"))
  @bundled_specs["dm-timestamps"].loaded_from = "#{dir}/specifications/dm-timestamps-0.9.11.gemspec"
  @bundled_specs["dm-validations"] = eval(File.read("#{dir}/specifications/dm-validations-0.9.11.gemspec"))
  @bundled_specs["dm-validations"].loaded_from = "#{dir}/specifications/dm-validations-0.9.11.gemspec"
  @bundled_specs["do_sqlite3"] = eval(File.read("#{dir}/specifications/do_sqlite3-0.9.12.gemspec"))
  @bundled_specs["do_sqlite3"].loaded_from = "#{dir}/specifications/do_sqlite3-0.9.12.gemspec"
  @bundled_specs["eventmachine"] = eval(File.read("#{dir}/specifications/eventmachine-0.12.8.gemspec"))
  @bundled_specs["eventmachine"].loaded_from = "#{dir}/specifications/eventmachine-0.12.8.gemspec"
  @bundled_specs["extlib"] = eval(File.read("#{dir}/specifications/extlib-0.9.12.gemspec"))
  @bundled_specs["extlib"].loaded_from = "#{dir}/specifications/extlib-0.9.12.gemspec"
  @bundled_specs["randexp"] = eval(File.read("#{dir}/specifications/randexp-0.1.4.gemspec"))
  @bundled_specs["randexp"].loaded_from = "#{dir}/specifications/randexp-0.1.4.gemspec"
  @bundled_specs["rspec"] = eval(File.read("#{dir}/specifications/rspec-1.2.8.gemspec"))
  @bundled_specs["rspec"].loaded_from = "#{dir}/specifications/rspec-1.2.8.gemspec"
  @bundled_specs["RubyInline"] = eval(File.read("#{dir}/specifications/RubyInline-3.8.3.gemspec"))
  @bundled_specs["RubyInline"].loaded_from = "#{dir}/specifications/RubyInline-3.8.3.gemspec"
  @bundled_specs["term-ansicolor"] = eval(File.read("#{dir}/specifications/term-ansicolor-1.0.4.gemspec"))
  @bundled_specs["term-ansicolor"].loaded_from = "#{dir}/specifications/term-ansicolor-1.0.4.gemspec"
  @bundled_specs["ZenTest"] = eval(File.read("#{dir}/specifications/ZenTest-4.1.4.gemspec"))
  @bundled_specs["ZenTest"].loaded_from = "#{dir}/specifications/ZenTest-4.1.4.gemspec"

  def self.add_specs_to_loaded_specs
    Gem.loaded_specs.merge! @bundled_specs
  end

  def self.add_specs_to_index
    @bundled_specs.each do |name, spec|
      Gem.source_index.add_spec spec
    end
  end

  add_specs_to_loaded_specs
  add_specs_to_index

  def self.require_env(env = nil)
    context = Class.new do
      def initialize(env) @env = env && env.to_s ; end
      def method_missing(*) ; end
      def only(env)
        old, @only = @only, _combine_onlys(env)
        yield
        @only = old
      end
      def except(env)
        old, @except = @except, _combine_excepts(env)
        yield
        @except = old
      end
      def gem(name, *args)
        opt = args.last || {}
        only = _combine_onlys(opt[:only] || opt["only"])
        except = _combine_excepts(opt[:except] || opt["except"])
        files = opt[:require_as] || opt["require_as"] || name

        return unless !only || only.any? {|e| e == @env }
        return if except && except.any? {|e| e == @env }

        files.each { |f| require f }
        yield if block_given?
        true
      end
      private
      def _combine_onlys(only)
        return @only unless only
        only = [only].flatten.compact.uniq.map { |o| o.to_s }
        only &= @only if @only
        only
      end
      def _combine_excepts(except)
        return @except unless except
        except = [except].flatten.compact.uniq.map { |o| o.to_s }
        except |= @except if @except
        except
      end
    end
    context.new(env && env.to_s).instance_eval(File.read(@gemfile))
  end
end

module Gem
  def source_index.refresh!
    super
    Bundler.add_specs_to_index
  end
end
