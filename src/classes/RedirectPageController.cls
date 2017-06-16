global class RedirectPageController {
    
    Public Contact con;
    Public Contact conObj;
    Public Boolean flag{get;set;} 
    public String userName{get;set;}
    public String phoneNumber;
    public String guid{get;set;}
    public string loginUserId{get;set;}
    
    public RedirectPageController(ApexPages.StandardController stdController) {
        this.con = (Contact)stdController.getRecord();
        selectionOptionMethod();
        uUIDGenetor();
        flag = false;
        phoneNumber = null;
        loginUserId = UserInfo.getUserId();
       
    }
    

   
    public void uUIDGenetor() {
        Blob b = Crypto.GenerateAESKey(128);
        String h = EncodingUtil.ConvertTohex(b);
        guid = h.SubString(0,8)+ '-' + h.SubString(8,12) + '-' + h.SubString(12,16) + '-' + h.SubString(16,20) + '-' + h.substring(20);
        system.debug('guid-->'+guid);
        userName = UserInfo.getUserName();
        system.debug('userName-->'+userName);
           
    }
    public void selectionOptionMethod() {
        conObj = new Contact();
       // PageReference pageRef = ApexPages.CurrentPage();
         if(con.id != null){
            conObj = [Select id,phone,MobilePhone,OtherPhone from contact where id =: con.id ];
            
        }
        //return pageRef; 
    }
    
    
    
    
     public PageReference dialingNumber() {
        flag = true;
        //WebServiceCallout.sendNotification(userName);
        phoneNumber = conObj.phone;
        WebServiceCallout.sendNotificationGet(userName,phoneNumber,guid,loginUserId,con.id);
        
        SalesforceDialerController salesDialObj = new SalesforceDialerController();
        salesDialObj.updateDialerWithButtonClick(phoneNumber);
        
        PageReference redirectVar = new PageReference('/'+con.id+'?phoneNumber='+conObj.phone);
        redirectVar.setRedirect(true);
        return redirectVar; 
        //return null;
       
    }
    
    public PageReference logACall(){
        Task logACall = new Task();
        logACall.Subject = 'Call';
        logACall.Status = 'Completed';
        logACall.Priority = 'Normal';
        logACall.TaskSubtype = 'Call';
        logACall.WhoId = con.id;
        //logACall.javaCTI__Call_Start_Time__c =
        //logACall.javaCTI__Call_End_Time__c
        //logACall.Phone = conObj.phone;
        //logACall.Assigned To = ;
        insert logACall;
        System.debug('logACall--'+logACall);
        return null;
    }
                
   }