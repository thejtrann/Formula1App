//
//  DriverDataFromApi.swift
//  Formula1
//
//  Created by Jason Tran and Osman Balci on 11/28/22.
//

import Foundation

// Global variable to contain the API search results
var foundDriverList = [ApiDriverStruct]()
var foundCircuitList = [ApiCircuitStruct]()

fileprivate var previousQuery = ""

/*
 ================================================
 |   Fetch and Process JSON Data from the API   |
 |   for Drivers for the Given API Search URL     |
 ================================================
 */
public func getFoundDriverFromApi(query: String) {
    
    // Avoid executing this function if already done for the same query URL
    //let replacedQuery = query.replacingOccurrences(of: " ", with: "+")
    //let replacedLocation = location.replacingOccurrences(of: ", ", with: "+")
    
    var apiUrlString = "https://api-formula-1.p.rapidapi.com/drivers?search=\(query)"

    // Initialize the global variable to contain the API search results
    foundDriverList = [ApiDriverStruct]()
    
    /*
     *******************************
     *       API HTTP Headers      *
     *******************************
     */
    let apiHeaders = [
        "x-rapidapi-key": "a1dbca2363mshe74a210089bdb42p121d6bjsnb3299dc53ba4"
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
        
        var arrayOfResultsJsonObjects = [Any]()
        
        if let jsonArray = topLevelDictionary["response"] as? [Any] {
            arrayOfResultsJsonObjects = jsonArray
        } else {
            return
        }
        
        // Iterate over the arrayOfHitsJsonObjects containing JSON objects representing recipes
        for resultJsonObject in arrayOfResultsJsonObjects {
            
            //-------------------------
            // Obtain JSON Object
            //-------------------------
            
            var result = [String: Any]()
            if let jObject = resultJsonObject as? [String: Any] {
                result = jObject
            } else {
                return
            }
            
            //-------------------
            // Obtain name
            //-------------------
            
            var name = ""
            if let dName = result["name"] as? String{
                name = dName
            }
            
            //-------------------
            // Obtain image Url
            //-------------------
            
            var image = ""
            if let link = result["image"] as? String{
                image = link
            }
            
            //-------------------
            // Obtain nationality
            //-------------------
            
            var nationality = ""
            if let nation = result["nationality"] as? String{
                nationality = nation
            }
            
            //-------------------
            // Obtain birth date
            //-------------------
            
            var birthdate = ""
            if let dob = result["birthdate"] as? String{
                birthdate = dob
            }
            
            //-------------------
            // Obtain birth place
            //-------------------
            
            var birthplace = ""
            if let pob = result["birthplace"] as? String{
                birthplace = pob
            }
            
            //-------------------
            // Obtain driver number
            //-------------------
            
            var number = Int32()
            if let num = result["number"] as? Int32 {
                number = num
            }
            
            //-------------------
            // Obtain podiums
            //-------------------
            
            var podiums = Int32()
            if let dPod = result["podiums"] as? Int32 {
                podiums = dPod
            }
            
            //------------------------------------------------------------------------
            // Create an Instance of ApiDriverStruct and Append it to foundDriverList
            //------------------------------------------------------------------------
            let foundDriver = ApiDriverStruct(id: UUID(), name: name, url: image, nationality: nationality, birthdate: birthdate, birthplace: birthplace, number: number, podiums: podiums)
            
            foundDriverList.append(foundDriver)
            
        }   // End of for loop
        
    } catch {
        return
    }
    
}

/*
 ================================================
 |   Fetch and Process JSON Data from the API   |
 |   for Circuits for the Given API Search URL     |
 ================================================
 */
public func getFoundCircuitsFromApi(query: String) {
    
    // Avoid executing this function if already done for the same query URL
    //let replacedQuery = query.replacingOccurrences(of: " ", with: "+")
    //let replacedLocation = location.replacingOccurrences(of: ", ", with: "+")
    
    var apiUrlString = "https://api-formula-1.p.rapidapi.com/circuits?search=\(query)"

    // Initialize the global variable to contain the API search results
    foundDriverList = [ApiDriverStruct]()
    
    /*
     *******************************
     *       API HTTP Headers      *
     *******************************
     */
    let apiHeaders = [
        "x-rapidapi-key": "a1dbca2363mshe74a210089bdb42p121d6bjsnb3299dc53ba4"
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
        
        var arrayOfResultsJsonObjects = [Any]()
        
        if let jsonArray = topLevelDictionary["response"] as? [Any] {
            arrayOfResultsJsonObjects = jsonArray
        } else {
            return
        }
        
        // Iterate over the arrayOfHitsJsonObjects containing JSON objects representing recipes
        for resultJsonObject in arrayOfResultsJsonObjects {
            
            //-------------------------
            // Obtain JSON Object
            //-------------------------
            
            var result = [String: Any]()
            if let jObject = resultJsonObject as? [String: Any] {
                result = jObject
            } else {
                return
            }
            
            //-------------------
            // Obtain name
            //-------------------
            
            var name = ""
            if let dName = result["name"] as? String{
                name = dName
            }
            
            //-------------------
            // Obtain image Url
            //-------------------
            
            var image = ""
            if let link = result["image"] as? String{
                image = link
            }
            
            //-------------------
            // Obtain competition
            //-------------------
            
            var competition = ""
            if let recordJsonObject = result["competition"] as? [String: Any] {
                if let comp = recordJsonObject["name"] as? String {
                    competition = comp
                }
            }
            
            //-------------------
            // Obtain country
            //-------------------
            
            var country = ""
            if let recordJsonObject = result["competition"] as? [String: Any] {
                if let locationJsonObject = recordJsonObject["location"] as? [String: Any]{
                    if let coun = locationJsonObject["country"] as? String {
                        country = coun
                    }
                }
            }
            
            //-------------------
            // Obtain city
            //-------------------
            
            var city = ""
            if let recordJsonObject = result["competition"] as? [String: Any] {
                if let locationJsonObject = recordJsonObject["location"] as? [String: Any]{
                    if let cit = locationJsonObject["city"] as? String {
                        city = cit
                    }
                }
            }
            
            //-------------------
            // Obtain first GP
            //-------------------
            
            var firstGp = Int32()
            if let gp = result["first_grand_prix"] as? Int32 {
                firstGp = gp
            }
            
            //-------------------
            // Obtain laps
            //-------------------
            
            var laps = Int32()
            if let numLaps = result["laps"] as? Int32 {
                laps = numLaps
            }
            
            //-------------------
            // Obtain record
            //-------------------
            
            var recordTime = ""
            if let recordJsonObject = result["lap_record"] as? [String: Any] {
                if let rTime = recordJsonObject["time"] as? String {
                    recordTime = rTime
                }
            }
            
            var recordHolder = ""
            if let recordJsonObject = result["lap_record"] as? [String: Any] {
                if let rHolder = recordJsonObject["driver"] as? String {
                    recordHolder = rHolder
                }
            }
            
            var recordYear = ""
            if let recordJsonObject = result["lap_record"] as? [String: Any] {
                if let rYear = recordJsonObject["year"] as? String {
                    recordYear = rYear
                }
            }
            
            //------------------------------------------------------------------------
            // Create an Instance of ApiDriverStruct and Append it to foundDriverList
            //------------------------------------------------------------------------
            let foundCiruit = ApiCircuitStruct(id: UUID(), name: name, image: image, competition: competition, country: country, city: city, firstGp: firstGp, laps: laps, recordTime: recordTime, recordHolder: recordHolder, recordYear: recordYear)
            
            foundCircuitList.append(foundCiruit)
            
        }   // End of for loop
        
    } catch {
        return
    }
    
}
