public class SelfRegistrationController {
    public Contact con{get;set;}
    public Account acc;
    public String firstName{get;set;}
    public String lastName{get;set;}
    public String companyName{get;set;}
    public String email{get;set;}
    public String phone{get;set;}
    public String mobile{get;set;}
    public String fax{get;set;}
    public String mailingCity{get;set;}
    public String mailingStreet{get;set;}
    public String mailingState{get;set;}
    public String mailingPostalCode{get;set;}
    public String mailingCountry{get;set;}
    
    public SelfRegistrationController(){
       con = new Contact(); 
       acc = new Account();
    }
    
    public void validationError(){
        if(String.isBlank(lastName) || String.isBlank(email) || String.isBlank(companyName)){
              ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,'Please enter all the mandatory field.'));
        }       
    } 
    public PageReference submit(){
        validationError();
        acc.name = companyName;
        try{
            insert acc;
        }
        catch(Exception e){
             
            /**ApexPages.Message msg = new ApexPages.Message(Apexpages.Severity.ERROR, e.getMessage() );
            ApexPages.addMessage(msg); **/
            return null; 
        }
        con.FirstName = firstName;
        con.LastName = lastName;
        con.Email = email;
        con.AccountId = acc.id;
        con.Phone = phone;
        con.MobilePhone = mobile;
        con.mailingCity= mailingCity;
        con.mailingStreet= mailingStreet;
        con.MailingState= mailingState;
        con.MailingPostalCode= mailingPostalCode;
        con.MailingCountry= mailingCountry;
        try{
            insert con;
        }catch(Exception e){
        
            /** ApexPages.Message msg = new ApexPages.Message(Apexpages.Severity.ERROR, e.getMessage() );
            ApexPages.addMessage(msg); **/
           
            return null;
        }
        pagereference ref = new pageReference('/'+con.id);
        ref.setRedirect(true);
        return ref;
         
    }    

}