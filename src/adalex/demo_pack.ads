--! @file
-- @brief Demonstration package
-- Demonstration package file that demonstrate the mainpage command.
-- \mainpage
-- Text of the mainpage

with ada ;
with Plop;
with Plop.plop.plop;
with IO.stream.console;


package demo_pack.types is

	--! Type for representation of the Age of a human. 
	type Age_T is range 0..150;

	TyPe Taille_T is range 0..260;

	--! 
	--  @brief Speed representation for a bike.
	--  This is a integer range. 
	typE Speed_T is range 0..90;



end demo_pack;
