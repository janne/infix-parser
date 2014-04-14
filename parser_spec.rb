require_relative './parser'

describe Parser do
  let(:parser) { Parser.new("1 + 1") }
  it "can be initialized" do
    expect(parser).to be_a_instance_of Parser
  end

  describe "#length" do
    it "should split correctly" do
      expect(Parser.new("1").length).to eq 1
      expect(Parser.new("1 + 1").length).to eq 3
      expect(Parser.new("2+1").length).to eq 3
      expect(Parser.new("(1+1)").length).to eq 5
      expect(Parser.new("((100+10))").length).to eq 7
    end
  end
end
