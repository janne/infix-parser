require 'spec_helper'
require 'parser'

describe Parser do
  let(:parser) { Parser.new("1 + 1") }
  it "can be initialized" do
    expect(parser).to be_a_instance_of Parser
  end

  describe "#infix" do
    it "should handle integers" do
      expect(Parser.new("1").infix).to eq [1]
    end

    it "should handle floats" do
      expect(Parser.new("3.14").infix).to eq [3.14]
    end

    it "should handle multiple values" do
      expect(Parser.new("1 + 1.0").infix).to eq [1, '+', 1.0]
    end

    it "should handle values w/o whitespace" do
      expect(Parser.new("2+1").infix).to eq [2, '+', 1]
    end

    it "should handle parentheses" do
      expect(Parser.new("(1+1)").infix).to eq ['(', 1, '+', 1, ')']
    end

    it "should handle multiple parentheses" do
      expect(Parser.new("((100+10))").infix).to eq ['(', '(', 100, '+', 10, ')', ')']
    end
  end

  describe "#postfix" do
    it "handles simple expressions" do
      expect(Parser.new("3 + 4").postfix).to eq [3, 4, '+']
      expect(Parser.new("1 + 2 - 3").postfix).to eq [1, 2, '+', 3, '-']
    end

    it "caches the result" do
      parser = Parser.new("1 + 1")
      expect(parser.postfix.object_id).to eq parser.postfix.object_id
    end

    it "handles presdence" do
      expect(Parser.new("A + B * C - D").postfix).to eq %w[A B C * + D -]
    end

    it "handles parentheses" do
      expect(Parser.new("3 + 4 * 2 / ( 1 - 5 )").postfix).to eq [3, 4, 2, '*', 1, 5, '-', '/', '+']
    end
  end

  describe "#tree" do
    it "returns a Node" do
      expect(Parser.new("1+1").tree).to be_a(Node)
    end
  end

  describe "#eval" do
    it "evaluates the expression" do
      expect(Parser.new("3 + 4 * 2 / ( 1 - 5 )").eval).to eq 1
    end
  end
end
