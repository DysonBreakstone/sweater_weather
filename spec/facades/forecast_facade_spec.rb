require 'rails_helper'

RSpec.describe ForecastFacade, vcr: { record: :new_episodes } do
  it "exists" do
    facade = ForecastFacade.new("burlington,vt")
    expect(facade).to be_a(ForecastFacade)
    expect(facade.instance_variables).to eq([:@city])
  end

  it "#create_forecast" do
    forecast = ForecastFacade.new("burlington,vt").create_forecast
    expect(forecast).to be_a(Forecast)
    expect(forecast.current_weather).to be_a(Hash)
    expect(forecast.daily_weather).to be_a(Array)
    expect(forecast.hourly_weather).to be_a(Array)
  end
end