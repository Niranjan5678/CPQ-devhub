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
                
                // Get the describe result for the objects fields
                Schema.DescribeFieldResult describeFieldResult = sObjectType.getDescribe().fields.getMap().get('Name').getDescribe();
                
                // Check if the object has a name field
                if (describeFieldResult.isNameField()) {
                    String fieldName = describeFieldResult.getName();
                    System.debug('Name Field: ' + fieldName);
                }
                Map<String, Schema.SObjectField> fieldMap = describeResult.fields.getMap();
                
                // Build the SOQL query dynamicallyti fecth details
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