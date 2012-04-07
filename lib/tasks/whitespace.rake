script_file = File.join(Rails.root, "script", "strip_whitespace.sh")

desc "Remove trailing whitespace and convert tabs to spaces"
task :strip_whitespace do
  `sh #{script_file}`
end

namespace :strip_whitespace do

  desc "Installs a git pre-commit hook which removes trailing whitespace and converts tabs to spaces"
  task :install, :force do |t, args|
    if !args.force && File.size?(".git/hooks/pre-commit")
      abort '.git/hooks/pre-commit already exists. Install with "rake strip_whitespace:install[true]"'
    else
      puts "Installing .git/hooks/pre-commit ..."
      FileUtils.mkdir_p "#{Rails.root}/.git/hooks"
      FileUtils.cp script_file, ".git/hooks/pre-commit"
      File.chmod(0755, ".git/hooks/pre-commit")
    end
  end
end
