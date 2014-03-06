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

	type Couleur is ( Rouge, Vert, Bleu);

	for Couleur use (
		Rouge => 1;
		Vert => 5#2#;
		Bleu => 156;
		);

	--! 
	--  @brief Speed representation for a bike.
	--  This is a integer range. 
	typE Speed_T is range 0..90;

	--! String ariable	
	Version : string := "Version String"  ; 

	Gros_Nombre : Positive := 123_456 ;

	--! Test hexadecimal number;
	Hex_Nombre : Positive := 16#deadbeef#;

	Tres_Gros_Nombre : Positive := 123_456_789;

	Float_number : constant Float := 123.6548;
-- This is end of demo_pack unit  
	-- a multi comment block
	-- in multi line is complicated. 
end demo_pack;
