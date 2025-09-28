sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"com/app/employeeapp/test/integration/pages/EmployeeSetList",
	"com/app/employeeapp/test/integration/pages/EmployeeSetObjectPage"
], function (JourneyRunner, EmployeeSetList, EmployeeSetObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('com/app/employeeapp') + '/index.html',
        pages: {
			onTheEmployeeSetList: EmployeeSetList,
			onTheEmployeeSetObjectPage: EmployeeSetObjectPage
        },
        async: true
    });

    return runner;
});

