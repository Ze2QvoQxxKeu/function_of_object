unit ufoo1;
{Самый очевидный вариант}
interface

procedure test;

implementation

{$INCLUDE common.inc}

type
  TFakeClass = object
    class function Event(const Match: TMatch): string;
  end;

class function TFakeClass.Event(const Match: TMatch): string;
begin
  Result := Format('%d', [Match.Index]);
end;

procedure test;
begin
  WriteLn('ufoo1> ', TRegEx.Replace(TEXT, PATTERN, TFakeClass.Event, [roIgnoreCase]));
end;

end.
