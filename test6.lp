%Test Enum value not in list -> UNSAT

ooasp_instantiation("v1","Inst").
ooasp_isa("Inst","EnumObjectA",1..3).
ooasp_attribute_value("Inst","EnumAttribute",1,"Option1").
ooasp_attribute_value("Inst","EnumAttribute",2,"Option2").
ooasp_attribute_value("Inst","EnumAttribute",3,"OptionA").
