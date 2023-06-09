pragma solidity ^0.4.17;

contract StudentRecord {
    
    struct Student {
        string name;
        uint age;
        uint rollNumber;
        string department;
    }
    
    struct MarkSheet {
        uint markSheetID;
        uint studentID;
        uint subject1marks;
        uint subject2marks;
        uint subject3marks;
        uint subject4marks;
    
    }
    
    struct Attendance {
        uint attendanceID;
        uint studentID;
        uint date;
        string status;
    }
    
    struct Teacher {
        string name;
        string email;
        string phoneNumber;
    }

    struct Subject {
        uint subjectID;
        uint semester;
        string name1;
        uint credit1;
        string name2;
        uint credit2;
        string name3;
        uint credit3;
        string name4;
        uint credit4;
    }
   
    
    mapping(uint => Student) public students;
    mapping(uint => MarkSheet[]) public markSheets;
    mapping(uint => Attendance[]) public attendanceRecords;
    mapping(address => Teacher) public teachers;
    mapping(uint => Subject) public subjects;
    
    
    uint public studentCount;
    uint public markSheetCount;
    uint public attendanceCount;
    uint public subjectCount;
    
    
    constructor() public {
        // Initialize the counts

        studentCount = 0;
        markSheetCount = 0;
        attendanceCount = 0;
        subjectCount = 0;
    }
    
    function addStudent(string _name, uint _age, uint _rollNumber, string _department) public {
        studentCount++;
        students[studentCount] = Student(_name, _age, _rollNumber, _department);
    }
    
    function addMarkSheet(uint _studentID,  uint _subject1marks, uint _subject2marks, uint _subject3marks, uint _subject4marks) public {
        require(_studentID <= studentCount, "Invalid student ID");
        markSheetCount++;
        markSheets[_studentID].push(MarkSheet(markSheetCount, _studentID, _subject1marks,_subject2marks, _subject3marks, _subject4marks));
    }
    
    function addAttendance(uint _studentID, uint _date, string _status) public {
        require(_studentID <= studentCount, "Invalid student ID");
        attendanceCount++;
        attendanceRecords[_studentID].push(Attendance(attendanceCount, _studentID, _date, _status));
    }
    
    function addTeacher(string _name, string _email, string _phoneNumber) public {
        require(bytes(teachers[msg.sender].name).length == 0, "Teacher already exists");
        teachers[msg.sender] = Teacher(_name, _email, _phoneNumber);
    }

    function addSubject(uint _semester, string _name1, uint _credit1, string _name2, uint _credit2, string _name3, uint _credit3, string _name4, uint _credit4) public {
        subjectCount++;
        subjects[subjectCount] = Subject(subjectCount, _semester, _name1, _credit1, _name2, _credit2, _name3, _credit3, _name4, _credit4);
    }
    
    function getStudent(uint _rollNumber) public view returns (string, uint, uint, string) {
        require(_rollNumber <= studentCount, "Invalid roll number");
        Student storage student = students[_rollNumber];
        return (student.name, student.age, student.rollNumber, student.department);
    }
    
    function getMarkSheet(uint _studentID, uint _markSheetID) public view returns (uint,uint,uint,uint,uint) {
        require(_studentID <= studentCount, "Invalid student ID");
        MarkSheet[] storage markSheetArr = markSheets[_studentID];
        require(_markSheetID <= markSheetArr.length, "Invalid mark sheet ID");
        MarkSheet storage markSheet = markSheetArr[_markSheetID - 1];
        return (markSheet.markSheetID, markSheet.subject1marks, markSheet.subject2marks, markSheet.subject3marks, markSheet.subject4marks);
    }
    
    function getAttendance(uint _studentID, uint _attendanceID) public view returns (uint, uint, string) {
        require(_studentID <= studentCount, "Invalid student ID");
        Attendance[] storage attendanceArr = attendanceRecords[_studentID];
        require(_attendanceID <= attendanceArr.length, "Invalid attendance ID");
        Attendance storage attendance = attendanceArr[_attendanceID - 1];
        return (attendance.attendanceID, attendance.date, attendance.status);
    }
    
    function getTeacher(address _teacherAddress) public view returns (string, string, string) {
        Teacher storage teacher = teachers[_teacherAddress];
        return (teacher.name, teacher.email, teacher.phoneNumber);
    }
    
    function getSubject(uint _subjectID) public view returns (uint, uint, string, uint, string, uint, string, uint, string, uint) {
        require(_subjectID <= subjectCount, "Invalid subject ID");
        Subject storage subject = subjects[_subjectID];
        return (subject.subjectID, subject.semester, subject.name1, subject.credit1, subject.name2, subject.credit2, subject.name3, subject.credit3, subject.name4, subject.credit4);
    }
}