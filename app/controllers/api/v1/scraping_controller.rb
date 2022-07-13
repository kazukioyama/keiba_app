class Api::V1::ScrapingController < ApplicationController
  # before_action :set_admin
  BASE_URL = 'https://race.netkeiba.com'

  def fetch_daily_race_data
    race_date_str = params[:race_date]
    req_url = BASE_URL + "/top/race_list.html?kaisai_date=#{race_date_str}"

    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')

    driver = Selenium::WebDriver.for :chrome, options: options

    driver.navigate.to req_url

    race_date_info = []
    race_data_node_list = driver.find_elements(:class_name, "RaceList_DataList")
    race_data_node_list.each do |race_data_node|
      race_category = race_data_node.find_element(:class_name, "RaceList_DataTitle").text
      race_data_item_node_list = race_data_node.find_elements(:class_name, "RaceList_DataItem")
      race_id_list = []
      # binding.pry
      race_data_item_node_list.each do |item_node|
        race_name = item_node.find_element(:class_name, "RaceList_ItemTitle").text
        race_start_at_str, race_course_event, number_of_starters_str = item_node.find_element(:class_name, "RaceData").text.split(' ')
        race_url = item_node.find_element(:tag_name, "a").attribute('href')
        race_id = race_url.slice(/(?<=race_id=)(.*)(?=&rf=race_list)/)
        race_id_list << {race_name: race_name, race_id: race_id}
      end
      race_date_info << {race_category: race_category, race_list: race_id_list}
    end

    driver.quit

    render json: race_date_info
  end

  def fetch_daily_race_data_for_fullcalendar
    race_date_str = params[:race_date]
    race_date = Date.strptime(race_date_str, '%Y%m%d')
    req_url = BASE_URL + "/top/race_list.html?kaisai_date=#{race_date_str}"

    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')

    driver = Selenium::WebDriver.for :chrome, options: options

    driver.navigate.to req_url

    race_list = []
    race_data_node_list = driver.find_elements(:class_name, "RaceList_DataList")
    color_list = ['green', 'yellow', 'red']
    race_data_node_list.each_with_index do |race_data_node, i|
      race_category = race_data_node.find_element(:class_name, "RaceList_DataTitle").text.slice(/ .+ /).delete(' ')
      race_data_item_node_list = race_data_node.find_elements(:class_name, "RaceList_DataItem")
      race_data_item_node_list.each do |item_node|
        race_number = item_node.find_element(:class_name, "Race_Num").text
        race_name = item_node.find_element(:class_name, "RaceList_ItemTitle").text
        race_start_at_str, race_course_event, number_of_starters_str = item_node.find_element(:class_name, "RaceData").text.split(' ')
        race_url = item_node.find_element(:tag_name, "a").attribute('href')
        race_id = race_url.slice(/(?<=race_id=)(.*)(?=&rf=race_list)/)
        # race_list << {"title": "#{race_category} #{race_name}", "start": "#{race_date.strftime('%Y-%m-%d')}", "end": "#{race_date.strftime('%Y-%m-%d')}"}
        race_list << {
          "title": "【#{race_category}(#{race_number})】 #{race_name} (#{race_course_event} #{number_of_starters_str})",
          "start": "2022-07-10",
          "end": "2022-07-10",
          "startTime": race_start_at_str,
          "color": color_list[i],
          "raceId": race_id
        }
      end
      # race_date_info << {race_category: race_category, race_list: race_id_list}
    end

    # binding.pry
    driver.quit

    render json: race_list
  end

  def fetch_race_info

    date = DateTime.new(2022, 6, 12, 12, 30, 45).strftime("%Y%m%d")
    conn = ::Faraday.new(url: BASE_URL)
    # race_id = "202202010201"
    race_id = params[:race_id]
    req_url = BASE_URL + "/race/result.html?race_id=#{race_id}&rf=race_list"
    html = conn.get(req_url)
    doc = Nokogiri::HTML.parse(html.body)

    # レース情報
    race_node = doc.css(".RaceList_Item02")
    race_info01_list = doc.css(".RaceList_Item02").css(".RaceData01").text.gsub(/[\n]/, "").split("/ ")
    race_info = {
                  race_name: race_node.css(".RaceName").text.gsub(/\n/, ""),
                  race_start_time: race_info01_list[0],
                  race_course_event: race_info01_list[1],
                  race_weather: race_info01_list[2].delete("天候:"),
                  race_going: race_info01_list[2].delete("馬場:"), #馬場状態
                  race_prize_money: doc.css(".RaceList_Item02").css(".RaceData02").text.gsub(/\n/, "")
                   #'本賞金'以降の文字列(賞金額)を取得
                }

    # 出馬表
    horse_list = []
    doc.css(".ResultTableWrap").css(".HorseList").each do |node|
      name_node = node.css(".Horse_Name").css("a")
      horse_list << {
                      horse_number: node.css(".Txt_C")[0].text&.to_i,
                      bracket_number: node.css(".Waku1").text&.to_i,
                      name: name_node.text,
                      sexial_age: node.css(".Horse_Info_Detail").text&.gsub(/\n/, ""),
                      jockey_weight: node.css(".JockeyWeight").text&.to_f,
                      jockey_name: node.css(".Jockey").text&.gsub(/\n/, ""),
                      odds: node.css(".Odds_Ninki").text&.to_f,
                      trainer: node.css(".Trainer").css("a").text,
                      stable: node.css(".Trainer").css("span").text,
                      horse_id: name_node.attr("href").value.match(/horse\//).post_match
                    }
    end

    render json: {race_info: race_info, race_horse_list: horse_list}

  end


  # def set_admin

  # end
end
