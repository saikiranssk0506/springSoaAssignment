public class accountHandler {
    @Auraenabled(cacheable=true)
    public static list<account> latestAccountMethod(){
        list<account> acclist = [SELECT Id, Name,Phone, CreatedDate FROM Account ORDER BY CreatedDate DESC LIMIT 10 ];
        return acclist; 
            
    }
}