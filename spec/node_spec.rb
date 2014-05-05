require 'spec_helper'
require 'node'

describe Node do
  context "without children" do
    let(:node) { Node.new("foo") }

    it "has no children" do
      expect(node.children).to be_empty
    end

    it "has foo as content" do
      expect(node.content).to eq 'foo'
    end
  end

  context "with children" do
    let(:node) { Node.new("foo", ["bar", "baz"]) }
    
    it "has two children" do
      expect(node.children.length).to eq 2
    end
  end
end
