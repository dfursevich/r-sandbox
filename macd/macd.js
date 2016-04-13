var intervals = [1, 5]; //minutes

var data = {
	/*currency: [price]*/
	eurjpy:[...],
	usdjpy:[...],
	...
} 

//calculate MACD(moving average) from data
var macd = {
	/*currency: [macd]*/
	eurjpy:[...],
	usdjpy:[...],
	...
}

var macdResutlts = testMacd(macd.eurjpy, interval[0]); 
var macdResutlts = testMacd(macd.eurjpy, intervals);
var allMacdResutlts = testAllMacd(macd, interval[0]);

var macdResutlts = {
	/*interval: [test result value for specified currency]*/
	1: [...],
	5: [...],
    ...
}

var allMacdResutlts = { 
	/*currency: [test result value for specified interval]*/
	eurjpy:[...],
	usdjpy:[...],
	...
}