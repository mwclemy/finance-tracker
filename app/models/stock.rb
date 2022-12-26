class Stock < ApplicationRecord
    def self.new_lookup(ticker_symbol)
        client = IEX::Api::Client.new(publishable_token: Rails.application.credentials.iex_client[:publishable_token],
                                    secret_token: Rails.application.credentials.iex_client[:secret_token],
                                    endpoint: 'https://cloud.iexapis.com/v1')
        begin 
            quote = client.quote(ticker_symbol)
            new(name: quote.company_name, ticker: ticker_symbol, price: quote.latest_price)
        rescue => e
            return nil
        end
    end
end
