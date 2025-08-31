namespace employee.model.db;

using {
    cuid,
    managed,
    sap.common.Countries
} from '@sap/cds/common';

type CommonFields {
    firstName : String(40);
    lastName  : String(40);
    address   : String(300);
    mobile    : String(13);
    email     : String(50);
}

entity Employees : CommonFields, cuid, managed {
    salary      : Decimal(10, 2);
    designation : String(50);
    country     : Association to Countries;
    //familyMembers: Association to many FamilyMembers on familyMembers.employee = $self;
    familyMembers: Composition of many FamilyMembers on familyMembers.employee = $self;
}

entity FamilyMembers : CommonFields, cuid, managed {
    relationShip : String;
    employee: Association to Employees;  //Managed Association 
    //employeeID: String;                                     //Unmanaged Association
    //employeeDet: Association to Employees on employeeDet.ID = employeeID; // Unmanaged Assocaition 
}



