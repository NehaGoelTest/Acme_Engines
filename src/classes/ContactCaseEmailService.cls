global class ContactCaseEmailService implements Messaging.InboundEmailHandler{

    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,

    Messaging.InboundEnvelope envelope){

         case caseObj;

            list<contact> conlist = [Select id,Email,AccountId from contact where Email =: email.fromAddress];

            if(conlist != null && !conlist.isEmpty()){

                contact conObj = conlist[0];

                 caseObj = new case(Contactid = conObj.id,Status='New',Priority='Medium',Accountid=conObj.AccountId,Origin='Email',Subject=email.subject,Description=email.plainTextBody);

            }else{

                contact newConObj = new contact(Email=email.fromAddress,AccountId='0012800000JVhGXAA1',LastName='Algoworks ltd');

                try{

                    insert newConObj;   

                }catch (exception e){

                    system.debug(e);

                }

                 caseObj = new case(Contactid = newConObj.id,Status='New',Priority='Medium',Accountid='0012800000JVhGXAA1',Origin='Email',Subject=email.subject,Description=email.plainTextBody);

            }

            try{

                    insert caseObj; 

                }catch (exception e){

                    system.debug(e);

                }
           Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
           return result;

    }

}