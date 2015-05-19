require 'rexml/document'
require 'json/ext'

# Some fuel types belong to the same category,
# we aggregate values per category.

categories = {
  "CCGT" => "Gas",
  "OCGT" => "Gas",
  "OIL" => "Oil",
  "COAL" => "Coal",
  "NUCLEAR" => "Nuclear",
  "WIND" => "Wind",
  "PS" => "Other",
  "OTHER" => "Other",
  "NPSHYD" => "Hydroelectric",
  "INTFR" => "IC",
  "INTIRL" => "IC",
  "INTNED" => "IC",
  "INTEW" => "IC"
}

# Multi-nested hash: date -> sp -> fuel category -> fuel value sum.
nested_hash = Hash.new

doc = REXML::Document.new File.new("PowerGenByFuelType.xml")
doc.elements.each("HIST_FUELINST/INST") do |inst|
  inst.elements.each do |fuel|
    fuel_type = fuel.attributes["TYPE"].to_s
    fuel_value = fuel.attributes["VAL"].to_i
    date_hour = inst.attributes["AT"]
    date = inst.attributes["SD"]
    sp = inst.attributes["SP"]

    fuel_category = categories[fuel_type]
    if fuel_category.nil?
        puts "Skipping FUEL tag with unknown type #{fuel_type}"
        next
    end

    if !nested_hash.has_key?(date)
        nested_hash[date] = Hash.new
    end

    sp_hash = nested_hash[date]
    if !sp_hash.has_key?(sp)
        sp_hash[sp] = Hash.new
    end

    # The date is already stored at the top-level hash, 
    # here we only keep the time component.
    sp_hash[sp]['time'] = date_hour[12, date_hour.length-1]

    fuel_category_hash = sp_hash[sp]
    if !fuel_category_hash.has_key?(fuel_category)
        fuel_category_hash[fuel_category] = 0
    end

    fuel_category_hash[fuel_category] += fuel_value
  end
end

puts nested_hash.to_json