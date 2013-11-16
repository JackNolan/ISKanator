json.array!(@character_blueprints) do |character_blueprint|
  json.extract! character_blueprint, 
  json.url character_blueprint_url(character_blueprint, format: :json)
end
