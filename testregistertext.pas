program registertext;

uses
  Crt, SysUtils, Classes;

var
  username, password: string;
  opcion: integer;
  salir: boolean;
  userTexts: TStringList;
  textNames: array of string;
  textContents: array of TStringList; 

type
  DataUser = record
    username, password: string;
  end;

const
  ListUser: array[1..3] of DataUser = (
    (username: 'user1'; password: 'password1'),
    (username: 'user2'; password: 'password2'),
    (username: 'user3'; password: 'password3')
  );

function authenticationUser(username, password: string): boolean;
var
  i: integer;
begin
  for i := 1 to 3 do
  begin
    if (ListUser[i].username = username) and (ListUser[i].password = password) then
    begin
      authenticationUser := true;
      Exit;
    end;
  end;
  authenticationUser := false;
end;

procedure ShowMenu;
begin
  writeln('---- Menu Principal ----');
  writeln('1.- Registrar un texto');
  writeln('2.- Buscar una palabra / oracion en un texto');
  writeln('3.- Ver historial de busqueda');
  writeln('4.- Cambiar de usuario');
  writeln('5.- Salir');
end;

procedure RegisterTxt;
var
  filename, textName: string;
  fileContents: TStringList;
begin
  writeln;
  writeln('---- Registrar un Texto ----');
  writeln;
  write('Ingresa el nombre del archivo txt: ');
  readln(filename);
  fileContents := TStringList.Create; // crear una TStringList para almacenar el contenido del archivo
  if FileExists(filename) then // comprobar si el archivo existe
  begin
    fileContents.LoadFromFile(filename); // cargar el contenido del archivo en TStringList
    writeln('Contenido del archivo:');
    writeln(fileContents.Text); // mostrar los contenidos del archivo txt
    writeln;
    writeln('Presione cualquier tecla para continuar...');
    readln;

    write('Ingresa el nombre del texto: ');
    readln(textName);

    // expandir los arrays dinamicos y almacenar el nombre del texto y el texto
    SetLength(textNames, Length(textNames) + 1); // aumentar la longitud de textNames en 1
    SetLength(textContents, Length(textContents) + 1); // aumentar la longitud de textContents en 1
    textNames[Length(textNames) - 1] := textName; // almacenar el nombre del texto en el último índice
    textContents[Length(textContents) - 1] := fileContents; // almacenar TStringList con el contenido del archivo en el último índice
  end
  else
  begin
    writeln;
    writeln('Error al cargar el archivo: El archivo no existe.');
    writeln;
    writeln('Presione cualquier tecla para continuar...');
    readln;
    Exit;
  end;
  writeln;
  writeln('Presione cualquier tecla para continuar...');
  readln;
end;

begin
  salir := false;
  userTexts := TStringList.Create; // crear una nueva instancia de TStringList
  Repeat
    writeln;
    writeln('---- Login! Ingresa tus datos ----');
    writeln;
    write('Usuario: ');
    readln(username);
    writeln;
    write('Password: ');
    readln(password);
    writeln;
    if authenticationUser(username, password) then
    begin
      writeln('---- Hola ', username, '! ----'); // mostrar mensaje de bienvenida
      writeln;
      repeat
        ShowMenu;
        writeln;
        write('Opcion: ');
        readln(opcion);
        case opcion of
          1: RegisterTxt;
          2: writeln('Aqui deberia ir el codigo para buscar una palabra/oracion en un texto.');
          3: writeln('Aqui deberia ir el codigo para ver el historial de búsqueda.');
          4: begin
              writeln('Cambiando de usuario...');
              break; // salir del bucle interior para cambiar de usuario
             end;
          5: begin
              writeln('Saliendo del programa...');
              salir := true;
              break; // salir del bucle interior para salir del programa
             end;
          else
            writeln('Opcion no valida.');
        end;
        writeln;
        writeln('Presione cualquier tecla para continuar...');
        readln;
      until false; // repetir hasta que se encuentre una ruptura interna (break)
    end
    else
    begin
      writeln;
      writeln('Acceso no autorizado. Nombre de usuario o passwords incorrectos.');
      writeln;
      writeln('Presione cualquier tecla para continuar...');
      readln;
    end;
  Until salir;
end.
