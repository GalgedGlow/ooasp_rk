% classes
ooasp_class("v1","HwObject").
ooasp_class("v1","Frame").
ooasp_class("v1","Module").
ooasp_class("v1","ModuleA"). ooasp_class("v1","ModuleB").
ooasp_class("v1","Element").
ooasp_class("v1","ElementA"). ooasp_class("v1","ElementB").

% class inheritance
ooasp_subclass("v1","Frame","HwObject").
ooasp_subclass("v1","Module","HwObject").
ooasp_subclass("v1","Element","HwObject").
ooasp_subclass("v1","ElementA","Element").
ooasp_subclass("v1","ElementB","Element").
ooasp_subclass("v1","ModuleA","Module").
ooasp_subclass("v1","ModuleB","Module").


% attributes and associations

% class Frame
ooasp_assoc("v1","Frame_modules","Frame",1,1,"Module",0,5).

% class Module
ooasp_attribute("v1","Module","position","integer").
ooasp_attribute_minInclusive("v1","Module","position",1).
ooasp_attribute_maxInclusive("v1","Module","position",5).
%TODO: write integrity constraint for position, depending on module

% class Element
ooasp_assoc("v1","Element_module","Element",1,1,"Module",1,1).


%Further extension

ooasp_class("v1","EnumObject").
ooasp_class("v1","EnumObjectA").
ooasp_subclass("v1","EnumObjectA","EnumObject").
ooasp_attribute("v1","EnumObject","EnumAttribute","string").
ooasp_attribute_enum("v1","EnumObject","EnumAttribute","Option1").
ooasp_attribute_enum("v1","EnumObject","EnumAttribute","Option2").
ooasp_attribute_enum("v1","EnumObject","EnumAttribute","Option3").
ooasp_attribute_enum("v1","EnumObject","EnumAttribute","Option4").
ooasp_attribute_enum("v1","EnumObject","EnumAttribute","Option5").
ooasp_attribute_enum("v1","EnumObject","EnumAttribute","Option6").