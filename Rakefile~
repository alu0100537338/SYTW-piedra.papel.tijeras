desc "Arrancamos servidor"
task :default do
  sh "rackup"
end

desc "Piedra"
task :rock do
  sh %q{curl -v 'http://localhost:9292?choice=rock'}
end

desc "Papel"
task :paper do
  sh %q{curl -v 'http://localhost:9292?choice=paper'}
end

desc "Tijeras"
task :scissors do
  sh %q{curl -v 'http://localhost:9292?choice=scissors'}
end
