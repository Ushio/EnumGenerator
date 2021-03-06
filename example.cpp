#include <iostream>

struct EnumName {
    typedef enum {
        kValueA,
        kValueB,
        kValueC,
        kIntermediate
    } type_t;
    
    EnumName():_value(kIntermediate){}
    EnumName(type_t value):_value(value){}
    
    operator int() const {
        return _value;
    }
    
    type_t _value;
    
    bool isValueA() const {
        return _value == kValueA;
    }
    bool isNotValueA() const {
        return _value != kValueA;
    }
    bool isValueB() const {
        return _value == kValueB;
    }
    bool isNotValueB() const {
        return _value != kValueB;
    }
    bool isValueC() const {
        return _value == kValueC;
    }
    bool isNotValueC() const {
        return _value != kValueC;
    }
    
    EnumName& operator=(type_t value) {
        _value = value;
        return *this;
    }
    
    bool operator ==(EnumName other) const {
        return _value == other._value;
    }
    bool operator !=(EnumName other) const {
        return _value != other._value;
    }
    
    bool isIntermediate() const {
        return _value == kIntermediate;
    }
    
    const char *toString() const {
        const char *strings[] = {
            "kValueA",
            "kValueB",
            "kValueC",
            "kIntermediate"
        };
        return strings[_value];
    };
    
    friend std::ostream &operator<<( std::ostream &os, const EnumName &me)
    {
        os << me.toString();
        return os;
    }
};

int main(int argc, const char * argv[]) {
    EnumName intermediate;
    EnumName valueA = EnumName::kValueA;
    EnumName valueB;
    valueB = EnumName::kValueB;
    
    printf("%s\n", intermediate.toString());
    std::cout << valueA << std::endl;
    std::cout << valueB << std::endl;
    std::cout << (int)valueB << std::endl;
    
    return 0;
}
