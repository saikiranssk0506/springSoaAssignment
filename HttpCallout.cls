public class HttpCallout {
    public static void makecallout(){
        Http Http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:callApi/get?foo1=bar1&foo2=bar2');
        request.setMethod('GET');
        try {
            HttpResponse response = http.send(request);
            if (response.getStatusCode() == 200) {
                String responseBody = response.getBody();
                System.debug('Response Body: ' + responseBody);
                
            } else {
                System.debug('HTTP request failed with status code: ' + response.getStatusCode());
            }
        } catch (Exception e) {
            System.debug('Exception occurred: ' + e.getMessage());
        }
    }
}