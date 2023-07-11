program loginMenu;

var
  username, password: string;
  opcion: integer;
  salir: boolean;

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

begin
  salir := false;
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
      writeln('---- Hola ', username, '! ----'); // Mostrar mensaje de bienvenida
      writeln;
      repeat
        ShowMenu;
        writeln;
        write('Opcion: ');
        readln(opcion);
        case opcion of
          1: writeln('Aqui deberia ir el codigo para registrar un texto.');
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
