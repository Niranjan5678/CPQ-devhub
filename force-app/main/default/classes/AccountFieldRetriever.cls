public class AccountFieldRetriever {
    public static void getAllFieldsAndValues(Id accountId) {
        // Get the describe result for the Account object
        Map<String, Schema.SObjectField> fieldMap = Schema.SObjectType.Account.fields.getMap();
        
        // Build the SOQL query dynamically
        String query = 'SELECT ';
        for (String fieldName : fieldMap.keySet()) {
            query += fieldName + ', ';
        }
        //soql 
        query = query.removeEnd(', ') + ' FROM Account WHERE Id = :accountId';
        
        // Execute the query
        Account acc = Database.query(query);
        
        // Iterate through the fields and get their values check 29/07
        for (String fieldName : fieldMap.keySet()) {
            Object fieldValue = acc.get(fieldName);
            System.debug('Field: ' + fieldName + ' Value: ' + fieldValue);
        }
    }
}