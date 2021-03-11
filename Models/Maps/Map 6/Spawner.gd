extends Spatial

export (Resource) var BlueSpawner1
export (Resource) var BlueSpawner2
export (Resource) var BlueSpawner3
export (Resource) var BlueSpawner4
export (Resource) var BlueSpawner5
export (Resource) var BlueSpawner6
export (Resource) var BlueSpawner7
export (Resource) var BlueSpawner8
export (Resource) var BlueSpawner9
export (Resource) var BlueSpawner10

export (Resource) var RedSpawner1
export (Resource) var RedSpawner2
export (Resource) var RedSpawner3
export (Resource) var RedSpawner4
export (Resource) var RedSpawner5
export (Resource) var RedSpawner6
export (Resource) var RedSpawner7
export (Resource) var RedSpawner8
export (Resource) var RedSpawner9
export (Resource) var RedSpawner10

onready var blueteam = $BlueTeam
onready var redteam = $RedTeam
onready var red_team = []
onready var blue_team = []

func _process(delta):
	for i in blue_team:
		print(i)
