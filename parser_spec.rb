require_relative './parser'

describe Parser do
  let(:parser) { Parser.new("1 + 1") }
  it "can be initialized" do
    expect(parser).to be_a_instance_of Parser
  end

  describe "#infix" do
    it "should handle single values" do
      expect(Parser.new("1").infix).to eq %w[1]
    end

    it "should handle multiple values" do
      expect(Parser.new("1 + 1").infix).to eq %w[1 + 1]
    end

    it "should handle values w/o whitespace" do
      expect(Parser.new("2+1").infix).to eq %w[2 + 1]
    end

    it "should handle parenthesis" do
      expect(Parser.new("(1+1)").infix).to eq %w[( 1 + 1 )]
    end

    it "should handle multiple parenthesis" do
      expect(Parser.new("((100+10))").infix).to eq %w[( ( 100 + 10 ) )]
    end
  end

  describe "#postfix" do
    it "handles simple expressions" do
      expect(Parser.new("3 + 4").postfix).to eq %w[3 4 +]
      expect(Parser.new("1 + 2 - 3").postfix).to eq %w[1 2 + 3 -]
    end

    it "caches the result" do
      parser = Parser.new("1 + 1")
      expect(parser.postfix.object_id).to eq parser.postfix.object_id
    end

    it "handles presdence" do
      expect(Parser.new("A + B * C - D").postfix).to eq %w[A B C * + D -]
    end
  end
end
