# Teacher Subject Assignment System

## Overview
This system allows administrators to assign teachers to specific subjects and grades, managing teaching schedules and tracking assignments efficiently.

## Database Schema

### Table: teacher_subject_assignments
```sql
CREATE TABLE `teacher_subject_assignments` (
  `assignment_id` int(11) NOT NULL AUTO_INCREMENT,
  `teacher_id` int(11) NOT NULL,
  `subject` varchar(100) NOT NULL,
  `grade` varchar(20) NOT NULL,
  `schedule` varchar(255) DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `date_assigned` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`assignment_id`),
  KEY `teacher_id` (`teacher_id`),
  KEY `idx_subject_grade` (`subject`, `grade`),
  CONSTRAINT `fk_teacher_assignment` FOREIGN KEY (`teacher_id`) 
    REFERENCES `teachers` (`teacher_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
```

## Model Classes

### TeacherSubjectAssignment.java
- Represents the assignment relationship between teachers and subjects
- Includes schedule and remarks for additional information
- Provides utility methods for conflict detection and string representation

### Key Fields:
- `assignmentId`: Unique identifier for the assignment
- `teacherId`: Reference to the teacher
- `subject`: Subject being taught
- `grade`: Grade level
- `schedule`: Class timing information
- `remarks`: Additional notes
- `dateAssigned`: When the assignment was created
- `isActive`: Whether the assignment is currently active

## DAO Layer

### TeacherSubjectAssignmentDAO.java
Provides comprehensive database operations:

#### Core Methods:
- `assignTeacherToSubject()`: Create new assignments
- `assignmentExists()`: Check for duplicate assignments
- `getAssignmentsByTeacher()`: Get all assignments for a teacher
- `getAllAssignments()`: Get all active assignments
- `updateAssignment()`: Modify existing assignments
- `removeAssignment()`: Soft delete assignments
- `getAssignmentCountByTeacher()`: Count teacher's assignments
- `getAllActiveTeachers()`: Get teachers available for assignment
- `getAssignmentsBySubjectAndGrade()`: Filter by subject and grade

#### Key Features:
- Prevents duplicate assignments (same teacher, subject, grade)
- Supports soft deletion (maintains history)
- Includes teacher names in assignment queries for UI display
- Provides comprehensive error handling

## User Interface

### ClassReg.form / ClassReg.java
Teacher Subject Assignment Form with:

#### Left Panel - Assignment Form:
- **Teacher Selection**: Dropdown with active teachers
- **Subject**: Comprehensive subject list (Mathematics, English, Science, etc.)
- **Grade**: Grade 1-12 selection
- **Schedule**: Free text for timing (e.g., "Mon-Wed-Fri 9:00-10:00")
- **Remarks**: Multi-line notes field

#### Right Panel - Information Display:
- **Current Assignments**: List of teacher's existing assignments
- **Assignment Counter**: Total number of assignments
- **Real-time Updates**: Refreshes when teacher selection changes

#### Action Buttons:
- **Assign**: Create the new assignment
- **Clear**: Reset form fields
- **Cancel**: Close the form

## Backend Implementation

### Key Features:
1. **Form Validation**: Ensures all required fields are selected
2. **Duplicate Prevention**: Checks for existing assignments before creation
3. **Real-time Updates**: Assignment list updates when teacher is selected
4. **Placeholder Text**: User-friendly input guidance
5. **Error Handling**: Comprehensive exception handling with user feedback

### Event Handling:
- Teacher selection triggers assignment list refresh
- Focus events manage placeholder text
- Button actions with proper validation

## Testing Utilities

### AssignmentTestUtil.java
Comprehensive testing utility that:
- Tests database connectivity
- Verifies CRUD operations
- Tests filtering functionality
- Provides system information for debugging

## Usage Workflow

1. **Select Teacher**: Choose from dropdown of active teachers
2. **Choose Subject**: Select from predefined subject list
3. **Select Grade**: Choose appropriate grade level
4. **Enter Schedule**: Add timing information (optional)
5. **Add Remarks**: Include any additional notes (optional)
6. **Assign**: Click assign button to create the assignment
7. **Review**: Check the assignments list for confirmation

## Database Relationships

```
teachers (1) -----> (*) teacher_subject_assignments
   |                      |
   |                      |
teacher_id            teacher_id (FK)
```

## Security Features

- Input validation prevents SQL injection
- Prepared statements for all database operations
- Soft deletion maintains audit trail
- Foreign key constraints ensure data integrity

## Error Handling

- Database connection failures
- Duplicate assignment attempts
- Invalid form data
- Missing required fields
- Teacher not found scenarios

## Future Enhancements

1. **Schedule Conflict Detection**: Prevent overlapping schedules
2. **Bulk Assignment**: Assign multiple subjects at once
3. **Assignment History**: Track changes over time
4. **Export Functionality**: Generate assignment reports
5. **Email Notifications**: Notify teachers of new assignments
6. **Calendar Integration**: Visual schedule management

## Installation Notes

1. Update database with new table structure
2. Ensure all JAR dependencies are included
3. Verify database connection settings
4. Test with AssignmentTestUtil before production use

## Configuration

- Database connection via DatabaseConnection.java
- Subject list is hardcoded in form (can be moved to database)
- Grade levels 1-12 are predefined
- Form size is fixed for consistency
