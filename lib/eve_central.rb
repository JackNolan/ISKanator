class EveCentral
  JITA_SYSTEM_ID = 30000142
  EVE_CENTRAL_URL ='http://api.eve-central.com/api/marketstat'

  class << self
    def jita_price_for(item_id)
      response = get_prices(item_id)
      {buy_price_cents: buy_price(response), sell_price_cents: sell_price(response)}
    end

    private

      def get_prices(item_id)
        Hash.from_xml RestClient.post EVE_CENTRAL_URL, { typeid: item_id, usesystem: JITA_SYSTEM_ID }
      end

      def buy_price(response)
        response["evec_api"]["marketstat"]["type"]["buy"]["max"]
      end

      def sell_price(response)
        response["evec_api"]["marketstat"]["type"]["sell"]["min"]
      end
  end
end
