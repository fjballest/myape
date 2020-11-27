--
-- sqr.adb -- print squares up to a given number
-- barnes 2.7.2
-- nemo@ordago.uc3m.es

with Text_Io; use Text_Io;
with Ada.Numerics.Generic_Elementary_Functions;
with Ada.Numerics; use Ada.Numerics;

-- Srq -- print square roots up to a given number using 5 decimal digits
procedure Sqr is

   type Real is  digits 6; -- 5 digit +1  xtra

   package Real_Io    is new Float_Io(Real); use Real_Io;
   package Int_Io     is new Integer_Io(Integer); use Int_Io;
   package Real_Maths is new 
      Ada.Numerics.Generic_Elementary_Functions(Real);   use Real_Maths;
   
   -- ask the limit to the user
   procedure Ask_Limit( Limit : out Integer ) is
   begin
       Put("Please, type the limit for squares and <CR>: ");
       Get(Limit);
   end Ask_Limit;
   
   ColPos: constant Positive_Count := 40; -- 2nd column starting pos

   Limit : Integer;

begin
   Ask_Limit(Limit);
   Set_Col(1);				 
   for Index in 1..Limit loop
      Put("sqrt(");
      Put(Index,Width=>3);
      Put(") is ");
      Set_Col(ColPos);
      Put(Sqrt(Real(Index)), Aft=>5, Exp=>0);
      New_Line;
   end loop;
   
end Sqr;

--
-- sqr.adb -- print squares up to a given number
-- barnes 2.7.2
-- nemo@ordago.uc3m.es

with Text_Io; use Text_Io;
with Ada.Numerics.Generic_Elementary_Functions;
with Ada.Numerics; use Ada.Numerics;

-- Srq -- print square roots up to a given number using 5 decimal digits
procedure Sqr is

   type Real is  digits 6; -- 5 digit +1  xtra

   package Real_Io    is new Float_Io(Real); use Real_Io;
   package Int_Io     is new Integer_Io(Integer); use Int_Io;
   package Real_Maths is new 
      Ada.Numerics.Generic_Elementary_Functions(Real);   use Real_Maths;
   
   -- ask the limit to the user
   procedure Ask_Limit( Limit : out Integer ) is
   begin
       Put("Please, type the limit for squares and <CR>: ");
       Get(Limit);
   end Ask_Limit;
   
   ColPos: constant Positive_Count := 40; -- 2nd column starting pos

   Limit : Integer;

begin
   Ask_Limit(Limit);
   Set_Col(1);				 
   for Index in 1..Limit loop
      Put("sqrt(");
      Put(Index,Width=>3);
      Put(") is ");
      Set_Col(ColPos);
      Put(Sqrt(Real(Index)), Aft=>5, Exp=>0);
      New_Line;
   end loop;
   
end Sqr;

