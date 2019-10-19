unit ufoo2;
{Рабочий, но неудобный вариант}
interface

procedure test;

implementation

{$INCLUDE common.inc}

type
  TFakeClass = class
    FEvent: TMatchEvaluatorRef;
    function Event(const Match: TMatch): string;
  end;

function TFakeClass.Event(const Match: TMatch): string;
begin
  Result := FEvent(Match);
end;

procedure test;
begin
  with TFakeClass.Create do
  try
    FEvent :=
      function(const Match: TMatch): string
      begin
        Result := Format('%d', [Match.Index]);
      end;
    WriteLn('ufoo2> ', TRegEx.Replace(TEXT, PATTERN,
      Event,
      [roIgnoreCase]));
  finally
    Free;
  end;
end;

end.
