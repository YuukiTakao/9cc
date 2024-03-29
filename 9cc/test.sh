#!/bin/bash
assert() {
    expected="$1"
    input="$2"

    ./9cc "$input" > tmp.s
    cc -o tmp tmp.s
    ./tmp
    actual="$?"

    if [ "$actual" = "$expected" ]; then
        echo "$input => $actual"
    else 
        echo "$input => $expected expected, but got $actual"
        exit 1;
    fi
}

assert 0 0
assert 42 42
assert 21 '10+15-6+2'
assert 41 ' 12 + 34 - 5 '
assert 47 '5+6*7'
assert 15 '5*(9-6)'
assert 4 '(3+5)/2'
assert 10 '-10+20'
assert 5 '-5-(-10)'

assert 1 '1==1'
assert 1 '10*2==2+18'
assert 0 '10 != 10'
assert 1 '1!=0'

assert 1 '0<1'
assert 0 '1 < 0'
assert 0 '10 <= -1'
assert 1 '1 <= 10'

assert 1 '1>0'
assert 0 '0-4> -1'
assert 1 '0>= -10'
assert 0 '10>= 100'



echo ok
