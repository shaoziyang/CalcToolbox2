const

  NewFileTemplate_Pascal:array of string = (
    'blank',
    '',

    'write/writeln',
    'program Hello;'+#13#10+
    'begin'+#13#10+
    '  write([''>>> 1+2 ='', 1+2, ''|'']);'+#13#10+
    '  writeln([''Hello'']);'+#13#10+
    'end.',

    'read',
    'program Read;'+#13#10+
    'begin'+#13#10+
    '  writeln([''your name is:'', read(''Input your name:'')]);'+#13#10+
    'end.',

    'clear',
    'program ClearOutput;'+#13#10+
    'begin'+#13#10+
    '  clear;'+#13#10+
    'end.',

    '-',
    '-',

    'format',
    'var'+#13#10+
    '  s: string;'+#13#10+
    'begin'+#13#10+
    '  s := format(''(%5d) (%-5d) (%.05d)'',[12,3,4]);'+#13#10+
    '  writeln([s]);'+#13#10+
    'end.',

    'Time',
    'begin'+#13#10+
    '  writeln([Now, '','', Date(), '','', DateToStr(Now-1000)]);'+#13#10+
    'end.',

    'math',
    'program Hello;'+#13#10+
    'begin'+#13#10+
    '  writeln([''12*34 = '', 12*34]);'+#13#10+
    '  writeln([''ln(2) = '', ln(2)]);'+#13#10+
    '  writeln([''log2(2) = '', log2(2)]);'+#13#10+
    '  writeln([''log10(2) = '', log10(2)]);'+#13#10+
    '  writeln([''logN(3, 2) = '', logN(3, 2)]);'+#13#10+
    '  writeln([''exp(2) = '', exp(2)]);'+#13#10+
    '  writeln([''sin(1) = '', sin(1)]);'+#13#10+
    '  writeln([''cos(60*pi/180) = '', cos(60*pi/180)]);'+#13#10+
    '  writeln([''tan(45*pi/180) = '', tan(45*pi/180)]);'+#13#10+
    '  writeln([''arcsin(0.5) = '', arcsin(0.5)]);'+#13#10+
    '  writeln([''arccos(0.3) = '', arccos(0.3)]);'+#13#10+
    '  writeln([''arctan(1) = '', arctan(1)]);'+#13#10+
    '  writeln([''sinh(0.5) = '', sinh(0.5)]);'+#13#10+
    '  writeln([''cosh(0.5) = '', cosh(0.5)]);'+#13#10+
    '  writeln([''tanh(1) = '', tanh(1)]);'+#13#10+
    '  writeln([''power(3,5) = '', power(3, 5)]);'+#13#10+
    '  writeln([''sqrt(5) = '', sqrt(5)]);'+#13#10+
    '  writeln([''floor(2.6) = '', floor(2.6)]);'+#13#10+
    '  writeln([''ceil(-3.2) = '', ceil(-3.2)]);'+#13#10+
    '  writeln([''Round(2.6) = '', Round(2.6)]);'+#13#10+
    'end.',

    'random',
    'var'+#13#10+
    '  i: integer;'+#13#10+
    'begin'+#13#10+
    '  for i:=1 to 5 do'+#13#10+
    '  begin'+#13#10+
    '    writeln([i, '': '', random, '', '', RandomRange(1,100)]);'+#13#10+
    '  end;'+#13#10+
    'end.',

    'beep/sleep',
    'program BeepSleep;'+#13#10+
    'var'+#13#10+
    '  i: integer;'+#13#10+
    'begin'+#13#10+
    '  for i:=1 to 3 do'+#13#10+
    '  begin'+#13#10+
    '    beep;'+#13#10+
    '    sleep(500);'+#13#10+
    '  end;'+#13#10+
    'end.'
  );

  NewFileTemplate_Graph:array of string = (
    'blank',
    ''
  );

  NewFileTemplate_LittleC:array of string = (
    'blank',
    '',

    'hello',
    '#include "stdio.h"'+#13#10+
    'void main() {'+#13#10+
    'printf("Hello world!");'+#13#10+
    '}',

    'sleep',
    '#include <stdio.h>'+#13#10+
    '#include <stdlib.h>'+#13#10#13#10+
    'void main() {'+#13#10+
    'int i;'+#13#10#13#10+
    '  for(i = 0; i < 5; i++) {'+#13#10+
    '    printf("%d ", i);'+#13#10+
    '    _sleep(100);'+#13#10+
    '  }'+#13#10+
    '  _beep(1000,200);'+#13#10+
    '}',

    'time',
    '#include <stdio.h>'+#13#10+
    '#include <time.h>'+#13#10#13#10+
    'int main ()'+#13#10+
    '{'+#13#10+
    '  time_t seconds;'+#13#10#13#10+
    '  seconds = time(NULL);'+#13#10+
    '  printf("second from 1970: %ld\n", seconds);'+#13#10#13#10+
    '  return(0);'+#13#10+
    '}',

    '-',
    '',

    'pi',
    '#include "stdio.h"'+#13#10+
    'long a=10000, b, c=2800, d, e, f[2801], g;'+#13#10+
    'void main() {'+#13#10+
    'for( ;b-c; ) f[b++] =a/5;'+#13#10+
    'for( ; d=0, g=c*2; c-=14,printf("%.4d",e+d/a),e=d%a)'+#13#10+
    'for(b=c; d+=f[b]*a,f[b] =d%--g,d/=g--,--b; d*=b) ;'+#13#10+
    '}'

  );

  NewFileTemplate_MPY: array of string = (
  'blank',
  '',

  'print',
  'print("Hello")',

  'math',
  'from math import *'+#13#10+
  'print(sin(0.1), sqrt(2), log(5))',

  'time',
  'import time' + #13#10 +
  'for i in range(10):' + #13#10 +
  '    print(i)' + #13#10 +
  '    time.sleep(1)',

  'pi',
  'def pi(places=100):'+#13#10+
  '    # 3 + 3*(1/24) + 3*(1/24)*(9/80) + 3*(1/24)*(9/80)*(25/168)' + #13#10 +
  '    # The numerators 1, 9, 25, ... are given by (2x + 1) ^ 2' + #13#10 +
  '    # The denominators 24, 80, 168 are given by (16x^2 -24x + 8)' + #13#10 +
  '    extra = 8' + #13#10 +
  '    one = 10 ** (places+extra)' + #13#10 +
  '    t, c, n, na, d, da = 3*one, 3*one, 1, 0, 0, 24' + #13#10 +
  '    ' + #13#10 +
  '    while t > 1:' + #13#10 +
  '        n, na, d, da = n+na, na+8, d+da, da+32' + #13#10 +
  '        t = t * n // d' + #13#10 +
  '        c += t' + #13#10 +
  '    return c // (10 ** extra)' + #13#10 +
  'print(pi(1000))',

  'Fibonacci series',
  'def fib(n):' + #13#10 +
  '    a, b = 0, 1' + #13#10 +
  '    while a < n:' + #13#10 +
  '        print(a, end=" ")' + #13#10 +
  '        a, b = b, a+b' + #13#10 +
  'fib(1000)'

  );

