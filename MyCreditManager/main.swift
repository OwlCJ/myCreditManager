
import Foundation

let functions: [String] = ["학생추가", "학생삭제", "성적추가(변경)", "성적삭제", "평점보기"]
var students: [Student] = []

while true {
    showFunctionsList(functions)
    let userFunction = readLine()
    
    if scoreManaging(userFunction) == false {
        break
    }
}

func showFunctionsList(_ functions: [String]) {
    // 기능 리스트 나열
    var functionsList: String = ""
    for (index, function) in functions.enumerated() {
        functionsList += "\(index + 1): \(function), "
    }
    functionsList += "X: 종료"
    
    
    print("원하는 기능을 입력해주세요")
    print(functionsList)
}

func scoreManaging(_ userFunction: String?) -> Bool {
    var loopCheck: Bool = true
    
    switch userFunction {
    case "1":
        print("추가할 학생의 이름을 입력해주세요")
        let addStudent = Student(name: readLine()!)
        
        guard addStudent.name != "" else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
            break
        }
        
        if students.contains(where: { Student in
            Student.name == addStudent.name
        }) {
            print("\(addStudent.name)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
            break
        }
        students.append(addStudent)
        
    case "2":
        var hasStudent = false
        print("삭제할 학생의 이름을 입력해주세요")
        let removeStudent = Student(name: readLine()!)

        guard removeStudent.name != "" else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
            break
        }

        for (idx, student) in students.enumerated() {
            if student.name == removeStudent.name {
                students.remove(at: idx)
                print("\(removeStudent.name)학생을 삭제 하였습니다.")
                hasStudent = true
            }
        }
        
        if hasStudent == false { print("\(removeStudent.name)학생을 찾지 못했습니다.") }
        
        
        
    case "X":
        print("프로그램을 종료합니다...")
        loopCheck = false
        
    default:
        print("뭔가 입력이 잘못되었습니다.  1~5 사이의 숫자 혹은 X를 입력해주세요.")
    }
    
    //debug
    print(students)
    return loopCheck
}
