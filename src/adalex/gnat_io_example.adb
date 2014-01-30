-- GNAT.IO_Aux Example
--
-- GNAT.IO_Aux offers a Get_Line function that returns a string and
-- a function to check for an existing file.

with GNAT.IO; use GNAT.IO;
with GNAT.IO_Aux;

procedure Gio_Aux is
begin

   Put("Check if what file exists? : ");

   declare
      File_Name : String := GNAT.IO_Aux.Get_Line;
   begin
      if GNAT.IO_Aux.File_Exists(File_Name) then
         Put_Line("File exists");
      else
         Put_Line("File does not exist");
      end if;
   end;

end Gio_Aux;
