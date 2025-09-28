sap.ui.define([
    "sap/m/MessageToast"
], function(MessageToast) {
    'use strict';

    return {
        activateEmployeeStatus: function(oEvent) {
            var ID = oEvent.getObject().ID;
            var action = "updateEmployeeStatus";
            var parameters = {
                model: this.getModel(),
                parameterValues: [{
                    name: "employeeId",
                    value: ID
                }],
                skipParameterDialog: true
            };

            this.editFlow.invokeAction(action, parameters).then(function(response){
                if(response){
                    this._controller.getExtensionAPI().refresh();
                }
            }.bind(this));
        }
    };
});
