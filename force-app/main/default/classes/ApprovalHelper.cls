public class ApprovalHelper {
    public static void submitForApproval(Id quoteId) {
        // Create an approval request for the quote
        Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
        req.setComments('Submitting quote for approval automatically.');
        req.setObjectId(quoteId);
        
        // Submit the approval request when the quote has sup items
        Approval.ProcessResult result = Approval.process(req);
        
        // Check if the submission was successfully added to quote
        if (result.isSuccess()) {
            System.debug('Quote submitted for approval successfully.');
        } else {
            System.debug('Failed to submit quote for approval.');
        }
    }
}