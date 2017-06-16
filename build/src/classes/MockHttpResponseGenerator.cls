@isTest
global class MockHttpResponseGenerator implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        RedirectPageControllerTest rePageObj = new RedirectPageControllerTest();
        rePageObj.testdata();
         RedirectPageController redirectObj = new RedirectPageController(new ApexPages.StandardController(new Contact(Id = rePageObj.contactsToCreate[0].id)));
        System.assertEquals('http://14.98.40.94:8080/sfdc-cti/'+redirectObj.conObj.phone+'/initiateCall', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"foo":"bar"}');
        res.setStatusCode(200);
        return res;
    }
}