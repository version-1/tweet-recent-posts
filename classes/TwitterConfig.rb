class TwitterConfig
    def initialize(yaml)
        if yaml['consumer_key'].nil? || yaml['consumer_secret'].nil? || yaml['access_token'].nil? || yaml['access_token_secret'].nil?
            raise 'invalid params'
        end
        yaml.each do |key, val|
            return nil if val.nil? || val.to_s.length < 1
            instance_variable_set('@' + key,val)
        end
    end

    def to_hash()
        result = {}
        instance_variables.each do |key , val|
            result[key.to_s.gsub(/@/,'')] = eval(key.to_s)
        end
        return result
    end
end
