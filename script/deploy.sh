#!/bin/bash
echo "hello world"

#!/bin/bash
while read line; do
  echo "读取行: $line"
done < ../.env
