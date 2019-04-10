with [
{name:"september", index:9},
{name:"october", index:10},
{name:"november", index:11},
{name:"december", index:12},
{name:"january", index:1},
{name:"february", index:2},
{name:"march", index:3},
{name:"april", index:4},
{name:"may", index:5},
{name:"june", index:6},
{name:"july", index:7},
{name:"august", index:8}
] as monthlst
unwind monthlst as item
merge(m:C_month {identifier:item.name})
set m += item
set m.type="C_month"
return properties(m)
