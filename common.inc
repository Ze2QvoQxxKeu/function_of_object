uses
  System.SysUtils,
  System.RegularExpressions;
  
type
  TMatchEvaluatorRef = reference to function(const Match: TMatch): string;

const
  TEXT = '1A3c56D89e11';
  PATTERN = '[a-f]{1}';