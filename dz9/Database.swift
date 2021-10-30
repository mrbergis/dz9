//
//  Database.swift
//  dz9
//
//  Created by Андрей Адельбергис on 27.10.2021.
//

import Foundation
import RealmSwift
import CoreData
import UIKit

protocol Database {
    func saveTask(task: String)
    func loadTasks() -> [String]
    func updateTask(currentTask: Int)
    func deleteTask(currentTask: Int)
}


class ItemRealm: Object {
    @objc dynamic var task = ""
    @objc dynamic var taskComplete = false
}

class RealmDatabase {

    static let shared = RealmDatabase()
    
    private let realm = try! Realm()
    private var todoItems: Results<ItemRealm>?
    
    //C
    func saveTask(task: String){
        let item = ItemRealm()
        item.task = task
        try! realm.write {
            realm.add(item)
        }
    }
    //R
    func loadTasks() -> [ItemRealm]{
        let allTasks = realm.objects(ItemRealm.self)
        var itemRealm: [ItemRealm] = []
        for task in allTasks{
            itemRealm.append(task)
        }
        self.todoItems = allTasks
        return itemRealm
    }
    //U
    func updateTask(currentTask: Int){
        if let item = todoItems?[currentTask]{
            try! realm.write {
                item.taskComplete = !item.taskComplete
            }
        }
    }
    //D
    func deleteTask(currentTask: Int){
        if let item = todoItems?[currentTask]{
            try! realm.write {
                realm.delete(item)
            }
        }
    }
    
}

class CoreDataDatabase{
    static let shared =  CoreDataDatabase()
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var itemArray = [ItemCoreData]()
    
    func saveTask(task: String) {
        let newItem = ItemCoreData(context: context)
        newItem.task = task
        saveItems()
    }
    
    func loadTasks() -> [ItemCoreData] {
        let request : NSFetchRequest<ItemCoreData> = ItemCoreData.fetchRequest()
               //NSFetchRequest - будет извлекать резултаты в виде элементов
               //NSFetchRequest<Item> - мы указываем тип данных чтобы точно направить запрос в какую таблицу нам надо
               do{
                   itemArray = try context.fetch(request)//пустой запрос который вытягивает обратно все
               } catch {
                   print("Error fetching data from context \(error)")
               }
//        var allTasksArray: [String] = []
//        for taskString in itemArray{
//            allTasksArray.append(taskString.task!)
//        }
        return itemArray
    }
    
    func updateTask(currentTask: Int){
        itemArray[currentTask].taskComplete = !itemArray[currentTask].taskComplete
        saveItems()
    }
    
    func deleteTask(currentTask: Int) {
        context.delete(itemArray[currentTask])
        saveItems()
    }
    
    func saveItems() {
            do{
                try context.save()
            } catch {
                print("Error saving context \(error)")
            }
    }
}

class WeatherRealm: Object {
    @objc dynamic var city = ""
    @objc dynamic var temp: Double = 0.0
    @objc dynamic var lat: Double = 0.0
    @objc dynamic var lon: Double = 0.0
    let forecast = List<Forecast>()
}

class Forecast: Object {
    @objc dynamic var date: Date?
    @objc dynamic var temp: Double = 0.0
}

class RealmDatabaseWeather {

    static let shared = RealmDatabaseWeather()
    
    private let realm = try! Realm()
    private var weatherItems: WeatherRealm?
    
    func saveWeather() {
        if self.weatherItems != nil {
            deleteWeather()
        }
        
        let weather = WeatherRealm()
        if let weatherData = WeatherLoader.weatherData {
            weather.city = weatherData.name
            weather.temp = weatherData.main.temp
            weather.lat = weatherData.coord.lat
            weather.lon = weatherData.coord.lon
            if let weatherWeekData = WeatherLoader.weatherWeekData {
                for day in weatherWeekData.daily{
                    let forecast = Forecast()
                    forecast.temp = day.temp.day
                    forecast.date = day.dt
                    weather.forecast.append(forecast)
                }
            }
            try! realm.write {
                realm.add(weather)
            }
            weatherItems = weather
        }
    }
    
    func loadWeather() -> Results<WeatherRealm> {
        let weatherResult = realm.objects(WeatherRealm.self)
        self.weatherItems = weatherResult.first
        return weatherResult
    }
    
//    func updateWeather() {
//    }
    
    func deleteWeather() {
        if let wether = weatherItems{
            try! realm.write {
                realm.delete(wether)
            }
            weatherItems = nil
        }
    }
    
    
}
