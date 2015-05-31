
CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body VARCHAR(255) NOT NULL,
  author_id INTEGER NOT NULL,

  FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  subject_question_id INTEGER NOT NULL,
  parent_reply_id INTEGER,
  author_id INTEGER NOT NULL,
  body VARCHAR(255) NOT NULL,

  FOREIGN KEY (subject_question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_reply_id) REFERENCES replies(id)
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('CJ', 'Avilla'), ('David', 'Runger'), ('Andrew', 'Larson');

INSERT INTO
  questions (title, body, author_id)
VALUES
  ("Where is App Academy?", "I dont know where to get there from 10th st", 1),
  ("What time is the assessment?", "I haven't written it yet!", 2),
  ("Can we break for lunch?", "I'm hungry", 2),
  ("Where can I get a steam cleaner?", "Y'all stink like crazy", 3);

INSERT INTO
  replies(subject_question_id, parent_reply_id, author_id, body)
VALUES
  (1, NULL, 2, "Take the Bart!"),
  (2, NULL, 1, "9AM"),
  (2, 2, 3, "No, it's at 10AM"),
  (3, NULL, 3, "12PM"),
  (4, NULL, 1, "Home Depot"),
  (2, 3, 2, "Dude, it's at 9"),
  (2, 3, 1, "I think it's at 9");

INSERT INTO
  question_follows(user_id, question_id)
VALUES
  (1,2),(2,2),(3,2),(1,3),(3,4),(1,4);

INSERT INTO
  question_likes (user_id, question_id)
VALUES
  (1,2),(2,2),(3,2),(1,3),(3,4),(1,4),
  (1,1),(2,1),(3,1);
