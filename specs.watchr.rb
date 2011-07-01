watch( '^spec/(.*)\/(.*)\_spec.rb' ){ |m| run( "rspec spec") }
watch( '(.*)\.rb' )                 { |m| run( "rspec spec" ) }
watch( 'spec/(.*)\_spec.rb' )       { |m| run( "rspec spec" ) }
watch( '^spec/spec_helper\.rb' )    { run( "rspec spec" ) }

def run(cmd)
  puts(cmd)
  system(cmd)
end
