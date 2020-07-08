require './caesar_cipher'

describe "#caesar_cipher" do
  it "shifts letters by 1" do
    expect(caesar_cipher("aa", 1)).to eql("bb")
  end
  it "works with a negative shift" do
    expect(caesar_cipher("cc", -2)).to eql("aa")
  end
  it "wraps back after Z" do
    expect(caesar_cipher("zz", 1)).to eql("aa")
  end
  it "works with upper and lower case" do
    expect(caesar_cipher("AbCxYz", 1)).to eql("BcDyZa")
  end
  it "ignores blank spacers" do
    expect(caesar_cipher("a b  c   d    e", 3)).to eql("d e  f   g    h")
  end
  it "ignores non-letter characters" do
    expect(caesar_cipher("I have $10!",3)).to eql("L kdyh $10!")
  end
end
