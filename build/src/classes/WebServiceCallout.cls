global class WebServiceCallout {

   /** @future (callout=true)
   
    public static void sendNotification(String username) {
         //,String UUID,String phoneNumber
         //folionum='484307021840';
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http = new Http();
        req.setHeader('content-type', 'application/json; charset=utf-8');
        req.setEndpoint('http://localhost:8080/atmosphere-pubsub/hello');
        //req.setEndpoint('https://apexrest/');
        req.setMethod('POST');
        req.setTimeout(60000);
        //req.setBody('info='+EncodingUtil.urlEncode(folionum, 'UTF-8'));
        System.debug(username+'username');
        req.setBody('username'+username);
         String jsonData = res.getBody();
        req.setCompressed(true); // otherwise we hit a limit of 32000
        System.debug('Request Body --'+req.getBody());
        System.debug(res.toString());
        System.debug('STATUS:'+res.getStatus());
        System.debug('STATUS_CODE:'+res.getStatusCode());    
        try
         {
              res = http.send(req);
          }catch(System.CalloutException e)
           {
             System.debug('Callout error: '+ e);
             System.debug(res.toString());
           }

    }**/
    public static HttpResponse res = new HttpResponse();
    @future (callout=true)
    
    public static void sendNotificationGet(String username,String contactNumber,String uUID,String loginUserId,Id conId) {
         //,String UUID,String phoneNumber
         //folionum='484307021840';
        HttpRequest req = new HttpRequest();
        
        Http http = new Http();
        //req.setHeader('content-type', 'application/json; charset=utf-8');
        //req.setEndpoint('http://localhost:8080/atmosphere-pubsub/'+username+'/subscribeAndUsingExternalThread');
       
        contactNumber = contactNumber.replace('+', '');
        req.setEndpoint('http://59.161.177.216:8080/sfdc-cti/'+contactNumber+'/initiateCall');
        //req.setEndpoint('http://180.151.15.236:1055/atmosphere-pubsub/'+username+'/'+contactNumber+'/'+uUID+'/subscribeAndUsingExternalThread');
        //req.setEndpoint('https://www.google.com');
        
        req.setMethod('GET');
        //req.setTimeout(60000);
        
        try
         {   
              res = http.send(req);
              System.debug(res.getBody());
              
              IF(conId != NULL){
                  RedirectPageController redirectpageObj = new RedirectPageController(new ApexPages.StandardController(new Contact(Id = conId)));
                  redirectpageObj.logACall();
              }
              
          }catch(System.CalloutException e)
           {
             System.debug('Callout error: '+ e);
             System.debug(res.toString());
           }

    }
 }