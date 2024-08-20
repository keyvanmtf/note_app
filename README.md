**My Note App**
My Note App is a simple Flutter application that allows users to create, view, and delete notes. The app features a clean and minimalistic UI with support for adding multiple notes, each with a title and content. The notes are displayed in a list view, where they can be searched and deleted.

**Features**
Create Notes: Users can add new notes with a title and content.
View Notes: All created notes are displayed in a list format.
**Delete Notes**: Users can delete notes by tapping the delete icon.
Random Background Colors: Notes are displayed with randomly assigned background colors for visual differentiation.
Screens
**Home Page**: Displays a list of all notes and allows users to search, sort, and delete notes.
Edit Screen: A screen where users can input the title and content of a new note.
How It Works
Notes are passed between the EditScreen and HomePage using Flutter's Navigator to ensure smooth transitions and data management.
The list of notes (filterNotes) is dynamically updated and displayed in the HomePage with each new note created.
Getting Started
To run this project locally, clone the repository and open it in your preferred IDE. Run the app on a connected device or simulator using:

bash
Copy code
flutter run
Dependencies
flutter: ^2.0.0
uuid: ^3.0.4 (for generating unique IDs for each note)
