require 'rails_helper'

RSpec.describe GoalsController, type: :routing do
  it "routes POST /goals/score_calculation to goals#score_calculation" do
    expect(post: "/goals/score_calculation").to route_to("goals#score_calculation")
  end
end
