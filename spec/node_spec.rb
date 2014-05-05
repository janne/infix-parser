require 'spec_helper'
require 'node'

describe Node do
  let(:node) { Node.new("foo") }

  it "has no children" do
    expect(node.children).to be_empty
  end

  it "has foo as content" do
    expect(node.content).to eq 'foo'
  end

  it "allows adding children" do
    expect{node << "c1"}.to change{node.children.length}.from(0).to(1)
  end

  it "allows adding mutiple children" do
    node << "c1" << "c2"
    expect(node.children).to eq(%w[c1 c2])
  end

  it "allows nodes as children" do
    node << Node.new('another')
    expect(node.children.first.content).to eq 'another'
  end
end
