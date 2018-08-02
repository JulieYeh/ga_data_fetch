# 計算資料量

- 資料區間: 2018-06-01 ~ 2018-06-30
- `for f in *.csv; do echo "$f"", "$(awk -F, 'END {printf "%s, %s\n", NR, NF}' "$f") >> /tmp/result.csv; done`

