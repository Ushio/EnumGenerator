#!/usr/bin/env ruby
# coding: utf-8

if ARGV.count <= 2 then
	abort("invalid argument")
end

name = ARGV[0]
enums = ARGV[1, ARGV.count - 1]

s = ""
s << "struct PLACEHOLDER {\n"
s << "    typedef enum {\n"

enums.each { |e| s << "        k" + e + ",\n" }

s << "        kIntermediate\n"

s << "    } type_t;\n"
s << "    \n"
s << "    PLACEHOLDER():_value(kIntermediate){}\n"
s << "    PLACEHOLDER(type_t value):_value(value){}\n"
s << "    \n"
s << "    operator int() const {\n"
s << "        return _value;\n"
s << "    }\n"
s << "    \n"
s << "    type_t _value;\n"
s << "    \n"

enums.each { 
	|e| 
	s << "    bool is" + e + "() const {\n"
	s << "        return _value == k" + e + ";\n"
	s << "    }\n"
	s << "    bool isNot" + e + "() const {\n"
	s << "        return _value != k" + e + ";\n"
	s << "    }\n"
}

s << "    \n"
s << "    PLACEHOLDER& operator=(type_t value) {\n"
s << "        _value = value;\n"
s << "        return *this;\n"
s << "    }\n"
s << "    \n"
s << "    bool operator ==(PLACEHOLDER other) const {\n"
s << "        return _value == other._value;\n"
s << "    }\n"
s << "    bool operator !=(PLACEHOLDER other) const {\n"
s << "        return _value != other._value;\n"
s << "    }\n"
s << "    \n"
s << "    bool isIntermediate() const {\n"
s << "        return _value == kIntermediate;\n"
s << "    }\n"
s << "    \n"
s << "    const char *toString() const {\n"
s << "        const char *strings[] = {\n"

enums.each { |e| s << "            \"k" + e + "\",\n" }

s << "            \"kIntermediate\"\n"
s << "        };\n"
s << "        return strings[_value];\n"
s << "    };\n"
s << "    \n"
s << "    friend std::ostream &operator<<( std::ostream &os, const PLACEHOLDER &me)\n"
s << "    {\n"
s << "        os << me.toString();\n"
s << "        return os;\n"
s << "    }\n"
s << "};\n"
s << "\n"

s = s.gsub("PLACEHOLDER", name);

puts(s);