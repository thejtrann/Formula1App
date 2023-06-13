//
//  WeatherDataFromApi.swift
//  Formula1
//
//  Created by Ryan Tabor on 12/5/22.
//

import Foundation

// Global variable to contain the API search results
var foundWeatherList = [ApiWeatherStruct]()

fileprivate var previousQuery = ""

/*
 ================================================
 |   Fetch and Process JSON Data from the API   |
 |   for Books for the Given API Search URL     |
 ================================================
 */
public func getFoundWeatherFromApi(query: String) {
    
    // Avoid executing this function if already done for the same query URL
    let replacedQuery = query.replacingOccurrences(of: " ", with: "")
    
    var apiUrlString = "https://api.openweathermap.org/data/2.5/forecast?q=\(replacedQuery)&units=imperial&appid=71dd9615cca5cb9eae81a5790a564b8b"
    
    print(apiUrlString)
    // Initialize the global variable to contain the API search results
    foundWeatherList = [ApiWeatherStruct]()
    
    /*
     *************************************
     *   Open Weather API HTTP Headers   *
     *************************************
     */
    
    let apiHeaders = [
        "accept": "application/json",
        "cache-control": "no-cache",
        "connection": "keep-alive",
        "host": "api.openweathermap.org"
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
        
        if let jsonArray = topLevelDictionary["list"] as? [Any] {
            arrayOfResultsJsonObjects = jsonArray
        } else {
            return
        }
        
        var name = ""
        if let cityObj = topLevelDictionary["city"] as? [String: Any]{
            if let title = cityObj["name"] as? String {
                name = title
            }
        }
        
        var latitude = 0.0
        if let cityObj = topLevelDictionary["city"] as? [String: Any]{
            if let title = cityObj["coord"] as? [String:Any] {
                if let location = title["lat"] as? Double {
                    latitude = location
                }
            }
        }
        
        var longitude = 0.0
        if let cityObj = topLevelDictionary["city"] as? [String: Any]{
            if let title = cityObj["coord"] as? [String:Any] {
                if let location = title["lon"] as? Double {
                    longitude = location
                }
            }
        }
        
        var country = ""
        if let cityObj = topLevelDictionary["city"] as? [String: Any]{
            if let title = cityObj["country"] as? String {
                country = title
            }
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
            // Obtain min temp
            //-------------------
            
            var temp_min = 0.0
            if let coordinateObject = result["main"] as? [String: Any] {
                if let min = coordinateObject["temp_min"] as? Double {
                    temp_min = min
                }
            }
            
            //------------------------
            // Obtain max temp
            //------------------------
            
            var temp_max = 0.0
            if let coordinateObject = result["main"] as? [String: Any] {
                if let max = coordinateObject["temp_max"] as? Double {
                    temp_max = max
                }
            }
            
            //-----------------------------
            // Obtain Humidity
            //-----------------------------
            
            var humidity = 0
            if let coordinateObject = result["main"] as? [String: Any] {
                if let hum = coordinateObject["humidity"] as? Int {
                    humidity = hum
                }
            }
            
            //--------------------------
            // Obtain description
            //--------------------------
            
            var description = ""
                
                if let weatherObj = result["weather"] as? [Any] {
                    for i in 0...1 {
                        if(i == 0){
                            if let obj = weatherObj[i] as? [String: Any]{
                                if let desc = obj["description"] as? String {
                                    description = desc
                                }
                                
                            }
                        }
                    }
                }
            
            
            //--------------------------
            // Obtain icon
            //--------------------------
            
            var icon = ""
                
                if let weatherObj = result["weather"] as? [Any] {
                    for i in 0...1 {
                        if(i == 0){
                            if let obj = weatherObj[i] as? [String: Any]{
                                if let ic = obj["icon"] as? String {
                                    icon = ic
                                }
                                
                            }
                        }
                    }
                }
            
            //--------------------------
            // Obtain icon
            //--------------------------
            
            var dt_txt = ""
            
            if let dt = result["dt_txt"] as? String {
                dt_txt = dt
            }
            
            //------------------------------------------------------------------------
            // Create an Instance of ApiBookStruct and Append it to foundBooksList
            //------------------------------------------------------------------------
            let foundWeather = ApiWeatherStruct(id: UUID(), temp_min: temp_min, temp_max: temp_max, humidity: humidity, description: description, icon: icon, dt_txt: dt_txt, name: name, latitude: latitude, longitude: longitude, country: country)
            
            foundWeatherList.append(foundWeather)
            
        }   // End of for loop
        
    } catch {
        return
    }
    
}




