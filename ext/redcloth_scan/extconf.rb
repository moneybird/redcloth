require 'mkmf'

host_cpu = RbConfig::CONFIG['host_cpu']
source_files = ['redcloth_attributes', 'redcloth_inline', 'redcloth_scan']

source_files.each do |base|
  if host_cpu =~ /arm64|aarch64/
    File.rename("#{base}_arm64.c", "#{base}.c") if File.exist?("#{base}_arm64.c")
  else
    File.rename("#{base}_amd64.c", "#{base}.c") if File.exist?("#{base}_amd64.c") 
  end
end

CONFIG['warnflags'].gsub!(/-Wshorten-64-to-32/, '') if CONFIG['warnflags']
$CFLAGS << ' -O0 -Wall ' if CONFIG['CC'] =~ /gcc/
dir_config("redcloth_scan")
create_makefile("redcloth_scan")
