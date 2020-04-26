# antlr-demo
antlr parser 解析 airflow 任务信息
```
grammar DagParser;

WS          : [ \t\r]+ -> skip;
ID          : [a-zA-Z_][a-zA-Z_0-9-]*;
NL          : '\n';

OPVALUE1    : '\'' ID  '\'' ;
OPVALUE2    : '"'  ID  '"' ;
DAGV        : [@a-zA-Z_][a-zA-Z0-9_]*;



attr_v      : (OPVALUE1 | OPVALUE2 | DAGV |  '\'' DAGV  '\'' );

domain : 'Operator';

arr    : '[' attr_v (',' attr_v)*  ']';

attr_pair    : ID '=' (attr_v | arr);

kv_multi   : attr_pair (',' NL? attr_pair)*;


dag  :  ID '=' 'DAG' NL?  '(' NL? attr_v (',' kv_multi)* NL? ')' ;

task : ID '=' domain NL?  '(' NL? kv_multi NL? ')';

item: (dag  | task);


input
    :
    input NL*  item  #mulit
    | NL* item NL*  #line
    ;
```
