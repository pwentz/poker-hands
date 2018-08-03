class FileReader
  def self.readlines(file)
    File.read(file).split("\n")
  end
end
