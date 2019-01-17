require 'nokogiri'
require 'open-uri'
require 'rubygems'




#METHODE PERMETTANT DE RECUPERER UN TABLEAU AVEC DES COUPLES DE HASH NOM MAIRIE => LIEN PAGE MAIRIE

def get_townhall_urls

    my_array=[]
    myhash_each = {}
  
    doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
    
        content = doc.css('tr')
      
        #Pour chaque lien avec une classe .lientxt, je vais récupérer le nom du lien et l'url
       # content.css('.lientxt').length.times do |i|
              


              # /!\ LIMITATION A 10 MAIRIES POUR ALLER PLUS VITE
             10.times do |i|


              #Je récupère le nom du lien (le nom de la mairie)
              name= content.css('.lientxt')[i].text

              #Je récupère le lien relatif de la mairie
              repertoire=content.css('.lientxt')[i]['href'].delete_prefix('.')
              domaine="http://annuaire-des-mairies.com"
              
              #Je crée le lien absolu à partir du domaine et du lien relatif
              link= domaine+repertoire
            

              #J'appelle ma fonction qui transforme prends un url absolu, scrolle la page et récupère le mail
              email=get_townhall_email(link).join
              

              #Je créais un hash contenant la paire  "Nom de la mairie" => "Mail de la mairie"
              myhash_each= {name => email}
                
                
              #Je stocke cette paire dans mon tableau
              my_array << myhash_each

        end
     
        puts my_array
    #Je renvoie mon tableau
     return my_array


end




#METHODE PERMETTANT DE RECUPERER LE MAIL DE LA MAIRIE A PARTIR DE L'URL DE LA MAIRIE
def get_townhall_email(townhall_url) 

my_hash_each = {}
my_array = []
doc = Nokogiri::HTML(open(townhall_url))

    # J'utilise le xpath (position absolue du mail dans le tableau, 4eme ligne, 2ème colonne)en espérant qu'il soit le même sur chaque page de mairie
    # Une méthode plus sur consisterait à récupérer le mail en regex dans le tableau
    doc.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').each do |tr|
    my_array << tr.text
    end


return my_array
end


#J'apelle ma méthode avec un perform
def perform
    get_townhall_urls
end 

perform