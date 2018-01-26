require "../api/api_test.rb"
#require 'capybara'
require "rspec"
#require "selenium-webdriver"
#require 'rubygems'
require 'capybara'

describe  "Open up Web browser" do
  
  it 'should open up web browser' do
    emailbody = ""

    session = Capybara::Session.new(:selenium)

    url = "https://www.webpagetest.org"


    #driver = Selenium::WebDriver.for :firefox

    wait = Selenium::WebDriver::Wait.new(:timeout => 300)

    websites_from_file = ["https://www.webpagetest.org"]

    websites = {}


    websites_from_file.each do |urls|

      session.visit('https://www.webpagetest.org')


      # Input to Test Website

      websiteurl = find('#url').click

      websiteurl.clear()

      websiteurl.send_keys urls

      # Click Button

      #submit_button = driver.find_element(:class, "start_test")

      submit_button.click

      # Timeout/Idle code then check for elements

      load_time = wait.until {
        loading = driver.find_element(:id, "LoadTime")
        loading if loading.displayed?
      }

      first_byte = driver.find_element(:id, "TTFB")

      puts "Test Passed" if load_time && first_byte
      puts load_time.text, first_byte.text


      emailbody = emailbody + "Values are #{load_time.text}(Load Time), #{first_byte.text}(First Byte), and is the website I used for #{urls}\n\n"

        websites[urls] = {"load_time" => load_time.text, "first_byte" => first_byte.text}
      end
    driver.quit


end

  #before(:each)  

    #driver = Selenium::WebDriver.for :firefox

    #driver.navigate.to 'www.webpagetest.org'

    #driver.find_element(:id, "url")







=begin
  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @url = "https://www.webpagetest.org/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @wait = Selenium::WebDriver::Wait.new(:timeout => 300)
  end
 
  after(:each) do
    @driver.quit   
  end
 
  it "search website on webpagetest" do
    @driver.get(@url + "/")
    @driver.find_element(:id, "url").clear
    @driver.find_element(:id, "url").send_keys "www.amazon.com"
    @driver.find_element(:class, "start_test").click
  end
=end
end
