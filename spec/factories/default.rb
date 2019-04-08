FactoryBot.define do

    factory :order, class: Order do
        purchase_channel    { "Lojas Americanas" }
        client_name         { "Yudi PlayStation" }
        address             { "Sampa em algum lugar" }
        delivery_srvc       { "SEDEX" }
        value               { "R$ 523,00" }
        line_items          { "VideoGames" }
    end

    factory :batch, class: Batch do
        purchase_channel    { "Lojas Americanas" }
    end

end