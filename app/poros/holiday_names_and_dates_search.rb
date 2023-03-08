require './app/services/holiday_service'
require './app/poros/holiday_name_and_dates'

class HolidayNamesAndDatesSearch  
  def holiday_mame_and_dates_information  
    HolidayNamesAndDates.new(service.holiday_name_and_dates)
  end

  def service
    HolidayService.new 
  end
end