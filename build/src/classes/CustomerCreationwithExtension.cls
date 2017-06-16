public class CustomerCreationwithExtension {

    public CustomerCreationwithExtension() {

    }



    public String Cust_Name{get;set;}
    public String Cust_Email{get;set;}
    
    
    
    public void ToCreate(){
     Customer__c cust = new Customer__c();
     cust.Name = Cust_Name;
     cust.javaCTI__Contact_Number__c=Cust_Email;
     insert cust;
     
     System.debug('@@@@'+cust.id);
     system.debug('-->'+UserInfo.getProfileId());
     delete cust;
     
    }
}