trigger QuoteTrigger on SBQQ__Quote__c (after insert, after update) {
    for (SBQQ__Quote__c q : Trigger.new) {
        if (q.Has_Sub_Items__c) { // Assuming Has_Sub_Items__c is a checkbox field indicating sub-items
            ApprovalHelper.submitForApproval(q.Id);
        }
    }
}