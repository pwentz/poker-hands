require_relative '../lib/parser'
require_relative './mocks/file_reader_mock'

RSpec.describe Parser do
  describe '#txt' do
    xit 'parses a text file' do
      hands = Parser.new(FileReaderMock.new).txt(file: "some-file.txt", cards: 5)

      expect(hands).to eq({
        player_1: ["8C", "TS", "KC", "9H", "4S"],
        player_2: ["7D", "2S", "5D", "3S", "AC"]
      })
    end
  end
end
