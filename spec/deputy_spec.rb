require_relative '../lib/deputy'

describe "Mon programme de scrapping des députés  fonctionne-t-il ?" do
    it "Le programme doit me retourner un array" do
    expect(get_deputy_urls.is_a?Array).to eq(true)
     end

    it "Le tableau doit contenir à minima 100 députés" do
        expect(get_deputy_urls.length>5).to eq(true)
       end

    it "Madame Alauzet est elle toujours député" do
        expect(get_deputy_urls.join.include?('Alauzet')).to eq(true)   
      end


  end
