
def gsub_file(relative_destination, regexp, *args, &block)
  path = destination_path(relative_destination)
  content = File.read(path).gsub(regexp, *args, &block)
  File.open(path, 'wb') { |file| file.write(content) }
end