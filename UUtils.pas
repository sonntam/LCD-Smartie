unit UUtils;

interface
  function errMsg(uError: Cardinal): String;
  function decodeArgs(str: String; funcName: String; maxargs: Cardinal; var
      args: Array of String; var prefix: String; var postfix: String; var
      numArgs: Cardinal): Boolean;

implementation

uses Windows, SysUtils;

function errMsg(uError: Cardinal): String;
var
  psError: pointer;
  sError: String;
begin
  if (uError <> 0) then
  begin
    FormatMessage( FORMAT_MESSAGE_ALLOCATE_BUFFER or FORMAT_MESSAGE_FROM_SYSTEM,
      nil, uError, 0, @psError, 0, nil );
    sError := '#' + IntToStr(uError) + ': ' + PChar(psError);
    LocalFree(Cardinal(psError));
    Result := sError;
  end
  else
    Result := '#0'; // don't put "operation completed successfully!" It's too confusing!
end;



// Takes a string like: 'C:$Bar(20,30,10) jterlktjer(fsdfs)sfsdf(sdf)'
// with funcName '$Bar'
// and returns true(found) and numArgs=3 and an array with: '20', '30', '10'
// postfix=' jterlktjer(fsdfs)sfsdf(sdf)'
// prefix='C:'
function decodeArgs(str: String; funcName: String; maxargs: Cardinal;
  var args: Array of String; var prefix: String; var postfix: String; var
  numArgs: Cardinal): Boolean;
var
  posFuncStart, posArgsStart, posArgsEnd, posComma, posComma2: Integer;
  posTemp: Integer;
  tempStr: String;
  uiLevel: Cardinal;
begin
  Result := true;
  numArgs := 0;

  posFuncStart := pos(funcName + '(', str);
  if (posFuncStart <> 0) then
  begin
    posArgsStart := posFuncStart + length(funcName);

    // find end of function and cope with nested brackets
    posTemp := posArgsStart + 1;
    uiLevel := 1;
    repeat
      case (str[posTemp]) of
      '(': Inc(uiLevel);
      ')': Dec(uiLevel);
      end;
      Inc(posTemp);
    until (uiLevel = 0) or (posTemp > Length(str));
    if (uiLevel = 0) then
      posArgsEnd := posTemp-1
    else
      posArgsEnd := length(str);

    prefix := copy(str, 1, posFuncStart-1);
    postfix := copy(str, posArgsEnd + 1, length(str)-posArgsEnd + 1);

    if (posArgsStart <> 0) and (posArgsEnd <> 0) then
    begin
      tempstr := copy(str, posArgsStart + 1, posArgsEnd-posArgsStart-1);
      // tempstr is now something like: '20,30,10'
      posComma2 := 0;
      repeat
        // Find next comma ignoring those in brackets.
        uiLevel := 0;
        posComma := posComma2;
        repeat
          Inc(posComma);
          case (tempstr[posComma]) of
          '(': Inc(uiLevel);
          ')': Dec(uiLevel);
          end;
        until (posComma >= Length(tempstr)) or ((uiLevel = 0) and (tempstr[posComma] = ','));

        if (posComma >= Length(tempstr)) then
        begin
          args[numArgs] := copy(tempstr, posComma2+1, length(tempstr)-PosComma2);
          Inc(numArgs);
        end
        else
        begin
          args[numArgs] := copy(tempstr, posComma2+1, PosComma-(PosComma2+1));
          Inc(numArgs);
        end;
        posComma2 := posComma;
      until (poscomma >= Length(tempstr)) or (numArgs >= maxArgs);
    end;
  end
  else Result := false;

end;


end.

