level_1 = {
    level: 1,
    player:
    {
      x: 10,
      y: 10 
    },
    enemies:
    [
      {
        x: 100,
        y: 100,
        patrol: 'DiagonalPatrol',
        speed: 1,
        framesToPatrol: 100
      },
      {
        x: 200,
        y: 100,
        patrol: 'VerticalPatrol',
        speed: 1,
        framesToPatrol: 100
      },
      {
        x: 500,
        y: 400,
        patrol: 'VerticalPatrol',
        speed: 1,
        framesToPatrol: 100
      }
    ],
    crates:[],
    trees: [],
    choppa:
    [
      {
        x: 400,
        y: 400,
      }
    ],
    entities:{}
};


LEVELS = [
    level_1,
    level_1
];

