require "simplecov"

SimpleCov.start do
  add_filter "test"
end

if ENV["CI"] == "true"
  require "codecov"
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end
