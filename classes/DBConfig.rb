class DBConfig
    def initialize(yaml)
        if yaml['host'].nil? || yaml['username'].nil? || yaml['password'].nil? || yaml['database'].nil?
            raise 'invalid params'
        end
        yaml.each do |key, val|
            return nil if val.nil? || val.to_s.length < 1
            instance_variable_set('@' + key,val)
        end
    end

    def host()
        return @host
    end
    def user()
        return @username
    end
    def password()
        return @password
    end
    def database()
        return @database
    end

    def to_hash()
        result = {}
        instance_variables.each do |key , val|
            result[key.to_s.gsub(/@/,'')] = eval(key.to_s)
        end
        return result
    end
end
