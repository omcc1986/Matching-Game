import UIKit

//list of interests
enum Interest: String {
    case gaming
    case swimming
    case philosophy
    case documentaries = "watching documentaries"
    case cycling
    case painting
    case podcasts
    case gardening
    case socialising
    case travelling
    case climbing
    case lifedrawing = "life drawing"
    case boxing
    case photography
    case chess
    case cooking
    case reading
}

//list of characteristics
enum Characteristics: String {
    case age
    case hometown
}

struct Person {
    //properties
    let name: String
    let characteristics: [Characteristics: AnyHashable]
    var interest: [Interest]
}

extension Person: Hashable{}

class matchingAlgo {
    // list of people and their characteristics and interests
    var people = [Person]()
    var persons = [
       
        Person(name: "Jack", characteristics: [.age: 31, .hometown: "Canterbury"], interest: [ .painting, .socialising, .cooking, .travelling, .documentaries, .cycling, .climbing]),
        Person(name: "Rowan", characteristics: [.age: 28, .hometown: "Illford"], interest: [.climbing, .socialising, .lifedrawing, .boxing, .cycling, .painting, .chess]),
        Person(name: "Lindsey", characteristics: [.age: 27, .hometown: "Glasgow"], interest: [ .photography, .lifedrawing, .boxing, .chess, .climbing, .cycling, .painting]),
        Person(name: "John", characteristics: [.age: 28, .hometown: "Liverpool"], interest: [.climbing, .cooking, .photography, .chess, .gardening, .boxing, .cycling]),
        Person(name: "Matthew", characteristics: [.age: 33, .hometown: "London"], interest: [.gaming, .socialising, .swimming, .podcasts, .travelling, .philosophy, .cycling]),
        Person(name: "Jane", characteristics: [.age: 37, .hometown: "London"], interest: [.gaming, .swimming, .reading, .lifedrawing, .chess, .cycling, .cooking]),
        Person(name: "Sophie", characteristics: [.age: 36, .hometown: "Brighton"], interest: [ .swimming, .reading, .chess, .cooking,.climbing, .lifedrawing, .gardening]),
         Person(name: "Sam", characteristics: [.age: 32, .hometown: "Preston"], interest: [.swimming, .reading, .chess, .lifedrawing, .chess, .cycling, .documentaries]),
           Person(name: "Bob", characteristics: [.age: 32, .hometown: "Preston"], interest: [.socialising, .cooking, .podcasts, .lifedrawing, .travelling, .cycling, .painting]),
        Person(name: "Roxy", characteristics: [.age: 32, .hometown: "Canterbury"], interest: [.swimming, .socialising, .cooking, .podcasts, .boxing, .travelling, .documentaries])]
    

    static let shared = matchingAlgo()
    
    //initialization
    private init() {
    
        // get random number of persons between 2 and 10 and add it to the people list
        var i = Int.random(in: 2...persons.count)
        while i % 2 != 0 {
            i = Int.random(in: 2...persons.count)
        }
        
        people.append(contentsOf: persons.prefix(i))
        print("Adding \(i) people")
    }

    //Participants will introduce themselves one by one.
    func introduction() {
        for a in people {
            print("Hello, my name is \(a.name), I'm \(a.characteristics[.age] as? Int ?? 0) years old, from \(a.characteristics[.hometown] as? String ?? "unkonwn").")
        }
    }
   
//randomly nominate a participant to share their interests.
    func announceInterest() {
        let list = people
        
        let comments  = [
            " it helps me relax",
            " it helps me to become more inspired",
            " which helps me to clear my mind",
            " It reminds me of the good old time",
            " is a fun activity",
            " is an activity I like to do with friends",
            " which helps keeps me open-minded",
            " which helps to broaden my knowledge",
            " I've liked it since my childhood",
            " It helps me to take a break",
            " I can relieve my stress with this activity"
        ]
        
        for a in list {
            var string = "Hello again, my name is \(a.name) and my interests are"
            for b in a.interest {
                if a.interest.first! .rawValue == b.rawValue{
                    string.append(" \(b.rawValue)\((comments.randomElement()!))")
                } else if a.interest.last!.rawValue == b.rawValue {
                    string.append(", and \(b.rawValue)\((comments.randomElement()!)).")
                } else {
                    string.append(", \(b.rawValue)\((comments.randomElement()!))")
                }
            }
            
            
            print(string)
        }
    }

    
//  Nominated person's shared interests are compared to other people in theduplicatePeopleList, matching is made on the amount of different interests
    func match() {
        var duplicatePeopleList = people
        while duplicatePeopleList.count != 0 {
            let q = duplicatePeopleList.removeFirst()
            var w = [Person: Int]()
            for i in duplicatePeopleList {
                let h: (person: Person, dif: Int) = getDif (in: q, personTwo: i)
                w[h.person] = h.dif
            }
            var x = [Person]()
            var y = 0
            
            for k in w {
                if k.value > y {
                    y = k.value
                    x.append(k.key)
                }
            }
           
            print("\(q.name) is being paired with \(x.first!.name)")
             if y == 0 {
                print("they are a perfect match as they have \(y) shared interests!")
            } else if y == 1 {
                print("they are a strong match as they only have \(y) shared interests.")
            } else if y == 2 {
                print("they are a good match with only \(y) corresponding interests.")
            } else if y == 3 {
                print("they are an ok match they share \(y) interests and 4 differing interests.")
             } else if y == 4 {
                print ("they have a total of \(y) shared interests so are unlikely to have a great deal to learn from each other")
             } else if y == 5 {
                print ("they have \(y) shared interest, so are not a good match to share different interests with one another.")
            }
                duplicatePeopleList.remove(at: duplicatePeopleList.firstIndex(of:x.first!)!)
        }
    }

  
    func getDif(in personOne: Person, personTwo: Person) ->
        (Person, Int) {
        let g = personOne.interest
        var t = 0
        for f in personTwo.interest {
        if g.contains(f) {
                t += 1
           
        }
        }
        return (personTwo, 0 + t)
            
    }
    
}
        
matchingAlgo.shared.introduction()
print("--")
matchingAlgo.shared.announceInterest()
print("--")
matchingAlgo.shared.match()
