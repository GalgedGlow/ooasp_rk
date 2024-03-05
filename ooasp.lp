%Generates N objects of each class
initial_generation(20).
{ ooasp_isa(IdI,IdC,M) : ooasp_class(IdM,IdC) } <= 1 :- ooasp_instantiation(IdM,IdI), M = 1..N, initial_generation(N).
:- C!=N, class_count(N), C = #count{ M : ooasp_isa(IdI,IdC,M) }. %each ID can only be assigned once

%Generate ooasp_isa dependent on ooasp_attribute_value!
{ ooasp_isa(IdI,IdC,IdO) : ooasp_attribute_value(IdI,IdAT,IdO,_) } <= 1 :- 
{ ooasp_subclass(IdM,IdSubC,IdC) : ooasp_attribute(IdM,IdC,IdAT,_) } < 1, %only leaf classes can be ooasp_isa 
ooasp_attribute_value(IdI,IdAT,IdO,_),
ooasp_attribute(IdM,IdC,IdAT,_),
ooasp_instantiation(IdM,IdI).

%ooasp_attribute_values should have exactly 1 ooasp_isa with same IdO
:- { ooasp_isa(IdI,IdC,IdO): ooasp_attribute_value(IdI,IdAT,IdO,Val), ooasp_attribute(IdM,IdC,IdAT,DT) } != 1,
ooasp_attribute_value(IdI,IdAT,IdO,Val),
ooasp_instantiation(IdM,IdI).

%Generate ooasp_isa dependent on ooasp_associated
{ ooasp_isa(IdI,IdC1,IdO1) : ooasp_associated(IdI,IdA,IdO1,IdO2) } <= 1 :- 
{ ooasp_subclass(IdM,IdSubC,IdC1) : leaf_assoc(IdM, IdA, IdC1, MinC1, MaxC1, IdC2, MinC2, MaxC2) } < 1, %only leaf classes can be ooasp_isa 
ooasp_associated(IdI,IdA,IdO1,IdO2),
leaf_assoc(IdM, IdA, IdC1, MinC1, MaxC1, IdC2, MinC2, MaxC2),
ooasp_instantiation(IdM,IdI).

{ ooasp_isa(IdI,IdC2,IdO2) : ooasp_associated(IdI,IdA,IdO1,IdO2) } <= 1 :- 
{ ooasp_subclass(IdM,IdSubC,IdC2) : leaf_assoc(IdM, IdA, IdC1, MinC1, MaxC1, IdC2, MinC2, MaxC2) } < 1, %only leaf classes can be ooasp_isa 
ooasp_associated(IdI,IdA,IdO1,IdO2),
leaf_assoc(IdM, IdA, IdC1, MinC1, MaxC1, IdC2, MinC2, MaxC2),
ooasp_instantiation(IdM,IdI).

%ooasp_associated should have exactly 1 ooasp_isa with same IdO1
:- { ooasp_isa(IdI,IdC1,IdO1): ooasp_associated(IdI,IdA,IdO1,IdO2), leaf_assoc(IdM, IdA, IdC1, MinC1, MaxC1, IdC2, MinC2, MaxC2) } != 1,
ooasp_associated(IdI,IdA,IdO1,IdO2),
ooasp_instantiation(IdM,IdI).

%ooasp_associated should have exactly 1 ooasp_isa with same IdO2
:- { ooasp_isa(IdI,IdC2,IdO2): ooasp_associated(IdI,IdA,IdO1,IdO2), leaf_assoc(IdM, IdA, IdC1, MinC1, MaxC1, IdC2, MinC2, MaxC2) } != 1,
ooasp_associated(IdI,IdA,IdO1,IdO2),
ooasp_instantiation(IdM,IdI).

%Min/Max Cardinalities for ooasp_assoc!
:- N1 > N2 * MaxC1, MinC2 != 0, ooasp_assoc(IdM, IdA, IdC1, MinC1, MaxC1, IdC2, MinC2, MaxC2), leaf_count(IdA,N1,N2).
:- N2 > N1 * MaxC2, MinC1 != 0, ooasp_assoc(IdM, IdA, IdC1, MinC1, MaxC1, IdC2, MinC2, MaxC2), leaf_count(IdA,N1,N2).
:- N1 < N2 * MinC1, MinC2 != 0, ooasp_assoc(IdM, IdA, IdC1, MinC1, MaxC1, IdC2, MinC2, MaxC2), leaf_count(IdA,N1,N2).
:- N2 < N1 * MinC2, MinC1 != 0, ooasp_assoc(IdM, IdA, IdC1, MinC1, MaxC1, IdC2, MinC2, MaxC2), leaf_count(IdA,N1,N2).

%leaf associations class count
leaf_count(IdA,N1,N2) :- 
ooasp_assoc(IdM, IdA, IdC1, MinC1, MaxC1, IdC2, MinC2, MaxC2), 
N1 = #count{ IdO : ooasp_isa(IdI,IdLC1,IdO), leaf_assoc(IdM, IdA, IdLC1, MinC1, MaxC1, IdLC2, MinC2, MaxC2) }, 
N2 = #count{ IdO : ooasp_isa(IdI,IdLC2,IdO), leaf_assoc(IdM, IdA, IdLC1, MinC1, MaxC1, IdLC2, MinC2, MaxC2) }.

%leaf associations
leaf_assoc(IdM, IdA, IdLC1, MinC1, MaxC1, IdLC2, MinC2, MaxC2) :- ooasp_assoc(IdM, IdA, IdSC1, MinC1, MaxC1, IdSC2, MinC2, MaxC2), ooasp_subclass(IdM,IdLC1,IdSC1), ooasp_subclass(IdM,IdLC2,IdSC2).
leaf_assoc(IdM, IdA, IdLC, MinC1, MaxC1, IdC2, MinC2, MaxC2) :- ooasp_assoc(IdM, IdA, IdSC, MinC1, MaxC1, IdC2, MinC2, MaxC2), ooasp_subclass(IdM,IdLC,IdSC).
leaf_assoc(IdM, IdA, IdC1, MinC1, MaxC1, IdLC, MinC2, MaxC2) :- ooasp_assoc(IdM, IdA, IdC1, MinC1, MaxC1, IdSC, MinC2, MaxC2), ooasp_subclass(IdM,IdLC,IdSC).
leaf_assoc(IdM, IdA, IdC1, MinC1, MaxC1, IdC2, MinC2, MaxC2) :- ooasp_assoc(IdM, IdA, IdC1, MinC1, MaxC1, IdC2, MinC2, MaxC2).

{ ooasp_associated(IdI,IdA,IdO1,IdO2) : leaf_assoc(IdM, IdA, IdLC1, MinC1, MaxC1, IdLC2, MinC2, MaxC2) } <= 1 :-
leaf_assoc(IdM, IdA, IdLC1, MinC1, MaxC1, IdLC2, MinC2, MaxC2),
ooasp_isa(IdI,IdLC1,IdO1),
ooasp_isa(IdI,IdLC2,IdO2).

%each ooasp_isa has to fullfil min/max constraints: isa(C1) -> minC1: must be in minC1 relations, maxC1: can only be up to maxC1 relations;
:- { ooasp_associated(IdI,IdA,IdO1,IdO2) : ooasp_isa(IdI,IdLC1,IdO1) } > MaxC2 , ooasp_assoc(IdM, IdA, IdC1, MinC1, MaxC1, IdC2, MinC2, MaxC2), leaf_assoc(IdM, IdA, IdLC1, MinC1, MaxC1, IdLC2, MinC2, MaxC2), ooasp_isa(IdI,IdLC1,IdO1).
:- { ooasp_associated(IdI,IdA,IdO1,IdO2) : ooasp_isa(IdI,IdLC1,IdO1) } < MinC2 , ooasp_assoc(IdM, IdA, IdC1, MinC1, MaxC1, IdC2, MinC2, MaxC2), leaf_assoc(IdM, IdA, IdLC1, MinC1, MaxC1, IdLC2, MinC2, MaxC2), ooasp_isa(IdI,IdLC1,IdO1).
:- { ooasp_associated(IdI,IdA,IdO1,IdO2) : ooasp_isa(IdI,IdLC2,IdO2) } > MaxC1 , ooasp_assoc(IdM, IdA, IdC1, MinC1, MaxC1, IdC2, MinC2, MaxC2), leaf_assoc(IdM, IdA, IdLC1, MinC1, MaxC1, IdLC2, MinC2, MaxC2), ooasp_isa(IdI,IdLC2,IdO2).
:- { ooasp_associated(IdI,IdA,IdO1,IdO2) : ooasp_isa(IdI,IdLC2,IdO2) } < MinC1 , ooasp_assoc(IdM, IdA, IdC1, MinC1, MaxC1, IdC2, MinC2, MaxC2), leaf_assoc(IdM, IdA, IdLC1, MinC1, MaxC1, IdLC2, MinC2, MaxC2), ooasp_isa(IdI,IdLC2,IdO2).

%check that attribute are "integer", "string", "boolean"
:- N!=1, ooasp_attribute(IdM,IdC,IdAT,DT), N = #sum { 1: DT = "integer"; 1: DT = "string"; 1: DT = "boolean" }.

%Check ooasp_attribute_value if IdAT exists in ooasp_attribute
:- { ooasp_attribute(IdM,IdC,IdAT,DT) : ooasp_attribute_value(IdI,IdAT,IdO,Val) } < 1, ooasp_isa(IdI,IdC,IdO), ooasp_attribute_value(IdI,IdAT,IdO,Val).

%Copy attributes of superclasses to subclasses
ooasp_attribute(IdM,IdC,IdAT,DT) :- ooasp_attribute(IdM,IdSC,IdAT,DT), ooasp_subclass(IdM,IdC,IdSC).
ooasp_attribute_minInclusive(IdM,IdC,IdAT,Val) :- ooasp_attribute_minInclusive(IdM,IdSC,IdAT,Val), ooasp_subclass(IdM,IdC,IdSC).
ooasp_attribute_maxInclusive(IdM,IdC,IdAT,Val) :- ooasp_attribute_maxInclusive(IdM,IdSC,IdAT,Val), ooasp_subclass(IdM,IdC,IdSC).
ooasp_attribute_enum(IdM,IdC,IdAT,Val) :- ooasp_attribute_enum(IdM,IdSC,IdAT,Val), ooasp_subclass(IdM,IdC,IdSC).

%Do not permit instantiations of non-leaf classes
:- IdSC = IdC2, ooasp_subclass(IdM,IdC1,IdSC), ooasp_isa(IdI,IdC2,IdO).

%check if enum value in list
:- { ooasp_attribute_enum(IdM,IdC,IdAT,Val) : ooasp_attribute_value(IdI,IdAT,IdO,Val) } != 1,
ooasp_instantiation(IdM,IdI),
ooasp_attribute_enum(IdM,IdC,IdAT,_), %has to be of type enum
ooasp_attribute(IdM,IdC,IdAT,DT),
ooasp_isa(IdI,IdC,IdO).

%min/max val boundaries
:- Val < MinV,
ooasp_attribute_minInclusive(IdM,IdC,IdAT,MinV),
ooasp_attribute_value(IdI,IdAT,IdO,Val),
ooasp_instantiation(IdM,IdI),
ooasp_isa(IdI,IdC,IdO).

:- Val > MaxV,
ooasp_attribute_maxInclusive(IdM,IdC,IdAT,MaxV),
ooasp_attribute_value(IdI,IdAT,IdO,Val),
ooasp_instantiation(IdM,IdI),
ooasp_isa(IdI,IdC,IdO).

%Read ooasp_instantiation from other instantiation atoms
ooasp_instantiation(IdM,IdI) :- ooasp_isa(IdI,IdC,IdO), ooasp_class(IdM,IdC).
ooasp_instantiation(IdM,IdI) :- ooasp_associated(IdI,IdA,IdO1,IdO2), ooasp_class(IdM,IdC).
ooasp_instantiation(IdM,IdI) :- ooasp_attribute_value(IdI,IdAT,IdO,Val), ooasp_class(IdM,IdC).

%%%%%%%%%%% Pretty Print %%%%%%%%%%%%%%%%%%

#show ooasp_instantiation/2.
#show ooasp_isa/3.
#show ooasp_associated/4.
#show ooasp_attribute_value/4.

#minimize {IdO@1,IdI: ooasp_instantiation(IdM,IdI), ooasp_isa(IdI,IdC,IdO) }.
#minimize {OS@2,IdI: ooasp_instantiation(IdM,IdI), total_object_id_sum(OS) }.

total_object_id_sum(OS) :- OS = #sum{ IdO : ooasp_isa(IdI,IdC,IdO) }.