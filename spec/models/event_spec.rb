require 'spec_helper'

describe Event do
    let(:user) { FactoryGirl.create(:user) }
    before { @event = user.events.build(title: "hunger game", description: "Caleb Wang's Game") }
    
    subject { @event }
    
    it { should respond_to(:title) }
    it { should respond_to(:description) }
    it { should respond_to(:user_id) }
    it { should respond_to(:user) }
    its(:user) { should eq user }
    
    it { should be_valid }
    
    describe "When user_id is not present" do
        before { @event.user_id = nil }
        it {should_not be_valid }
    end
    
    describe "with blank description" do
      before { @event.description = " " }
      it { should_not be_valid }
    end
    
    describe "with title that is too long" do
      before { @event.title = "a" * 31 }
      it { should_not be_valid }
    end
end
