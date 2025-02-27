require 'httparty'

class HolidayServices
  def holidays
    get_url(https://date.nager.at/api/v3/PublicHolidays/2023/US)
  end

  def get_url(url)
    response = HTTParty.get(url)
    parsed = JSON.parse(response.body, symbolize_names: true)
  end
end