const cds = require('@sap/cds');

class EmployeeODataService extends cds.ApplicationService {
    async init() {
        const { EmployeeSet, CustomerSet } = this.entities;
        const S4db = await cds.connect.to("S4CustomerAPI");

        this.on('READ', CustomerSet, async (req) => {
            return S4db.run(req.query);
        });

        this.before('UPDATE', EmployeeSet.drafts, async (req) => {
            if (req.data?.email) {

                // let checkExisitingData = await SELECT.one.from(EmployeeSet).columns('email').where({
                //     email: req.data.email
                // });

                // if(checkExisitingData.length > 0){

                // }
                // let pattern = /^[\w._-]+[+]?[\w._-]+@[\w.-]+\.[a-zA-Z]{2,6}$/;
                // if (!pattern.test(req.data?.email)) {
                //     req.error({
                //         code: 400,
                //         target: 'email',
                //         message: "Please enter correct email address"
                //     });
                // }
            }

            if (req.data?.designation_code) {
                let code = req.data?.designation_code;
                let salary = 0;
                switch (code) {
                    case 'D001':
                        salary = 90000;
                        break;
                    case 'D002':
                        salary = 120000;
                        break;
                    case 'D003':
                        salary = 250000;
                        break;
                    default:
                        salary = 50000;
                }

                req.data.salary = salary;
            }

        });

        this.on('updateEmployeeStatus', async (req) => {

            if(req.data?.employeeId){
                // let updated = await UPDATE(EmployeeSet, req.data?.employeeId).with({
                //     status_code: "ACT"
                // });
                // let updated = await UPDATE(EmployeeSet, req.data?.employeeId).with({
                //     status_code: "ACT"
                // });

                let updated = await cds.tx(UPDATE(EmployeeSet, req.data?.employeeId).with({
                    status_code: "ACT"
                }));


                if(updated){
                    req.info(200, "Employee Activated!");
                } else {
                    req.error(400, "Failed to update status");
                }

            }

        }); 


        this.on("getEmployeeData", async (req) => {
            let query = `CALL "EmployeeData"(EMPDATA=>?)`;

            let data = await cds.run(query);

            if(data){
                let response = {
                    empData: data.EMPDATA
                };

                return response;
            }

        });

        return super.init();
    }
}

module.exports = EmployeeODataService;