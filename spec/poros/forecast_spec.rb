require 'rails_helper'

RSpec.describe "forecast poro", vcr: { record: :new_episodes } do
  describe "instantiation and attributes" do
    before do
      @forecast = ForecastFacade.new("Burlington,VT").create_forecast
    end

    it "exists" do
      expect(@forecast).to be_a(Forecast)
    end
    
    it "has attributes" do
      expect(@forecast.current_weather).to be_a(Hash)
      expect(@forecast.daily_weather).to be_a(Array)
      expect(@forecast.hourly_weather).to be_a(Array)
    end
  end
end