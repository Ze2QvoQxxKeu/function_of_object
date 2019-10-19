program demo;

{$APPTYPE CONSOLE}

uses
  ufoo1 in 'ufoo1.pas',
  ufoo2 in 'ufoo2.pas',
  ufoo3 in 'ufoo3.pas',
  ufoo4 in 'ufoo4.pas';

begin
  ufoo1.test;
  ufoo2.test;
  ufoo3.test;
  ufoo4.test;
  Readln;
end.

