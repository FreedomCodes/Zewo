struct MapSingleValueDecodingContainer<Map : DecodingMap> : SingleValueDecodingContainer {
    let decoder: MapDecoder<Map>
    let map: DecodingMap
    
    init(referencing decoder: MapDecoder<Map>, wrapping map: DecodingMap) {
        self.decoder = decoder
        self.map = map
    }
    
    func decodeNil() -> Bool {
        return map.decodeNil()
    }
    
    func decode(_ type: Bool.Type) throws -> Bool {
        return try map.decode(type)
    }
    
    func decode(_ type: Int.Type) throws -> Int {
        return try map.decode(type)
    }
    
    func decode(_ type: Int8.Type) throws -> Int8 {
        return try map.decode(type)
    }
    
    func decode(_ type: Int16.Type) throws -> Int16 {
        return try map.decode(type)
    }
    
    func decode(_ type: Int32.Type) throws -> Int32 {
        return try map.decode(type)
    }
    
    func decode(_ type: Int64.Type) throws -> Int64 {
        return try map.decode(type)
    }
    
    func decode(_ type: UInt.Type) throws -> UInt {
        return try map.decode(type)
    }
    
    func decode(_ type: UInt8.Type) throws -> UInt8 {
        return try map.decode(type)
    }
    
    func decode(_ type: UInt16.Type) throws -> UInt16 {
        return try map.decode(type)
    }
    
    func decode(_ type: UInt32.Type) throws -> UInt32 {
        return try map.decode(type)
    }
    
    func decode(_ type: UInt64.Type) throws -> UInt64 {
        return try map.decode(type)
    }
    
    func decode(_ type: Float.Type) throws -> Float {
        return try map.decode(type)
    }
    
    func decode(_ type: Double.Type) throws -> Double {
        return try map.decode(type)
    }
    
    func decode(_ type: String.Type) throws -> String {
        return try map.decode(type)
    }
    
    func decode<T : Decodable>(_ type: T.Type) throws -> T {
        return try decoder.stack.pushing(map) {
            try T(from: decoder)
        }
    }
}
