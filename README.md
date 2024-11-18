My Note App
My Note App is a Flutter-based application designed to manage notes efficiently. The app features a clean, minimalistic user interface and provides functionalities for creating, viewing, and deleting notes. Each note can have a title and content, and the app includes a visually appealing feature where notes are displayed with random background colors.

Table of Contents
Features
Screens
How It Works
Getting Started
Dependencies
Contributing
License
Features
Create Notes: Add new notes with a title and content.
View Notes: All created notes are displayed in a list format.
Delete Notes: Remove notes by tapping the delete icon.
Random Background Colors: Each note is displayed with a unique, randomly assigned background color for visual differentiation.
Screens
Home Page:
Displays a list of all notes.
Includes features for searching, sorting, and deleting notes.
Edit Screen:
Provides an interface for adding or editing the title and content of a note.
How It Works
Navigation: Notes are passed between the Edit Screen and Home Page using Flutter's Navigator for smooth transitions and data management.
Dynamic Updates: The list of notes (filterNotes) is dynamically updated and displayed in real time on the Home Page as notes are created or deleted.
Getting Started
Follow these steps to run the project locally:

Clone the repository:
bash
Copy code
git clone <repository-url>
Navigate to the project directory:
bash
Copy code
cd note_app-main
Run the app on a connected device or emulator:
bash
Copy code
flutter run


bash
Copy code
flutter run
Dependencies
flutter: ^2.0.0
uuid: ^3.0.4 (for generating unique IDs for each note)
