require 'unrar'

describe Unrar::Archive do
  describe "finding the unrar executable" do
    before do
      Unrar::Archive.class_variable_set(:@@unrar, nil)
    end

    context "on search path" do
      before do
        Unrar::Archive.should_receive(:search_for).with("unrar").and_return("/pants/unrar")
      end

      it "should find unrar" do
        Unrar::Archive.unrar.should == "/pants/unrar"
      end
    end

    context "not on search path" do
      before do
        Unrar::Archive.should_receive(:search_for).with("unrar").and_return(nil)
      end

      it "should not find unrar" do
        Unrar::Archive.unrar.should be_nil
      end
    end
  end

  describe "should be able to extract" do
    subject { Unrar::Archive.new('spec/fixtures/test.rar') }

    it "a single file" do
      subject.extract('001.jpg').should_not be_nil
    end

    it "multiple files" do
      subject.extract('001.jpg', '002.jpg').should have_exactly(2).items
    end
  end

  describe "should be able to list files" do
    subject { Unrar::Archive.new('spec/fixtures/test.rar') }

    it "Correctly list all files" do
      subject.list.should have(3).items
    end
  end

end
