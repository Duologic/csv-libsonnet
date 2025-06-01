local csv = import '../main.libsonnet';
local test = import 'github.com/jsonnet-libs/testonnet/main.libsonnet';

local csvs = {
  comma_in_quotes: importstr 'github.com/max-mapper/csv-spectrum/csvs/comma_in_quotes.csv',
  empty: importstr 'github.com/max-mapper/csv-spectrum/csvs/empty.csv',
  empty_crlf: importstr 'github.com/max-mapper/csv-spectrum/csvs/empty_crlf.csv',
  escaped_quotes: importstr 'github.com/max-mapper/csv-spectrum/csvs/escaped_quotes.csv',
  json: importstr 'github.com/max-mapper/csv-spectrum/csvs/json.csv',
  newlines: importstr 'github.com/max-mapper/csv-spectrum/csvs/newlines.csv',
  newlines_crlf: importstr 'github.com/max-mapper/csv-spectrum/csvs/newlines_crlf.csv',
  quotes_and_newlines: importstr 'github.com/max-mapper/csv-spectrum/csvs/quotes_and_newlines.csv',
  simple: importstr 'github.com/max-mapper/csv-spectrum/csvs/simple.csv',
  simple_crlf: importstr 'github.com/max-mapper/csv-spectrum/csvs/simple_crlf.csv',
  utf8: importstr 'github.com/max-mapper/csv-spectrum/csvs/utf8.csv',

  // NOTE: parsed correctly but upstream test case is faulty
  //location_coordinates: importstr 'github.com/max-mapper/csv-spectrum/csvs/location_coordinates.csv',
};
local json = {
  comma_in_quotes: import 'github.com/max-mapper/csv-spectrum/json/comma_in_quotes.json',
  empty: import 'github.com/max-mapper/csv-spectrum/json/empty.json',
  empty_crlf: import 'github.com/max-mapper/csv-spectrum/json/empty_crlf.json',
  escaped_quotes: import 'github.com/max-mapper/csv-spectrum/json/escaped_quotes.json',
  json: import 'github.com/max-mapper/csv-spectrum/json/json.json',
  newlines: import 'github.com/max-mapper/csv-spectrum/json/newlines.json',
  newlines_crlf: import 'github.com/max-mapper/csv-spectrum/json/newlines_crlf.json',
  quotes_and_newlines: import 'github.com/max-mapper/csv-spectrum/json/quotes_and_newlines.json',
  simple: import 'github.com/max-mapper/csv-spectrum/json/simple.json',
  simple_crlf: import 'github.com/max-mapper/csv-spectrum/json/simple_crlf.json',
  utf8: import 'github.com/max-mapper/csv-spectrum/json/utf8.json',

  location_coordinates: [import 'github.com/max-mapper/csv-spectrum/json/location_coordinates.json'],
};


test.new(std.thisFile)
+ std.foldl(
  function(acc, item)
    assert std.trace('Testing ' + item.key, true);
    acc + test.case.new(
      name=item.key,
      test=test.expect.eq(
        actual=csv.parse(item.value),
        expected=json[item.key]
      )
    ),
  std.objectKeysValues(csvs),
  {}
)
