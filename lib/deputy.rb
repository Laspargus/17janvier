require 'nokogiri'
require 'open-uri'
require 'rubygems'


def get_deputy_urls

    my_array=[]
    myhash_each = {}
  
    doc = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
    

        content = doc.css('div #deputes-list')

        vcard=["Prefixe", "first_name", "last_name", "email"]
        #Pour chaque lien avec une classe .lientxt, je vais récupérer le nom du lien et l'url
       

        
        #content.css('li/a').length.times do |i|
        
        
        # /!\ LIMITATION A 10 DEPUTES POUR ALLER PLUS VITE
        10.times do |i|
                    

                            begin    
                                    #Je récupère le nom complet du lien (le nom de la mairie)
                                    name= content.css('a')[i].text

                                    #Je crée un tableau avec les coordonnés
                                    detail_each=name.split(" ")
                                    

                                    #Je récupère le lien relatif de la mairie
                                    repertoire=content.css('a')[i]['href'].to_s
                                    domaine="http://www2.assemblee-nationale.fr"
                                    
                                    #Je crée le lien absolu à partir du domaine et du lien relatif
                                    link= domaine+repertoire.to_s
                            
                                    #J'appelle ma fonction qui transforme prends un url absolu, scrolle la page et récupère le mail
                                    email=get_deputy_email(link)
                                    
                            rescue => e
                            puts "Oups petite erreur, mais c'est pas grave" #résultat que tu veux voir en lieu et place d'une erreur terminal
                            i+=1
                            end      

                                    #Ajoute l'email dans le tableau des coordonnées
                                    detail_each<<email
                                
                                    
                                    puts vcard.zip(detail_each).to_h
                                
                                    #Je créais un hash contenant la paire  "Nom de la mairie" => "Mail de la mairie"
                                    myhash_each= {name => email}
                                    

                                    #Je stocke cette paire dans mon tableau
                                    my_array << myhash_each
                            
                
        end
     
        #Je renvoie mon tableau
     
     return my_array

   


end




#METHODE PERMETTANT DE RECUPERER LE MAIL DE LA MAIRIE A PARTIR DE L'URL DE LA MAIRIE
def get_deputy_email(url) 

    doc = Nokogiri::HTML(open(url))
    
       #je récupère le bloc d'info personnel
        content=doc.css(".vcard")
        #j'extrait le premier mail que je trouve
        mail=content.css('a')[0]['href']
        return mail
       
end 


#J'apelle ma méthode avec un perform
def perform
    get_deputy_urls
end 

perform