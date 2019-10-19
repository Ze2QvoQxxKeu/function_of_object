unit ufoo3;
{Рабочий, удобный, лучший по синтаксису вариант.
НО адрес функции обработчика затрётся, если одновременно работать
с классом из нескольких потоков.
Также думаю, что при использовании этого может быть утечка памяти}
interface

procedure test;

implementation

{$INCLUDE common.inc}

type
  TFakeClass = class
    class var FEvent: TMatchEvaluatorRef;
    class function Event(const Match: TMatch): string;
    class function Proc(E: TMatchEvaluatorRef): TFakeClass;
  end;

class function TFakeClass.Event(const Match: TMatch): string;
begin
  Result := FEvent(Match);
end;

class function TFakeClass.Proc(E: TMatchEvaluatorRef): TFakeClass;
begin
  FEvent := E;
end;

procedure test;
begin
  WriteLn('ufoo3> ', TRegEx.Replace(TEXT, PATTERN,
    TFakeClass.Proc(
      function(const Match: TMatch): string
      begin
        Result := Format('%d', [Match.Index]);
      end
    ).Event,
    [roIgnoreCase]));
end;

end.
