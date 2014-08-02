require "templater"

describe "string_templater" do
  before(:each) do
    @hash = {"day" => "Thursday", "name" => "Billy"}
  end

  it "replaces a single variable" do
    string = "${name} has an appointment"
    expect(string_templater(@hash, string)).to eq("Billy has an appointment")
  end

  it "replaces multiple variables" do
    string = "${name} has an appointment on ${day}"
    expect(string_templater(@hash, string)).to eq("Billy has an appointment on Thursday")
  end

  it "can escape variables" do
    string = "${${name}} has an appointment on ${${Thursday}}"
    expect(string_templater(@hash, string)).to eq("${Billy} has an appointment on ${Thursday}")
  end

  it "raises an error when a variable is missing" do
    string = "${name} hates going to see the ${dentist}"
    expect(string_templater(@hash, string)).to eq("Variable Missing!")
  end
end