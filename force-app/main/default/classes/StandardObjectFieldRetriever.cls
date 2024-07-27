public class StandardObjectFieldRetriever {
    public static void getAllFieldsAndValues() {
        // Get the list of all standard objects
        List<Schema.SObjectType> standardObjects = Schema.getGlobalDescribe().values();
        
        for (Schema.SObjectType sObjectType : standardObjects) {
            Schema.DescribeSObjectResult describeResult = sObjectType.getDescribe();
            
            // Check if the object is standard
            if (!describeResult.isCustom()) {
                String objectName = describeResult.getName();
                System.debug('Object: ' + objectName);
                
                // Get the describe result for the object
                Map<String, Schema.SObjectField> fieldMap = describeResult.fields.getMap();
                
                // Build the SOQL query dynamically
                String query = 'SELECT ';
                for (String fieldName : fieldMap.keySet()) {
                    query += fieldName + ', ';
                }
                query = query.removeEnd(', ') + ' FROM ' + objectName + ' LIMIT 1';
                
                try {
                    // Execute the query
                    SObject sObjectRecord = Database.query(query);
                    
                    // Iterate through the fields and get their values
                    for (String fieldName : fieldMap.keySet()) {
                        Object fieldValue = sObjectRecord.get(fieldName);
                        System.debug('Field: ' + fieldName + ' Value: ' + fieldValue);
                    }
                } catch (Exception e) {
                    System.debug('Error querying object: ' + objectName + ' - ' + e.getMessage());
                }
            }
        }
    }
}