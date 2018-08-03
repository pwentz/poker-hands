require_relative '../lib/parser'
require_relative './mocks/file_reader_mock'

RSpec.describe Parser do
  describe '#txt' do
    it 'returns an array of lines' do
      lines = Parser.new(FileReaderMock.new).txt("some-file.txt")

      expect(lines).to eq([
        "8C TS KC 9H 4S 7D 2S 5D 3S AC",
        "5C AD 5D AC 9C 7C 5H 8D TD KS"
      ])
    end
  end
end
