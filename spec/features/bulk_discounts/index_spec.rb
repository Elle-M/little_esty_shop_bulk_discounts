require 'rails_helper'

RSpec.describe 'bulk items index' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Jewelry')

    @discount1 = BulkDiscount.create!(name: 'Cheap Things', percentage: 20, quantity_threshold: 10, merchant_id: @merchant1.id)
    @discount2 = BulkDiscount.create!(name: 'Mythical Deals', percentage: 30, quantity_threshold:15, merchant_id: @merchant1.id)
    @discount3 = BulkDiscount.create!(name: 'Surplus Value', percentage: 40, quantity_threshold: 20, merchant_id: @merchant1.id)
    @discount4 = BulkDiscount.create!(name: 'Discount Galore', percentage: 50, quantity_threshold: 25, merchant_id: @merchant2.id)
    
    visit merchant_bulk_discounts_path(@merchant1)
  end

  describe 'user story 1' do
    it 'shows all of my bulk discounts including their percentage discount and quantity thresholds' do
      expect(page).to have_content(@discount1.name)
      expect(page).to have_content(@discount2.name)
      expect(page).to have_content(@discount3.name)
      expect(page).to_not have_content(@discount4.name)
      
      expect(page).to have_content(@discount1.percentage)
      expect(page).to have_content(@discount2.percentage)
      expect(page).to have_content(@discount3.percentage)
      expect(page).to_not have_content(@discount4.percentage)
      
      expect(page).to have_content(@discount1.quantity_threshold)
      expect(page).to have_content(@discount2.quantity_threshold)
      expect(page).to have_content(@discount3.quantity_threshold)
      expect(page).to_not have_content(@discount4.quantity_threshold)
    end

    it 'displays each bulk discount listed includes a link to its show page' do
      expect(page).to have_link(@discount1.name)
      expect(page).to have_link(@discount2.name)
      expect(page).to have_link(@discount3.name)
      expect(page).to_not have_link(@discount4.name)
    end
  end  

  describe 'user story 3' do  
    it 'has a link to delete it next to each bulk discount' do
      expect(page).to have_content(@discount1.name)
      expect(page).to have_link('Delete')
      click_link('Delete', match: :first)
      
      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))
      expect(page).to_not have_content(@discount1.name)
      expect(page).to have_content(@discount2.name)
      expect(page).to have_content(@discount3.name)
    end
  end  

  describe 'user story 9' do  
    xit 'displays the name and date of the next 3 upcoming US holidays' do
      three_holidays = HolidayService.name_and_date_next_three_holidays

      within("#holidays") do
        expect(page).to have_content("Upcoming Holidays")
          three_holidays.each do |holiday|
        expect(page).to have_content(holiday)
        end
      end  
    end
  end  
end

