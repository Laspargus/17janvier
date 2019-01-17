require 'rubygems'
require 'nokogiri'
require 'open-uri'

def crypto_scrapper

my_hash_each = {}
my_array = []


doc = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))

# On sélectionne tout le HTML de la balise /tr
    doc.xpath('//tr').each do |tr|

# On sélectionne le prix de la /tr
      price = tr.css('a.price').text

# On sélectionne la crypto de la /tr
      crypto = tr.css('td.col-symbol').text

# On associe les deux dans un hash
      my_hash_each = {crypto => price}

# On construit notre tableau de hashs au fur et à mesure
      my_array << my_hash_each
    end


puts my_array

return my_array

end

crypto_scrapper
