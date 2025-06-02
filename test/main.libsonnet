local csv = import '../main.libsonnet';
local test = import 'github.com/jsonnet-libs/testonnet/main.libsonnet';

local csvs = {
  // max-mapper cases
  header_comma_in_quotes: importstr 'github.com/max-mapper/csv-spectrum/csvs/comma_in_quotes.csv',
  header_empty: importstr 'github.com/max-mapper/csv-spectrum/csvs/empty.csv',
  header_empty_crlf: importstr 'github.com/max-mapper/csv-spectrum/csvs/empty_crlf.csv',
  header_escaped_quotes: importstr 'github.com/max-mapper/csv-spectrum/csvs/escaped_quotes.csv',
  header_json: importstr 'github.com/max-mapper/csv-spectrum/csvs/json.csv',
  header_newlines: importstr 'github.com/max-mapper/csv-spectrum/csvs/newlines.csv',
  header_newlines_crlf: importstr 'github.com/max-mapper/csv-spectrum/csvs/newlines_crlf.csv',
  header_quotes_and_newlines: importstr 'github.com/max-mapper/csv-spectrum/csvs/quotes_and_newlines.csv',
  header_simple: importstr 'github.com/max-mapper/csv-spectrum/csvs/simple.csv',
  header_simple_crlf: importstr 'github.com/max-mapper/csv-spectrum/csvs/simple_crlf.csv',
  header_utf8: importstr 'github.com/max-mapper/csv-spectrum/csvs/utf8.csv',

  // NOTE: parsed correctly but upstream test case is faulty
  //header_location_coordinates: importstr 'github.com/max-mapper/csv-spectrum/csvs/location_coordinates.csv',

  // sineemore cases
  'all-empty': importstr 'github.com/sineemore/csv-test-data/csv/all-empty.csv',
  'empty-field': importstr 'github.com/sineemore/csv-test-data/csv/empty-field.csv',
  'empty-one-column': importstr 'github.com/sineemore/csv-test-data/csv/empty-one-column.csv',
  'header-no-rows': importstr 'github.com/sineemore/csv-test-data/csv/header-no-rows.csv',
  'header-simple': importstr 'github.com/sineemore/csv-test-data/csv/header-simple.csv',
  'leading-space': importstr 'github.com/sineemore/csv-test-data/csv/leading-space.csv',
  'one-column': importstr 'github.com/sineemore/csv-test-data/csv/one-column.csv',
  'quotes-empty': importstr 'github.com/sineemore/csv-test-data/csv/quotes-empty.csv',
  'quotes-with-comma': importstr 'github.com/sineemore/csv-test-data/csv/quotes-with-comma.csv',
  'quotes-with-escaped-quote': importstr 'github.com/sineemore/csv-test-data/csv/quotes-with-escaped-quote.csv',
  'quotes-with-newline': importstr 'github.com/sineemore/csv-test-data/csv/quotes-with-newline.csv',
  'quotes-with-space': importstr 'github.com/sineemore/csv-test-data/csv/quotes-with-space.csv',
  'simple-crlf': importstr 'github.com/sineemore/csv-test-data/csv/simple-crlf.csv',
  'simple-lf': importstr 'github.com/sineemore/csv-test-data/csv/simple-lf.csv',
  'trailing-newline': importstr 'github.com/sineemore/csv-test-data/csv/trailing-newline.csv',
  'trailing-newline-one-field': importstr 'github.com/sineemore/csv-test-data/csv/trailing-newline-one-field.csv',
  'trailing-space': importstr 'github.com/sineemore/csv-test-data/csv/trailing-space.csv',
  'utf8-sineemore': importstr 'github.com/sineemore/csv-test-data/csv/utf8.csv',

  //'bad-header-less-fields': importstr 'github.com/sineemore/csv-test-data/csv/bad-header-less-fields.csv',
  //'bad-header-more-fields': importstr 'github.com/sineemore/csv-test-data/csv/bad-header-more-fields.csv',
  //'bad-header-no-header': importstr 'github.com/sineemore/csv-test-data/csv/bad-header-no-header.csv',
  //'bad-header-wrong-header': importstr 'github.com/sineemore/csv-test-data/csv/bad-header-wrong-header.csv',
  //'bad-missing-quote': importstr 'github.com/sineemore/csv-test-data/csv/bad-missing-quote.csv',
  //'bad-quotes-with-unescaped-quote': importstr 'github.com/sineemore/csv-test-data/csv/bad-quotes-with-unescaped-quote.csv',
  //'bad-unescaped-quote': importstr 'github.com/sineemore/csv-test-data/csv/bad-unescaped-quote.csv',
};
local json = {
  // max-mapper cases
  header_comma_in_quotes: import 'github.com/max-mapper/csv-spectrum/json/comma_in_quotes.json',
  header_empty: import 'github.com/max-mapper/csv-spectrum/json/empty.json',
  header_empty_crlf: import 'github.com/max-mapper/csv-spectrum/json/empty_crlf.json',
  header_escaped_quotes: import 'github.com/max-mapper/csv-spectrum/json/escaped_quotes.json',
  header_json: import 'github.com/max-mapper/csv-spectrum/json/json.json',
  header_newlines: import 'github.com/max-mapper/csv-spectrum/json/newlines.json',
  header_newlines_crlf: import 'github.com/max-mapper/csv-spectrum/json/newlines_crlf.json',
  header_quotes_and_newlines: import 'github.com/max-mapper/csv-spectrum/json/quotes_and_newlines.json',
  header_simple: import 'github.com/max-mapper/csv-spectrum/json/simple.json',
  header_simple_crlf: import 'github.com/max-mapper/csv-spectrum/json/simple_crlf.json',
  header_utf8: import 'github.com/max-mapper/csv-spectrum/json/utf8.json',

  header_location_coordinates: [import 'github.com/max-mapper/csv-spectrum/json/location_coordinates.json'],

  // sineemore cases
  'all-empty': import 'github.com/sineemore/csv-test-data/json/all-empty.json',
  'empty-field': import 'github.com/sineemore/csv-test-data/json/empty-field.json',
  'empty-one-column': import 'github.com/sineemore/csv-test-data/json/empty-one-column.json',
  'header-no-rows': import 'github.com/sineemore/csv-test-data/json/header-no-rows.json',
  'header-simple': import 'github.com/sineemore/csv-test-data/json/header-simple.json',
  'leading-space': import 'github.com/sineemore/csv-test-data/json/leading-space.json',
  'one-column': import 'github.com/sineemore/csv-test-data/json/one-column.json',
  'quotes-empty': import 'github.com/sineemore/csv-test-data/json/quotes-empty.json',
  'quotes-with-comma': import 'github.com/sineemore/csv-test-data/json/quotes-with-comma.json',
  'quotes-with-escaped-quote': import 'github.com/sineemore/csv-test-data/json/quotes-with-escaped-quote.json',
  'quotes-with-newline': import 'github.com/sineemore/csv-test-data/json/quotes-with-newline.json',
  'quotes-with-space': import 'github.com/sineemore/csv-test-data/json/quotes-with-space.json',
  'simple-crlf': import 'github.com/sineemore/csv-test-data/json/simple-crlf.json',
  'simple-lf': import 'github.com/sineemore/csv-test-data/json/simple-lf.json',
  'trailing-newline': import 'github.com/sineemore/csv-test-data/json/trailing-newline.json',
  'trailing-newline-one-field': import 'github.com/sineemore/csv-test-data/json/trailing-newline-one-field.json',
  'trailing-space': import 'github.com/sineemore/csv-test-data/json/trailing-space.json',
  'utf8-sineemore': import 'github.com/sineemore/csv-test-data/json/utf8.json',
};


test.new(std.thisFile)
+ std.foldl(
  function(acc, item)
    assert std.trace('Testing ' + item.key, true);
    acc + test.case.new(
      name=item.key,
      test=test.expect.eq(
        actual=(
          if std.startsWith(item.key, 'header')
          then csv.parse(item.value)
          else csv.lines(item.value)
        ),
        expected=json[item.key]
      )
    ),
  std.objectKeysValues(csvs),
  {}
)
