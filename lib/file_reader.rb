class FileReader
  def readlines(file)
    File.read(file).split("\n")
  end
end
