public class countContactHandler {
    public static void insertHandlerMethod(list<contact> newContactList){
        set<Id> accIdSet = new set<Id>();
      	list<account> accToUpdate = new list<account>();
        if(!newContactList.isEmpty()){
        for(contact con : newContactList){
            if(string.isNotBlank(con.AccountId)){
                accIdSet.add(con.AccountId);
            }
        }
        }
        list<AggregateResult> AggregateResult =[select count(Id) totalcontact,accountId accId from contact where accountid in :accIdSet group By accountId];
        for(AggregateResult agg : AggregateResult){
            Id accid = string.valueof(agg.get('accId'));
            integer contactCount = Integer.valueof(agg.get('totalcontact'));
            account acc= new account(id=accid,Number_of_Contacts__c=contactCount);
            accToUpdate.add(acc);
        }
        if(!accToUpdate.isEmpty()){
            update accToUpdate;
        }
    }
    public static void updateHandlerMethod(list<contact> newcontacts, map<id,contact> oldmapofContacts){
       set<id> accIdSet = new set<Id>();
        Map<Id,account> accToUpdate = new map<Id,account>();
        if(!newcontacts.isEmpty()){
            for(contact con : newcontacts){
                if(con.AccountId!=oldmapofContacts.get(con.id).AccountId && string.isNotBlank(con.AccountId)){
                    accIdSet.add(con.AccountId);
                    accIdSet.add(oldmapofContacts.get(con.id).AccountId);
                    
                }
            }
        list<AggregateResult> AggregateResult =[select count(Id) totalcontact,accountId accId from contact where accountid in :accIdSet group By accountId];       
            for(AggregateResult agg : AggregateResult){
            Id accid = string.valueof(agg.get('accId'));
            integer contactCount = Integer.valueof(agg.get('totalcontact'));
            account acc= new account(id=accid,Number_of_Contacts__c=contactCount);
            accToUpdate.Put(accid,acc);
        }
            for(id i :accIdSet ){
                if(accToUpdate.containskey(i)){
                    account acc = new account(id=i,Number_of_Contacts__c=0);
                    accToUpdate.Put(i,acc);
                }
            }
        if(!accToUpdate.isEmpty()){
            update accToUpdate.values();
        }
        }
    }
    public static void deleteHandlerMethod(list<contact> oldcontacts){
        set<Id>accountidset = new set<Id>();
        map<Id,Account> accToUpdate = new Map<Id,account>();
        if(!oldcontacts.isempty()){
            for(contact con : oldcontacts){
                if(string.isNotBlank(con.AccountId)){
                    accountidset.add(con.AccountId);
                }
                     }
        list<AggregateResult> AggregateResult =[select count(Id) totalcontact,accountId accId from contact where accountid in :accountidset group By accountId];       
            for(AggregateResult agg : AggregateResult){
            Id accid = string.valueof(agg.get('accId'));
            integer contactCount = Integer.valueof(agg.get('totalcontact'));
            account acc= new account(id=accid,Number_of_Contacts__c=contactCount);
            accToUpdate.put(accid,acc);
        }
            for(id i :accountidset ){
                if(!accToUpdate.containskey(i)) {
                    account acc = new account(id=i,Number_of_Contacts__c=0);
                    accToUpdate.put(i,acc);
                }               
            }
        if(!accToUpdate.isEmpty()){
            update accToUpdate.values();
        }
                
            }
        }
        
    
    public static void undeleteHandlerMethod(list<contact> newconlactlist){
        set<id>accIdSet = new set<Id>();
        list<account> accToUpdate = new list<account>();
        if(!newconlactlist.isEmpty()){
            for(contact con : newconlactlist){
                if(con.AccountId!=null){
                    accIdSet.add(con.AccountId);
                }
            }
            list<AggregateResult> AggregateResult =[select count(Id) totalcontact,accountId accId from contact where accountid in :accIdSet group By accountId];       
            for(AggregateResult agg : AggregateResult){
            Id accid = string.valueof(agg.get('accId'));
            integer contactCount = Integer.valueof(agg.get('totalcontact'));
            account acc= new account(id=accid,Number_of_Contacts__c=contactCount);
            accToUpdate.add(acc);
        }  
        if(!accToUpdate.isEmpty()){
            update accToUpdate;
        }
        }
    }
}