@isTest
private class NameOpportunityTest {
    @isTest static void enterProjectAddressByCheckbox() {
        // 1. Create Account
        Account acc = new Account();
        acc.Name    = 'Test Account';
        acc.Mailing_Address__c = '123 Main St';
        acc.Mailing_City__c = 'Long Beach';
        acc.Mailing_State__c = 'CA';
        acc.Mailing_Zip_Code__c = '90802';
        insert acc;

        // 2. Create Opportunity, Assign Account to Opportunity, Set "Same as mailing address" to true on Opportunity
        Opportunity myOpp = new Opportunity();
        myOpp.Name = 'Test Opportunity';
        myOpp.StageName = 'RFP';
        myOpp.AccountId = acc.Id;
        myOpp.CloseDate = Date.Today();
        myOpp.Same_as_Mailing_Address__c = true;
        insert myOpp;

        // 3. Set correct name of opp
        String oppName = acc.Name + ' - ' + acc.Mailing_City__c + ', ' + acc.Mailing_State__c;

        // 4. Get latest opp info
        Opportunity myUpdatedOpp = [SELECT Name FROM Opportunity WHERE Id = :myOpp.Id LIMIT 1];

        // 5. Assert that the NameOpportunity trigger fired
        System.AssertEquals(oppName, myUpdatedOpp.Name);
    }
    @isTest static void enterProjectAddressManually() {
        // 1. Create Account
        Account acc             = new Account();
        acc.Name                = 'Test Account';
        acc.Mailing_Address__c  = '123 Main St';
        acc.Mailing_City__c     = 'Long Beach';
        acc.Mailing_State__c    = 'CA';
        acc.Mailing_Zip_Code__c = '90802';
        insert acc;

        // 2. Create Opportunity, Assign Account to Opportunity, Set "Same as mailing address" to false on Opportunity
        Opportunity myOpp      = new Opportunity();
        myOpp.Name             = 'Test Opportunity';
        myOpp.StageName        = 'RFP';
        myOpp.AccountId        = acc.Id;
        myOpp.CloseDate        = Date.Today();
        myOpp.Same_as_Mailing_Address__c = false;
        myOpp.Project_City__c            = 'Anywhere';
        myOpp.Project_State__c           = 'NY';
        insert myOpp;

        // 3. Set correct name of opp
        String oppName = acc.Name + ' - ' + myOpp.Project_City__c + ', ' + myOpp.Project_State__c;

        // 4. Get latest opp info
        Opportunity myUpdatedOpp = [SELECT Name FROM Opportunity WHERE Id = :myOpp.Id LIMIT 1];

        // 5. Assert that the NameOpportunity trigger fired
        System.AssertEquals(oppName, myUpdatedOpp.Name);
    }
    @isTest static void updateProjectAddressManually() {
        // 1. Create Account
        Account acc             = new Account();
        acc.Name                = 'Test Account';
        acc.Mailing_Address__c  = '123 Main St';
        acc.Mailing_City__c     = 'Long Beach';
        acc.Mailing_State__c    = 'CA';
        acc.Mailing_Zip_Code__c = '90802';
        insert acc;

        // 2. Create Opportunity, Assign Account to Opportunity, Set "Same as mailing address" to false on Opportunity
        Opportunity myOpp      = new Opportunity();
        myOpp.Name             = 'Test Opportunity';
        myOpp.StageName        = 'RFP';
        myOpp.AccountId        = acc.Id;
        myOpp.CloseDate        = Date.Today();
        myOpp.Same_as_Mailing_Address__c = false;
        myOpp.Project_City__c            = 'Anywhere';
        myOpp.Project_State__c           = 'NY';
        insert myOpp;

        // 3. Change Opportunity Project Address
        myOpp.Project_City__c = 'Nowhere';
        myOpp.Project_State__c = 'WI';
        update myOpp;

        // 4. Get latest opp info
        Opportunity myUpdatedOpp = [SELECT Name, Project_City__c, Project_State__c FROM Opportunity WHERE Id = :myOpp.Id LIMIT 1];

        // 3. Set correct name of opp
        String oppName = acc.Name + ' - ' + myUpdatedOpp.Project_City__c + ', ' + myUpdatedOpp.Project_State__c;

        // 5. Assert that the NameOpportunity trigger fired
        System.AssertEquals(oppName, myUpdatedOpp.Name);
    }
    @isTest static void updateProjectAddressByCheckbox() {
        // 1. Create Account
        Account acc             = new Account();
        acc.Name                = 'Test Account';
        acc.Mailing_Address__c  = '123 Main St';
        acc.Mailing_City__c     = 'Long Beach';
        acc.Mailing_State__c    = 'CA';
        acc.Mailing_Zip_Code__c = '90802';
        insert acc;

        // 2. Create Opportunity, Assign Account to Opportunity, Set "Same as mailing address" to false on Opportunity
        Opportunity myOpp      = new Opportunity();
        myOpp.Name             = 'Test Opportunity';
        myOpp.StageName        = 'RFP';
        myOpp.AccountId        = acc.Id;
        myOpp.CloseDate        = Date.Today();
        myOpp.Same_as_Mailing_Address__c = false;
        insert myOpp;

        // 3. Change Opportunity Project Address
        myOpp.Same_as_Mailing_Address__c = true;
        update myOpp;

        // 4. Get latest opp info
        Opportunity myUpdatedOpp = [SELECT Name, Project_City__c, Project_State__c FROM Opportunity WHERE Id = :myOpp.Id LIMIT 1];

        // 3. Set correct name of opp
        String oppName = acc.Name + ' - ' + 'Long Beach' + ', ' + 'CA';

        // 5. Assert that the NameOpportunity trigger fired
        System.AssertEquals(oppName, myUpdatedOpp.Name);
    }
    @isTest static void noState() {
        // 1. Create Account
        Account acc = new Account();
        acc.Name    = 'Test Account';
        acc.Mailing_Address__c = '123 Main St';
        acc.Mailing_City__c = 'Long Beach';
        acc.Mailing_State__c = 'CA';
        acc.Mailing_Zip_Code__c = '90802';
        insert acc;

        // 2. Create Opportunity, Assign Account to Opportunity, Set "Same as mailing address" to true on Opportunity
        Opportunity myOpp = new Opportunity();
        myOpp.Name = 'Test Opportunity';
        myOpp.StageName = 'RFP';
        myOpp.AccountId = acc.Id;
        myOpp.CloseDate = Date.Today();
        myOpp.Same_as_Mailing_Address__c = false;
        myOpp.Project_City__c = 'Nostateville';
        insert myOpp;

        // 3. Set correct name of opp
        String oppName = acc.Name + ' - ' + myOpp.Project_City__c;

        // 4. Get latest opp info
        Opportunity myUpdatedOpp = [SELECT Name FROM Opportunity WHERE Id = :myOpp.Id LIMIT 1];

        // 5. Assert that the NameOpportunity trigger fired
        System.AssertEquals(oppName, myUpdatedOpp.Name);
    }
    @isTest static void noCity() {
                        // 1. Create Account
        Account acc = new Account();
        acc.Name    = 'Test Account';
        acc.Mailing_Address__c = '123 Main St';
        acc.Mailing_City__c = 'Long Beach';
        acc.Mailing_State__c = 'CA';
        acc.Mailing_Zip_Code__c = '90802';
        insert acc;

        // 2. Create Opportunity, Assign Account to Opportunity, Set "Same as mailing address" to true on Opportunity
        Opportunity myOpp = new Opportunity();
        myOpp.Name = 'Test Opportunity';
        myOpp.StageName = 'RFP';
        myOpp.AccountId = acc.Id;
        myOpp.CloseDate = Date.Today();
        myOpp.Same_as_Mailing_Address__c = false;
        myOpp.Project_State__c = 'AL';
        insert myOpp;

        // 3. Set correct name of opp
        String oppName = acc.Name + ' - ' + myOpp.Project_State__c;

        // 4. Get latest opp info
        Opportunity myUpdatedOpp = [SELECT Name FROM Opportunity WHERE Id = :myOpp.Id LIMIT 1];

        // 5. Assert that the NameOpportunity trigger fired
        System.AssertEquals(oppName, myUpdatedOpp.Name);
    }
    @isTest static void noStateOrCity() {
        // 1. Create Account
        Account acc = new Account();
        acc.Name    = 'Test Account';
        acc.Mailing_Address__c = '123 Main St';
        acc.Mailing_City__c = 'Long Beach';
        acc.Mailing_State__c = 'CA';
        acc.Mailing_Zip_Code__c = '90802';
        insert acc;

        // 2. Create Opportunity, Assign Account to Opportunity, Set "Same as mailing address" to true on Opportunity
        Opportunity myOpp = new Opportunity();
        myOpp.Name = 'Test Opportunity';
        myOpp.StageName = 'RFP';
        myOpp.AccountId = acc.Id;
        myOpp.CloseDate = Date.Today();
        myOpp.Same_as_Mailing_Address__c = false;
        insert myOpp;

        // 3. Set correct name of opp
        String oppName = acc.Name;

        // 4. Get latest opp info
        Opportunity myUpdatedOpp = [SELECT Name FROM Opportunity WHERE Id = :myOpp.Id LIMIT 1];

        // 5. Assert that the NameOpportunity trigger fired
        System.AssertEquals(oppName, myUpdatedOpp.Name);
    }
}