grammar TinySql;

WS          : [ \t\r\n]+ -> skip;

ID          : [a-zA-Z_][a-zA-Z_0-9-]*;

NUM         : [0-9]+;


OP          : ('=' | '<>' | '>=' | '>' | '<' | '<=');

logic       : ('and' | 'or');

where_single: ID OP NUM ;
where_multi: where_single (logic where_single)+;
where: 'where' where_multi;



select_col
    : (NUM | '\'' (ID | NUM) '\''  | ID | calc_col) ('as' ID)?
    | ID
;

select_cols
    : select_col (',' select_col)*;

calc_col:
    ID '(' (calc_col (',' calc_col)*)+ ')'
    | (ID | NUM)
    ;

group:
    'group by'
    calc_col (',' calc_col)*
    ;

select:
    'select' select_cols 'from' ID where? group?  EOF;


