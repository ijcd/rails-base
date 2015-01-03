group :spec do
  guard('rspec', all_on_start: false,
        all_after_pass: false,
        run_all: { parallel: true, parallel_cli: '-n 4' },
        cmd: 'spring rspec',
        notification: true,
        failed_mode: :keep) do
    watch(%r{^spec/.+_spec\.rb$})
    watch(%r{^lib/(.+)\.rb$}) { |m| "spec/lib/#{m[1]}_spec.rb" }
    watch("spec/spec_helper.rb") { "spec" }

    watch(%r{^app/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
    watch(%r{^app/(.*)(\.erb|\.slim|\.haml)$}) { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
    watch(%r{^app/controllers/(.+)_(controller)\.rb$}) { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
    watch(%r{^spec/support/(.+)\.rb$}) { "spec" }
    watch("config/routes.rb") { "spec/routing" }
    watch("app/controllers/application_controller.rb") { "spec/controllers" }

    watch(%r{^app/views/(.+)/.*\.(erb|slim|haml)$}) { |m| "spec/features/#{m[1]}_spec.rb" }
  end
end

guard :teaspoon, cmd: 'spring teaspoon', environment: 'spec/teaspoon_env.rb' do
  # Implementation files
  watch(%r{^app/assets/javascripts/(.+).js}) { |m| "#{m[1]}_spec" }

  # Specs / Helpers
  watch(%r{^spec/javascripts/(.*)})
end

# # Start the spin server with RSpec and Cucumber support, and report time for each run
# guard 'spin', rspec:true, testunit: false, cli: "--time" do
#   # Spin itself
#   watch('config/application.rb')
#   watch('config/environment.rb')
#   watch(%r{^config/environments/.*\.rb$})
#   watch(%r{^config/initializers/.*\.rb$})
#   watch('Gemfile')
#   watch('Gemfile.lock')
#   watch(%r{spec/features/step_definitions/.*\.rb})
# end

# guard 'spin_rspec' do
#   # RSpec
#   # uses the .rspec file
#   # --colour --fail-fast --format documentation --tag ~slow
#   watch(%r{^spec/(.+)_spec\.rb$})
#   watch('spec/spec_helper.rb')                        { "spec" }
#   watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
#   watch(%r{^app/(.+)\.haml$})                         { |m| "spec/#{m[1]}.haml_spec.rb" }
#   watch(%r{^lib/(.+)\.rb$})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
#   watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/requests/#{m[1]}_spec.rb"] }
#   watch(%r{spec/features/(.+)\.feature})
# end
