global class DirectDialNumberController {
    
    Public Contact con;
    Public Contact conObj;
    Public Boolean flag{get;set;} 
    public String userName{get;set;}
    public String phoneNumber;
    public String guid{get;set;}
    public DirectDialNumberController(ApexPages.StandardController stdController) {
        this.con = (Contact)stdController.getRecord();
        selectionOptionMethod();
        uUIDGenetor();
        flag = false;
        phoneNumber = null;
    }
    

    /** public PageReference redirectMethod() {
        
        PageReference pageRef = ApexPages.CurrentPage();
         if(con.id != null){
            Contact conObj = [Select id,phone from contact where id =: con.id ];
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Info,'Dialing Number'+' '+conObj.Phone+'...'));
        }
        return pageRef; 
    } **/
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
        WebServiceCallout.sendNotificationGet(userName,phoneNumber,guid);
        return null;
    }
                
    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>(); 
        if(conObj.phone != null)
        options.add(new SelectOption(conObj.phone,'Phone'+' '+conObj.phone)); 
        if(conObj.MobilePhone != null)
        options.add(new SelectOption(conObj.MobilePhone,'Mobile Phone'+' '+conObj.MobilePhone)); 
        if(conObj.OtherPhone != null)
        options.add(new SelectOption(conObj.OtherPhone,'Other Phone'+' '+conObj.OtherPhone)); 
        return options; 
    }
                   
    public String getphoneNumber() {
        return phoneNumber;
    }
                    
    public void setphoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }

}