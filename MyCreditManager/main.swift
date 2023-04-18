
import Foundation

let functions: [String] = ["학생추가", "학생삭제", "성적추가(변경)", "성적삭제", "평점보기"]
let scores: [String: Double] = ["A+": 4.5, "A": 4.0, "B+": 3.5, "B": 3.0, "C+": 2.5, "C": 2.0, "D+": 1.5, "D": 1.0, "F": 0]
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
        //삭제 처리 확인을 위한 bool 변수
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
        
    case "3":
        print("""
        성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.
        입력예) Mickey Swift A+
        만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.
        """)
        let userInput = readLine()!
        let scoreAdding = userInput.components(separatedBy: " ")

        //무입력, 띄어쓰기로 구분된 이름, 과목, 성적 3칸이 모두 입력되었는지 확인
        guard scoreAdding.count == 3, students.contains(where: { student in
            student.name == scoreAdding[0]
        }) else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
            break
        }
        
        guard scores.keys.contains(scoreAdding[2]) else {
            print("유효한 성적을 기입해주세요.")
            break
        }
        
        //이름을 바탕으로 students배열내에 해당 이름이 있는지 재판단후 성적추가
        for (idx, student) in students.enumerated() {
            if student.name == scoreAdding[0] {
                students[idx].subjectScore.updateValue(scoreAdding[2], forKey: scoreAdding[1])
                print("\(scoreAdding[0])학생의 \(scoreAdding[1])과목이 \(scoreAdding[2])로 추가(변경)되었습니다.")
                
                //scoreAverage 재연산 후 저장
                let allScores = students[idx].subjectScore.values
                let stringToScore = allScores.map { scores[$0]! }
                
                students[idx].scoreAverage = stringToScore.reduce(0.0, +) / Double(stringToScore.count)
            }
        }
        
        
        
        
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
