INSERT INTO content (type, title, description, published, locked, payload)
VALUES (
  'quiz',
  'General Knowledge',
  'A quick mixed-format warm-up.',
  true,
  false,
  '{
    "passThreshold": 0.7,
    "shuffle": true,
    "questions": [
      {
        "id": "q1",
        "kind": "single",
        "prompt": "What is the capital of France?",
        "options": [
          { "id": "a", "label": "Paris",  "correct": true  },
          { "id": "b", "label": "Lyon",   "correct": false },
          { "id": "c", "label": "Marseille", "correct": false }
        ]
      },
      {
        "id": "q2",
        "kind": "multi",
        "prompt": "Which of these are prime numbers?",
        "options": [
          { "id": "a", "label": "2", "correct": true  },
          { "id": "b", "label": "4", "correct": false },
          { "id": "c", "label": "7", "correct": true  },
          { "id": "d", "label": "9", "correct": false }
        ]
      },
      {
        "id": "q3",
        "kind": "truefalse",
        "prompt": "The Great Wall of China is visible from space with the naked eye.",
        "answer": false
      }
    ]
  }'::jsonb
);

-- a locked quiz
INSERT INTO content (type, title, description, published, locked, unlock_code, payload)
VALUES (
  'quiz',
  'Members Only',
  'Unlock with a code.',
  true,
  true,
  'OPEN123',
  '{
    "passThreshold": 0.5,
    "questions": [
      {
        "id": "q1",
        "kind": "truefalse",
        "prompt": "You unlocked this quiz.",
        "answer": true
      }
    ]
  }'::jsonb
);
