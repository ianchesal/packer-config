require 'fileutils'

CLEAN = FileList['deployment_dir/**/*'].exclude('*.txt')

task :clean do
  FileList['spec/integration/packer_cache/*'].each do |f|
    FileUtils.rm_f(f)
  end
  Dir.glob('spec/integration/builds/*').select { |f| File.directory? f }.each do |d|
    FileUtils.rm_rf(d)
  end
  Dir.glob('spec/integration/*.json').select { |f| File.file? f }.each do |d|
    FileUtils.rm_f(d)
  end
end

