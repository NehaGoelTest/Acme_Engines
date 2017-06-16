public class SalesforceDialerController {

    public String userName{get;set;}
    public String phoneNumber{get;set;}
     public Id id{get;set;}
     
    public String checkIn{get;set;}
    public String guid{get;set;}
    public string loginUserId{get;set;}
    public Contact conObj{get;set;}
    
    public SalesforceDialerController() {
        
        loginUserId = UserInfo.getUserId(); 
        id = System.currentPageReference().getParameters().get('Id');
        checkIn = id;
        
        uUIDGenetor();
        if(id != null)
        phoneNumber();
        this.phoneNumber = conObj.phone;
        system.debug('url--'+phoneNumber);
    }
    
    public void uUIDGenetor() {
        Blob b = Crypto.GenerateAESKey(128);
        String h = EncodingUtil.ConvertTohex(b);
        guid = h.SubString(0,8)+ '-' + h.SubString(8,12) + '-' + h.SubString(12,16) + '-' + h.SubString(16,20) + '-' + h.substring(20);
        system.debug('guid-->'+guid);
        userName = UserInfo.getUserName();
        system.debug('userName-->'+userName);
        
         conObj = new Contact();
       
         if(id != null){
            conObj = [Select id,phone,MobilePhone,OtherPhone from contact where id =: id ];
            
        }
           
    }
    
     public PageReference dialerDialingNumber(){  
        system.debug('phoneNumber-->'+phoneNumber);
        WebServiceCallout.sendNotificationGet(userName,phoneNumber,guid,loginUserId,NULL);
        //PageReference redirectVar = new PageReference('/'+con.id);
        //redirectVar.setRedirect(true);
        //return redirectVar;
       return null;
    }
    public string callfunc{get;set;}
    public void updateDialerWithButtonClick(String phoneNumber){
        callfunc = '<script> updateDialer(); </script>';
    }
    
    public string phoneNumber(){
        phoneNumber = apexpages.currentpage().getparameters().get('phoneNumber');
        system.debug('phoneNumber--'+phoneNumber);
        return phoneNumber;

    }
    
}