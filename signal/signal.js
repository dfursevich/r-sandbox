var intervals = [1, 2];
var data = []; //persisted data frame

var results = {};

for (i in intervals) {
  var interval = intervals[i];

  var signals = generateSignals(data, interval)

  var testIntervals = generateTestIntervals(interval);

  for (k in testIntervals) {
    var testInterval = testIntervals[k];

    testSignals(signals, testInterval);
  }

  //persist signals data frame
  var intervalResults = processSignals(signals);

  results[interval] = intervalResults;
}

function generateSignals(data, interval) {
  var signals = [];
  for (j in data) {
     var row = date[j];
     var signal = generateSignal(row, interval);
     signals.push(signal);
  }
  return signals;
}

function generateSignal(row, interval) {
  return {
    date: new Date(),
    currency: "eurusd", //currency pair
    action: "buy", //sell/buy
    power: 1 //signal power from the more value the stronger signal
  };
}

function generateTestIntervals(interval) {
  return intervals;
}

function testSignals(signals, testInterval) {
  for (j in signals) {
     var signal = signals[j];
     signal[testInterval] = testSignal(signal, testInterval);
  }
}

function testSignal(signal, testInterval) {
  return 1; //profit/loss positive/negative
}

function processSignals(results) {
  //Find best interval/testInterval/power pairs based on total sum of profit/loss
  //power, step e.g. 0.1
  return {}
}