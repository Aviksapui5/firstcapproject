using EmployeeODataService as service from '../../srv/service';
using from '../../db/data-model';



annotate service.EmployeeSet with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : ID
        },
        {
            $Type : 'UI.DataField',
            Value : firstName
        },
        {
            $Type : 'UI.DataField',
            Value : lastName
        },
        {
            $Type : 'UI.DataField',
            Value : email
        },
        {
            $Type : 'UI.DataField',
            Value : designation
        },
        {
            $Type : 'UI.DataField',
            Value : mobile
        }
    ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>EmployeeDetails}',
            ID : 'i18nEmployeeDetails',
            Target : '@UI.FieldGroup#i18nEmployeeDetails',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>FamilyMemberDetails}',
            ID : 'i18nFamilyMemberDetails',
            Target : 'familyMembers/@UI.LineItem#i18nFamilyMemberDetails',
        },
    ],
    UI.FieldGroup #i18nEmployeeDetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : firstName,
            },
            {
                $Type : 'UI.DataField',
                Value : lastName,
            },
            {
                $Type : 'UI.DataField',
                Value : mobile,
            },
            {
                $Type : 'UI.DataField',
                Value : designation_code,
                Label : '{i18n>designation}',
            },
            {
                $Type : 'UI.DataField',
                Value : email,
            },
            {
                $Type : 'UI.DataField',
                Value : salary,
            },
            {
                $Type : 'UI.DataField',
                Value : address,
            },
            {
                $Type : 'UI.DataField',
                Value : status.name,
                Label : '{i18n>Status}',
            },
        ],
    },
    UI.Identification : [
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'EmployeeODataService.updateStatus',
            Label : 'updateStatus',
        },
    ],
);

annotate service.FamilyMembers with @(
    UI.LineItem #i18nFamilyMemberDetails : [
        {
            $Type : 'UI.DataField',
            Value : ID,
            Label : 'ID',
        },
        {
            $Type : 'UI.DataField',
            Value : firstName,
        },
        {
            $Type : 'UI.DataField',
            Value : lastName,
        },
        {
            $Type : 'UI.DataField',
            Value : email,
        },
        {
            $Type : 'UI.DataField',
            Value : relationShip,
        },
        {
            $Type : 'UI.DataField',
            Value : mobile,
        },
        {
            $Type : 'UI.DataField',
            Value : address,
        },
    ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>FamilyMemberDetail}',
            ID : 'i18nFamilyMemberDetail',
            Target : '@UI.FieldGroup#i18nFamilyMemberDetail',
        },
    ],
    UI.FieldGroup #i18nFamilyMemberDetail : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : ID,
                Label : 'ID',
            },
            {
                $Type : 'UI.DataField',
                Value : firstName,
            },
            {
                $Type : 'UI.DataField',
                Value : lastName,
            },
            {
                $Type : 'UI.DataField',
                Value : mobile,
            },
            {
                $Type : 'UI.DataField',
                Value : email,
            },
            {
                $Type : 'UI.DataField',
                Value : address,
            },
            {
                $Type : 'UI.DataField',
                Value : relationShip,
            },
        ],
    },
);

annotate service.EmployeeSet with {
    designation @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Designations',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : designation_code,
                    ValueListProperty : 'code',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
        Common.Text : designation.name,
        Common.Text.@UI.TextArrangement : #TextOnly,
)};

annotate service.Designations with {
    code @(
        Common.Text : name,
        Common.Text.@UI.TextArrangement : #TextOnly,
)};

annotate service.Status with {
    name @Common.FieldControl : #ReadOnly
};


annotate service.EmployeeSet with @(Common.SideEffects #updateSalary: {
    SourceProperties: ['designation_code'],
    TargetProperties: ['salary']
});

