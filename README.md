# csv-libsonnet

Jsonnet library to parse CSV files.

It parses files according to [RFC4180](https://datatracker.ietf.org/doc/html/rfc4180). It also accepts LF as line breaks and the TEXTDATA is as liberal as Jsonnet can be.

Tested with test suite from [max-mapper/csv-spectrum](https://github.com/max-mapper/csv-spectrum) and [sineemore/csv-test-data](https://github.com/sineemore/csv-test-data), passing a total of 29 test cases.

## Usage

```
local parser = import 'github.com/Duologic/csv-libsonnet/main.libsonnet';
local csv = importstr 'path/to/your.csv';

parser.parse(csv) // with headers, returns an object for each record
parser.parseRecords(csv) // without headers, returns an array for each record
```
