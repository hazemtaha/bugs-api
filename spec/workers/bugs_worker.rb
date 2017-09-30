require 'rails_helper'

RSpec.describe BugsWorker do
  let(:bug) do
    state = FactoryGirl.build(:state)
    bug = FactoryGirl.build(:bug, state: state)
  end

  describe "#work" do
    it "creates a new bug" do
      expect do
        described_class.new.work(bug.to_json)
      end.to change(Bug, :count).by(1)
    end
  end
end
