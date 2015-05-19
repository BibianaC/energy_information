# Energy Information

## Task

Given the PowerGenByFuelType XML file (standard file for the energy industry) showing the amount of power generated by different types of generation and the FuelTypeKeys text file describing the keys in the first XML file.

The challenge is to produce a single web page which will allow a user to lookup a date and a settlement period, then view a report of how much energy was produced by the following class of fuel type, both the absolute values and the percentage of total generation that fuel type accounts for.

• Coal
• Gas
• Oil
• Hydroelectric
• Nuclear
• Wind
• Interconnect

The last one, “interconnect", are the cables which run into Britain from other countries; the others are better known. In the XML the data is actually more granular than this list of fuel type and time period, so the data will need some modification.

It doesn't matter how this website is laid out. The core feature is to choose a day and settlement period and see the data.

Note: the industry splits the day into 48 half-hourly periods called settlement periods, and most data revolves around this level of detail. 

Suggestion: use a script to translate the XML into a JSON file which is more appropriate to the needs of the web front end; then have JS read this file and display data. Use whatever technology you wish to perform this data enrichment.