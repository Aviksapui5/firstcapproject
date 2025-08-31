using {employee.model.db as dataModel} from '../db/data-model';

service EmployeeODataService {
    //@readonly
    entity EmployeeSet as projection on dataModel.Employees;
    //entity FamilyMembers as projection on dataModel.FamilyMembers;

}


