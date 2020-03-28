#define CONSTVAR(var) var = compileFinal (if(var isEqualType "") then {var} else {str(var)})
#define EQUAL(condition1,condition2) condition1 isEqualTo condition2
#define FETCH_CONST(var) (call var)
#define SEL(ARRAY,INDEX) (ARRAY select INDEX)
#define EXTDB "extDB3" callExtension
#define CONST(var1,var2) var1 = compileFinal (if(var2 isEqualType "") then {var2} else {str(var2)})

//Condition Macros
#define KINDOF_ARRAY(a,b) [##a,##b] call {_veh = _this select 0;_types = _this select 1;_res = false; {if (_veh isKindOf _x) exitWith { _res = true };} forEach _types;_res}

//Config Macros
#define FETCH_CONFIG(TYPE,CFG,SECTION,CLASS,ENTRY) TYPE(configFile >> CFG >> SECTION >> CLASS >> ENTRY)
#define FETCH_CONFIG2(TYPE,CFG,CLASS,ENTRY) TYPE(configFile >> CFG >> CLASS >> ENTRY)