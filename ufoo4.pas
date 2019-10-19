unit ufoo4;
{Сбоить не будет, память освобождается, удобно, но длинно}
interface

procedure test;

implementation

{$INCLUDE common.inc}

type
  TFakeClass = class
    FEvent: TMatchEvaluatorRef;
    constructor Create(E: TMatchEvaluatorRef); overload;
    function Event(const Match: TMatch): string;
    function Proc(E: TMatchEvaluatorRef): TFakeClass;
  end;

function TFakeClass.Event(const Match: TMatch): string;
begin
  Result := FEvent(Match);
end;

function TFakeClass.Proc(E: TMatchEvaluatorRef): TFakeClass;
begin
  FEvent := E;
  Result := Self;
end;

constructor TFakeClass.Create(E: TMatchEvaluatorRef);
begin
  FEvent := E;
end;

procedure init_create;
begin
  with TFakeClass.Create(
    function(const Match: TMatch): string
    begin
      Result := Format('%d', [Match.Index]);
    end
  ) do
  try
    Writeln('ufoo4.1> ', TRegEx.Replace(TEXT, PATTERN,
      Event,
      [roIgnoreCase]));
  finally
    Free;
  end;
end;

procedure init_proc;
begin
  with TFakeClass.Create do
  try
    Writeln('ufoo4.2> ', TRegEx.Replace(TEXT, PATTERN,
      Proc(
        function(const Match: TMatch): string
        begin
          Result := Format('%d', [Match.Index]);
        end
      ).Event,
      [roIgnoreCase]));
  finally
    Free;
  end;
end;

procedure test;
begin
  init_create;
  init_proc;
end;

end.

