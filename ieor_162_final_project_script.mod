set CityNames; 
set CityNamesMinusOne; 
param longitude{CityNames};
param latitude{CityNames};

param PI := 3.141592653589793;
param DEG_RAD_RATIO := PI / 180;

param Distances{i in CityNames, j in CityNames: i<>j} := 
	3958.8 * acos(cos(latitude[i]*DEG_RAD_RATIO) * cos(latitude[j]*DEG_RAD_RATIO) * 
	cos(longitude[j]*DEG_RAD_RATIO - longitude[i] * DEG_RAD_RATIO) + 
	sin(latitude[i]*DEG_RAD_RATIO) * sin(latitude[j]*DEG_RAD_RATIO));

var X{i in CityNames, j in CityNames: i<>j} binary;
var U{i in CityNames} >=0 integer;
var x1 binary;
var x2 binary;
var x3 binary;
var x4 binary;
var x5 binary;
var x6 binary;
var x7 binary;
var x8 binary;
var x9 binary;
var x10 binary;
var x11 binary;
var x12 binary;
var x13 binary;
var x14 binary;
var x15 binary;
var x16 binary;

minimize Cost: 
	sum{i in CityNames, j in CityNames: i<>j} Distances[i,j] * X[i,j];

subject to
	EnterOnlyOnce{i in CityNames}: sum{j in CityNames: i<>j} X[i,j] = 1;
	ExitOnlyOnce{j in CityNames}: sum{i in CityNames: i<>j} X[i,j] = 1;
	NoSubTours{i in CityNamesMinusOne, j in CityNamesMinusOne: i<>j}: U[i] - U[j] + 22 * X[i,j] <= 21;
	Cond1: U["city9"] >= 7;
	Cond2: U["city18"] >= 0 - 1000 * (1 - x1);
	Cond3: U["city18"] <= 6 + 1000 * (1 - x1);
	Cond4: U["city18"] >= 17 - 1000 * (1 - x2);
	Cond5: U["city18"] >= 21 - 1000 * (1 - x2);
	Cond6: x1 + x2 = 1;
	Cond7: U["city6"] - U["city17"] >= 2 - 1000 * (1 - x3);
	Cond8: U["city6"] - U["city17"] <= -2 + 1000 * (1 - x4);
	Cond9: x3 + x4 = 1;
	Cond10: U["city6"] - U["city20"] >= 2 - 1000 * (1 - x5);
	Cond11: U["city6"] - U["city20"] <= -2 + 1000 * (1 - x6);
	Cond12: x5 + x6 = 1;
	Cond13: U["city17"] - U["city20"] >= 2 - 1000 * (1 - x7);
	Cond14: U["city17"] - U["city20"] <= -2 + 1000 * (1 - x8);
	Cond15: x7 + x8 = 1;
	Cond16: U["city7"] - U["city14"] >= 2 - 1000 * (1 - x9);
	Cond17: U["city7"] - U["city14"] <= -2 + 1000 * (1 - x10);
	Cond18: x9 + x10 = 1;
	Cond19: U["city1"] = 0;
	Cond20: U["city22"] = 21;
	Cond21: U["city5"] - U["city4"] >= 1 - 1000 * (1 - x11);
	Cond22: U["city7"] - U["city14"] <= 1 + 1000 * (1 - x11);
	Cond23: U["city5"] - U["city4"] >= -1 - 1000 * (1 - x12);
	Cond24: U["city7"] - U["city14"] <= -1 + 1000 * (1 - x12);
	Cond25: 2 - x11 - x12 = 1;
	Cond26: U["city8"] <= 10 + 1000 * (1 - x13);
	Cond27: U["city19"] >= 11 * x13;
	Cond28: U["city2"] <= 10 + 1000 * (1 - x14);
	Cond29: U["city21"] <= 10 + 1000 * (1 - x15);
	Cond30: x14 + x15 >= 1;
	

data tsp3.dat;

solve;