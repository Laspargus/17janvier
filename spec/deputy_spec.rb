require_relative '../lib/mairie'

describe "Mon programme de scrapping Crypto fonctionne-t-il ?" do
    it "Le programme doit me retourner un array" do
    expect(get_deputy_urls.is_a?Array).to eq(true)
     end

    it "Le tableau doit contenir à minima 100 Mairies" do
        expect(get_deputy_urls.length>100).to eq(true)
       end

    it "Monsieur Mélanchon est toujours député" do
        expect(get_deputy_urls.join.include?('Mélenchon')).to eq(true)   
      end

    it "Le premier député s'apelle DaMr Abad" do
        expect(get_deputy_urls[1]['last_name']).to eq("Abad")   
      end


  end
