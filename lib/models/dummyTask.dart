import 'package:flexibletodo/models/task.dart';

const DUMMY_TASK = const [
  Task(
    title: 'Research Work',
    category: 'Academics',
    progressType: 'Gradual',
    todoDueDate: '21/04/05',
    todoStartDate: '21/02/17',
    description: 'I am to search for recent papers online',
    isFinished: true,
    id: 1,
    measurables: {
      'Download Endnote': true,
      'Install Endnote': true,
      'visit IEEE and scienceDirect': false,
      'filter out the papers': false,
    },
    time: '12:00AM',
  ),
  Task(
    title: 'Map Work',
    category: 'Work',
    progressType: 'Definite',
    todoDueDate: '21/02/28',
    todoStartDate: '21/02/17',
    description: 'I am to put locations on the maps',
    isFinished: false,
    id: 3,
    time: '12:00AM',
  ),
  Task(
    title: 'Publishing Paper',
    category: 'Academics',
    progressType: 'Gradual',
    todoDueDate: '21/04/05',
    todoStartDate: '21/02/17',
    description:
        'I am to publish my finished papers and alot of thing that might no be necessary',
    isFinished: false,
    id: 2,
    measurables: {
      'Visit the publish site': true,
      'Download Endnote': true,
      'Filter out the unneccessary stuffs': true,
      'visit IEEE and scienceDirect': true,
      'filter out the papers': false,
    },
    time: '1:00AM',
  ),
  Task(
    title: 'Cook Rice',
    category: 'Family',
    progressType: 'Finite',
    todoDueDate: '21/03/25',
    todoStartDate: '21/02/18',
    description: 'I am to cook different types of soup',
    isFinished: true,
    id: 4,
    time: '12:00AM',
  ),
  Task(
    title: 'Conference Papers',
    category: 'Academics',
    progressType: 'Gradual',
    todoDueDate: '21/04/05',
    todoStartDate: '21/02/17',
    description:
        'I am to publish my finished papers and alot of thing that might no be necessary',
    isFinished: false,
    id: 2,
    measurables: {
      'Visit the publish site': true,
      'Download Endnote': false,
      'Filter out the unneccessary stuffs': true,
      'visit IEEE and scienceDirect': false,
      'filter out the papers': false,
    },
    time: '1:00AM',
  ),
  Task(
    title: 'Seive Rice Flour',
    category: 'Food',
    progressType: 'Finite',
    todoDueDate: '21/03/25',
    todoStartDate: '21/02/18',
    description: 'I am to cook different types of soup',
    isFinished: false,
    id: 4,
    time: '12:00AM',
  ),
];
