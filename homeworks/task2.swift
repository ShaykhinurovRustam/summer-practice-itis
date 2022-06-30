import UIKit

enum PersonType {
    case employee
    case reader
}

enum BookType {
    case classical
    case fantastic
    case dramatic
    case other
}

protocol Readable {
    
}

protocol Read {
    func reading()
}

protocol Work {
    func working()
}

struct ReadingBook: Readable {
    private let _name: String
    private let _type: BookType
    private var _cost: Double
    
    public var name: String {
        get {
            return _name
        }
    }
    
    public var type: BookType {
        get {
            return _type
        }
    }
    
    public var cost: Double {
        get {
            return _cost
        }
        set {
            _cost = newValue
        }
    }
    
    init(name: String, type: BookType, cost: Double) {
        self._name = name
        self._type = type
        self._cost = cost
    }
}

struct AccountingBook: Readable {
    private var _owner: Person
    private var _books = [Readable?]()
    
    init(owner: Person, book: Readable?) {
        self._owner = owner
        self._books.append(book)
    }
    
    public var owner: Person {
        get {
            return _owner
        }
    }
    
    public var books: [Readable?] {
        get {
            return _books
        }
    }
    
    mutating func addBook(book: Readable) {
        _books.append(book)
    }
    
}

struct PersonCard {
    private let _name: String
    private var _type: PersonType
    private var _isValid: Bool
    
    public var name: String {
        get {
            return _name
        }
    }
    
    public var type: PersonType {
        get {
            return _type
        }
        set {
            _type = newValue
        }
    }
    
    public var isValid: Bool {
        get {
            return _isValid
        }
        set {
            _isValid = newValue
        }
    }
    
    init(name: String, type: PersonType, isValid: Bool) {
        self._name = name
        self._type = type
        self._isValid = isValid
        
    }
}

class Person {
    private var _name: String
    private var _type: PersonType
    private var _personCard: PersonCard
    
    public var name: String {
        get {
            return _name
        }
        set {
            _name = newValue
        }
    }
    
    public var type: PersonType {
        get {
            return _type
        }
        set {
            _type = newValue
        }
    }
    
    public var personCard: PersonCard {
        get {
            return _personCard
        }
        set {
            _personCard = newValue
        }
    }
    
    init(name: String, type: PersonType) {
        self._name = name
        self._type = type
        self._personCard = PersonCard(name: name, type: type, isValid: true)
    }
    
    public func aboutMe() {
        print("""
        
        Привет,
        вот моя персональная карточка:
        ИМЯ: \(_personCard.name)
        ТИП: \(_personCard.type)
        ДЕЙСТВИТЕЛЕН: \(_personCard.isValid)
        """
        )
    }
}

class Worker: Person, Work, Read {
    private var _shift: Bool = false
    
    public var shift: Bool {
        get {
            return _shift
        }
        set {
            if (newValue) {
                print("Работник \(name) вышел на смену")
            } else if (!newValue && _shift == true){
                print("Работник \(name) ушел со смены")
            }
            _shift = newValue
        }
    }
    
    init(name: String) {
        super.init(name: name, type: .employee)
    }
    
    public func reading() {
        if (_shift) {
            print("Пока я работаю, я не могу ничего читать")
        } else {
            print("Я читаю газету и осознаю сущность бытия")
        }
        
    }
    
    public func working() {
        if (_shift) {
            print("Я работник — \(name). Я работаю")
        } else {
            print("Я работник — \(name). Я отдыхаю")
        }
    }
    
    override public func aboutMe() {
        super.aboutMe()
        if (_shift) {
            print("Я работаю прямо сейчас, можешь, пожалуйста, меня не отвлекать")
        } else {
            print("Я отдыхаю :)")
        }
    }
}

class Reader: Person, Read {
    private var _book: ReadingBook?
    private var _accountingBook: AccountingBook?
    
    public var book: ReadingBook {
        get {
            return _book!
        }
        set {
            _book = newValue
            _accountingBook?.addBook(book: newValue)
        }
    }
    
    public var accountingBook: AccountingBook? {
        get {
            return _accountingBook
        }
    }
    
    init(name: String, book: ReadingBook?) {
        super.init(name: name, type: .reader)
        _accountingBook = AccountingBook(owner: self, book: book)
        _book = book
        
    }

    public func reading() {
        if (_book != nil) {
            print("Я сейчас читаю \(_book!.name)")
        } else {
            print("Я сейчас ничего не читаю :(")
        }
    }
    
    override public func aboutMe() {
        super.aboutMe()
        if (_book != nil) {
            print("Я читаю прямо сейчас, можешь, пожалуйста, меня не отвлекать")
        }
    }
}

class Cleaner: Worker {
    private var _shift: Bool = false
    
    override public var shift: Bool {
        get {
            return _shift
        }
        set {
            if (newValue) {
                print("Работник \(name) взял метлу и тряпку, и вышел на смену")
            } else if (!newValue && _shift == true){
                print("Работник \(name) ушел со смены")
            }
            _shift = newValue
        }
    }
    
    override public func working() {
        if (_shift) {
            print("Я подметаю полы-ы-ы, убираюсь там и тут, мне хорошо")
        } else {
            print("Я отдыхаю :)")
        }
    }
    
    override public func reading() {
        print("У меня нет времени, чтобы читать книжки")
    }
}

class Security: Worker {
    private var _shift: Bool = false
    
    override public var shift: Bool {
        get {
            return _shift
        }
        set {
            if (newValue) {
                print("Работник \(name) взял газету, надел фуражку и приготовился бесполезно стоять у входа целый день")
            } else if (!newValue && _shift == true){
                print("Работник \(name) ушел со смены")
            }
            _shift = newValue
        }
    }
    
    override public func working() {
        if (_shift) {
            print("Я охраняю, я охраняю. От кого? Сам не знаю")
        } else {
            print("Я отдыхаю :)")
        }
    }
    
    override public func reading() {
        print("Пока я здесь стоял, я успел прочитать все книжки с библиотеки, так что мне нечего больше читать")
    }
}




var book0: ReadingBook = ReadingBook(name: "Мёртвые души", type: .classical, cost: 1.0)
var book1: ReadingBook = ReadingBook(name: "Обломов", type: .classical, cost: 0.5)

var person1: Reader = Reader(name: "Rustam", book: book0)
var person2: Worker = Worker(name: "Andrey")
var person3: Worker = Cleaner(name: "Danil")
var person4: Worker = Security(name: "Kirill")

person1.book.name
person2.shift = true
person3.shift = true
person4.shift = true

person1.aboutMe()
person2.aboutMe()
person3.aboutMe()
person4.aboutMe()

print("\n")

person1.reading()
person2.reading()
person3.reading()

print("\n")

person2.working()
person3.working()
person4.working()

print("\n")

print(person1.accountingBook!.books)
person1.book = book1
print(person1.accountingBook!.books)
