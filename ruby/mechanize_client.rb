require 'mechanize'

@agent = Mechanize.new

def create_word_of_day(url)
  page = @agent.get(url)
  date = page.at('article div span').text.strip
  word_descriptions = page.search('div.wod-definition-container p')[0..-4]
  word_of_the_day = page.search('div.word-and-pronunciation h1').text.strip

  puts page.title[0..-18]
  puts "On #{date[18..date.length]} the word of the day is #{word_of_the_day}"
  puts ''
  puts "#{word_of_the_day} means:"

  word_descriptions.each do |description|
    if description == word_descriptions[-1]
      puts ''
      puts "Etiology: #{description.text}"
    else
      puts description.text
    end
  end
  link = page.link_with(text: 'Prev')
  page = link.click
  create_word_of_day(page.uri)
end

start_url = 'https://www.merriam-webster.com/word-of-the-day'
create_word_of_day(start_url)
