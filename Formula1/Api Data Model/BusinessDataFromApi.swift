//
//  BusinessDataFromApi.swift
//  Formula1
//
//  Created by Osman Balci on 12/5/22.
//

import Foundation

// Global variable to contain the API search results
var foundBusinessList = [ApiBusinessStruct]()

fileprivate var previousQuery = ""

/*
 ================================================
 |   Fetch and Process JSON Data from the API   |
 |   for Books for the Given API Search URL     |
 ================================================
 */
public func getFoundBusinessFromApi(query: String, location: String) {
    
    // Avoid executing this function if already done for the same query URL
    let replacedQuery = query.replacingOccurrences(of: " ", with: "+")
    let replacedLocation = location.replacingOccurrences(of: ", ", with: "+")
    
    var apiUrlString = "";
    if(!query.isEmpty){
        apiUrlString = "https://api.yelp.com/v3/businesses/search?term=\(replacedQuery)&location=\(replacedLocation)"
    }
    else{
        apiUrlString = "https://api.yelp.com/v3/businesses/search?location=\(replacedLocation)"
    }
    
    // Initialize the global variable to contain the API search results
    foundBusinessList = [ApiBusinessStruct]()
    
    /*
     *******************************
     *          API HTTP Headers   *
     *******************************
     */
    let apiHeaders = [
        "accept": "application/json",
        "authorization": "Bearer q3Z6AOimlAUfxbxIJ07YWE_ARQ2bh8UECE9kbApHR20Q3atTququqVrRshnFbAyAGOyUsbNn-WAPi2qmJ1czWMsuvHdTqdpurcebEgE7K4zqsoHDYxor9MLIuh5zY3Yx",
        "cache-control": "no-cache",
        "connection": "keep-alive",
        "host": "api.yelp.com"
    ]
    
    /*
     ***************************************************
     *   Fetch JSON Data from the API Asynchronously   *
     ***************************************************
     */
    var jsonDataFromApi: Data
    
    let jsonDataFetchedFromApi = getJsonDataFromApi(apiHeaders: apiHeaders, apiUrl: apiUrlString, timeout: 10.0)
    if let jsonData = jsonDataFetchedFromApi {
        jsonDataFromApi = jsonData
    } else {
        return
    }
    
    /*
     **************************************************
     *   Process the JSON Data Fetched from the API   *
     **************************************************
     */
    
    do {
        /*
         Foundation framework’s JSONSerialization class is used to convert JSON data
         into Swift data types such as Dictionary, Array, String, Int, Double or Bool.
         */
        let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromApi,
                                                            options: JSONSerialization.ReadingOptions.mutableContainers)
        
        //----------------------------
        // Obtain Top Level Dictionary
        //----------------------------
        var topLevelDictionary = [String: Any]()
        
        if let jsonObject = jsonResponse as? [String: Any] {
            topLevelDictionary = jsonObject
        } else {
            return
        }
        
        //---------------------------------------------------------
        // Obtain "items" Array of JSON Objects Representing Photos
        //---------------------------------------------------------
        var arrayOfResultsJsonObjects = [Any]()
        
        if let jsonArray = topLevelDictionary["businesses"] as? [Any] {
            arrayOfResultsJsonObjects = jsonArray
        } else {
            return
        }

        // Iterate over the arrayOfHitsJsonObjects containing JSON objects representing recipes
        for resultJsonObject in arrayOfResultsJsonObjects {
            
            //-------------------------
            // Obtain Result JSON Object
            //-------------------------
            
            var result = [String: Any]()
            if let jObject = resultJsonObject as? [String: Any] {
                result = jObject
            } else {
                return
            }
            
            //-------------------
            // Obtain latitude
            //-------------------
            
            var latitude = 0.0
            if let coordinateObject = result["coordinates"] as? [String: Any] {
                if let lat = coordinateObject["latitude"] as? Double {
                    latitude = lat
                }
            }
            
            //------------------------
            // Obtain longitude
            //------------------------
            
            var longitude = 0.0
            if let coordinateObject = result["coordinates"] as? [String: Any] {
                if let long_val = coordinateObject["longitude"] as? Double {
                    longitude = long_val
                }
            }
            
            //-----------------------------
            // Obtain Phone Number
            //-----------------------------
            
            var phone = ""
            if let phone_number = result["display_phone"] as? String {
                phone = phone_number
            }
            
            //--------------------------
            // Obtain Image Url
            //--------------------------
            
            var image_url = ""
            if let url = result["image_url"] as? String {
                image_url = url
            }
            
            //--------------------------
            // Obtain Address
            //--------------------------
            
            var address1 = ""
            if let coordinateObject = result["location"] as? [String: Any] {
                if let ad1 = coordinateObject["address1"] as? String {
                    address1 = ad1
                }
            }
            
            var address2 = ""
            if let coordinateObject = result["location"] as? [String: Any] {
                if let ad2 = coordinateObject["address2"] as? String {
                    address2 = ad2
                }
            }
            
            var address3 = ""
            if let coordinateObject = result["location"] as? [String: Any] {
                if let ad3 = coordinateObject["address3"] as? String {
                    address3 = ad3
                }
            }
            
            var city = ""
            if let coordinateObject = result["location"] as? [String: Any] {
                if let city_name = coordinateObject["city"] as? String {
                    city = city_name
                }
            }
            
            var country = ""
            if let coordinateObject = result["location"] as? [String: Any] {
                if let country_name = coordinateObject["country"] as? String {
                    country = country_name
                }
            }
            
            var state = ""
            if let coordinateObject = result["location"] as? [String: Any] {
                if let state_name = coordinateObject["state"] as? String {
                    state = state_name
                }
            }
            
            var zip_code = ""
            if let coordinateObject = result["location"] as? [String: Any] {
                if let zip = coordinateObject["zip_code"] as? String {
                    zip_code = zip
                }
            }
            
            //----------------------------
            // Obtain Business Name
            //----------------------------
            
            var name = ""
            if let business_name = result["name"] as? String {
                name = business_name
            }
            
            //----------------------------
            // Obtain Business Rating
            //----------------------------
            
            var rating = 0.0
            if let business_rating = result["rating"] as? Double {
                rating = business_rating
            }
            
            //----------------------------
            // Obtain Business Review Count
            //----------------------------
            
            var review_count = 0
            if let business_rc = result["review_count"] as? Int {
                review_count = business_rc
            }
            
            //----------------------------
            // Obtain Business Url
            //----------------------------
            
            var url = ""
            if let link = result["url"] as? String {
                url = link
            }
            
            
            //------------------------------------------------------------------------
            // Create an Instance of ApiBookStruct and Append it to foundBooksList
            //------------------------------------------------------------------------
            let foundBusiness = ApiBusinessStruct(id: UUID(), latitude: latitude, longitude: longitude, phone: phone, image_url: image_url, address1: address1, address2: address2, address3: address3, city: city, country: country, state: state, zip_code: zip_code, name: name, rating: rating, review_count: review_count, url: url)
            
            foundBusinessList.append(foundBusiness)
            
        }   // End of for loop
        
    } catch {
        return
    }
    
}
