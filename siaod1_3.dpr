program siaod1_3;

{$APPTYPE CONSOLE}

uses
  SysUtils, Windows;

type
  data = record
  name : string[20];
  surname : string[20];
  secondname : string[20];
  tel : string[7];
  end;

  TList = ^elem;
  elem = record
  info : data;
  next : TList;
  end;

function NomerOperacii:integer;
var a : integer;
    oper : set of Byte;
    flag : boolean;
begin
oper := [1, 2, 3, 4, 5];
writeln('�������� ��������, ������� ���������� �������� ��� �������.');
  writeln('1 - ���������� ������ ��������.');
  writeln('2 - ����� �� �������.');
  writeln('3 - ����� �� ������ ��������.');
  writeln('4 - ������� ������ ���������.');
  writeln('5 - ����� ������ �� �������.');
flag := false;
repeat
readln(a);
if a in oper then
  flag := true
else
  writeln('������� ���������� ����� ��������!');
until flag = true;
result:=a;
end;





procedure whattodo(oper:integer; head:TList);
var iskomoe :string[20];


procedure ShowList(head : TList);
var curr:TList;
begin
curr:=head.next;
writeln(curr.info.name,' ', curr.info.surname,' ',curr.info.secondname,' ',curr.info.tel);
while curr.next<>nil do
begin
curr:=curr.next;
writeln(curr.info.name,' ', curr.info.surname,' ',curr.info.secondname,' ',curr.info.tel);
end;
end;

procedure AddNewElem(head:TList);

function EnterElem:data;
var new:elem;
begin
writeln('������� ���:');
readln(new.info.name);
writeln('������� �������:');
readln(new.info.surname);
writeln('������� ��������:');
readln(new.info.secondname);
writeln('������� ����� �������� (7 ����):');
readln(new.info.tel);
result := new.info;
end;

var curr:Tlist;
f:file of data;
i:integer;

begin
assignfile(f,'spisokabonentov.dat');
i:=0;
curr:=head.next;
writeln('������� ������ ������ ��������.');
while curr.next<>nil do
begin
curr:=curr.next;
inc(i);
end;
new(curr.next);
curr:=curr.next;
curr.info:=EnterElem;
curr.next:=nil;
inc(i);
reset(f);
seek(f,i);
write(f,curr.info);
closefile(f);
end;

procedure SurnameSearch(iskomoe:string; head:tlist);
var  flag:boolean;
    curr:Tlist;
begin
curr:=head;
flag := false;
while curr.next<>nil do
begin
curr:=curr.next;
if curr.info.surname = iskomoe then
  begin
  writeln(curr.info.name,' ', curr.info.surname,' ',curr.info.secondname,' ',curr.info.tel);
  flag:=true;
  end;

end;
if flag = false then writeln('�������� � ������ �������� �� �������!');

end;


procedure TelephoneSearch(iskomoe:string; head:tlist);
var  flag:boolean;
    curr:Tlist;
begin
curr:=head;
flag := false;
while curr.next<>nil do
begin
curr:=curr.next;
if curr.info.tel = iskomoe then
  begin
  writeln(curr.info.name,' ', curr.info.surname,' ',curr.info.secondname,' ',curr.info.tel);
  flag:=true;
  end;
end;
if flag = false then writeln('�������� � ������ ��������� �� �������!');

end;


begin
 case oper of
  1:
    begin
    AddNewElem(head);
    oper:=NomerOperacii;
    whattodo(oper,head);
    end;
  2:
    begin
    writeln('������� ������� �������.');
    readln(iskomoe);
    SurnameSearch(iskomoe,head);
    oper:=NomerOperacii;
    whattodo(oper,head);
    end;
  3:
    begin
    writeln('������� ������� �����.');
    readln(iskomoe);
    TelephoneSearch(iskomoe,head);
    oper:=NomerOperacii;
    whattodo(oper,head);
    end;
  4:
    begin
    showlist(head);
    oper:=NomerOperacii;
    whattodo(oper,head);
    end;
  5:   writeln('��.');
  end;
end;

var curr,first : TList;
    f : file of data;
    t : textfile;
    file_exist : boolean;
    oper, i : integer;

begin
  SetConsoleCP(1251);
  SetConsoleOutputCP(1251);

   Assignfile(f, 'spisokabonentov.dat');
   try
   Reset(f);
   file_exist := true;
   except
   writeln('���� � ���������� �� ����������');
   file_exist := false;
   end;




if (file_exist = true) and (not eof(f)) then
begin
i := 0;
new(first);
curr:=first;
new(curr.next);
curr:=curr.next;
seek(f, i);
read(f, curr.info);
while (not eof(f)) do
  begin
  new(curr.next);
  curr := curr.next;
  inc(i);
  seek(f, i);
  read(f, curr.info);
  curr.next:=nil;
  end;
closefile(f);

oper:=NomerOperacii;
whattodo(oper,first);

  end;

readln;
end.                                    
