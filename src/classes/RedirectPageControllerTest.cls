@isTest(seealldata = true)
public class RedirectPageControllerTest
{
  public Contact[] contactsToCreate = new Contact[]{};  
  public void testData()
  {      
         
        // Now use the FOR loop- iteration using a variable
        for(Integer x=0; x<1; x++)
        {
            // Now associate the Contact with the Account using the Id.
            Contact ctc = new Contact(lastname='Rao'+x,phone='917838251746');
            contactsToCreate.add(ctc);
            // Now insert the above Contacts
            insert contactsToCreate;
        }
      
  }
      static testMethod void testCallout() {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        RedirectPageControllerTest rePageObj = new RedirectPageControllerTest();
        rePageObj.testData();
        // Call method to test.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
         RedirectPageController redirectObj = new RedirectPageController(new ApexPages.StandardController(new Contact(Id = rePageObj.contactsToCreate[0].id)));
         WebServiceCallout.sendNotificationGet(redirectObj.userName,redirectObj.conObj.phone,redirectObj.guid,redirectObj.loginUserId,redirectObj.con.id);
         //redirectObj.dialingNumber();
        // Verify response received contains fake values
        String contentType = WebServiceCallout.res.getHeader('Content-Type');
        //System.assert(contentType == 'application/json');
        //String actualValue = WebServiceCallout.res.getBody();
        //String expectedValue = '{"foo":"bar"}';
        //System.assertEquals(actualValue, expectedValue);
        //System.assertEquals(200, WebServiceCallout.res.getStatusCode());
    }

}