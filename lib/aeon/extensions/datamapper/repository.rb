module DataMapper
  class Repository
    IDENTITY_MAPS = {}
    
    def identity_map(model)
      IDENTITY_MAPS[model] ||= IdentityMap.new
    end
    
    def self.reset_identity_maps!
      IDENTITY_MAPS.replace({})
    end
  end
end