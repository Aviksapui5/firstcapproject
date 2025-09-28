using {employee.model.db as dataModel} from '../db/data-model';
using {S4CustomerAPI as externalAPI} from './external/S4CustomerAPI';

service EmployeeODataService {
    //@readonly
    @odata.draft.enabled
    entity EmployeeSet @(restrict: [
        {
            grant: ['READ'],
            to   : 'Manager'
        },
        {
            grant: [
                'READ',
                'UPDATE',
                'WRITE'
            ],
            to   : 'Employee'
        }
    ])                  as projection on dataModel.Employees
        actions {
            action updateStatus() returns String;
        }

    entity Designations as projection on dataModel.Designations;
    //entity FamilyMembers as projection on dataModel.FamilyMembers;
    entity Status       as projection on dataModel.Status;

    @(requires: 'Manager')
    action   updateEmployeeStatus(employeeId: String) returns String;


    entity CustomerSet  as
        projection on externalAPI.CustomerSet {
            key CustomerNumber  as customerID,
                CustomerName    as name,
                CustomerCity    as city,
                CustomerPhoneno as mobile
        }

    function getEmployeeData()                        returns String;
}
