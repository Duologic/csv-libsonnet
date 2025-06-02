# csv-libsonnet

Jsonnet library to parse CSV files.

Tested with test suite from [max-mapper/csv-spectrum](https://github.com/max-mapper/csv-spectrum) and [sineemore/csv-test-data](https://github.com/sineemore/csv-test-data), passing a total of 29 test cases.

## Usage

```
local parser = import 'github.com/Duologic/csv-libsonnet/main.libsonnet';
local csv = importstr 'path/to/your.csv';

parser.parse(csv)
```
