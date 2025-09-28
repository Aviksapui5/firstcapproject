namespace employee.model.db;

using {
    cuid,
    managed,
    sap.common.Countries
} from '@sap/cds/common';

type CommonFields {
    firstName : String(40)  @title: '{i18n>firstName}';
    lastName  : String(40)  @title: '{i18n>lastName}';
    address   : String(300) @title: '{i18n>address}';
    mobile    : String(13)  @title: '{i18n>mobile}';
    email     : String(50)  @title: '{i18n>email}';
}

entity Employees : CommonFields, cuid, managed {
    salary        : Decimal(10, 2) @title: '{i18n>salary}';
    designation   : Association to Designations;
    country       : Association to Countries;
    //familyMembers: Association to many FamilyMembers on familyMembers.employee = $self;
    familyMembers : Composition of many FamilyMembers
                        on familyMembers.employee = $self;
    status        : Association to Status default 'DCT';
}

entity FamilyMembers : CommonFields, cuid, managed {
    relationShip : String @title: '{i18n>relationship}';
    employee     : Association to Employees; //Managed Association
//employeeID: String;                                     //Unmanaged Association
//employeeDet: Association to Employees on employeeDet.ID = employeeID; // Unmanaged Assocaition
}


entity Designations {
    key code : String;
        name : String;
}

entity Status {
    key code : String;
        name : String;
}
