

function tree currentHeight maxHeight parentbox:undefined branchingChance:0.15 = 
(
	firstbox = undefined
	
	
	for i=currentHeight to maxHeight do
	(
		newbox = Sphere()
		
		if firstbox == undefined then 
		(
			firstbox = newbox
		)
	
		if parentbox != undefined then
		(
			newbox.parent = parentbox
			
			in coordsys parent newbox.pos = [0, 0, 30]
			in coordsys parent newbox.scale = [0.95, 0.95, 0.95]
				
			rotX = random -10.0 10.0
			rotY = random -10.0 10.0
			rotZ = random -10.0 10.0

			
			about newbox.parent rotate newbox(eulerAngles rotX rotY rotZ)
			
			branchRoll = random 0.0 1.0
			
			if branchRoll <= branchingChance then
			(
				branchbox = tree i maxHeight parentbox:newbox
				
				rotbranchX = random -45.0 45.0
				rotbranchY = random -45.0 45.0
				rotbranchZ = random -180.0 180.0
				about newbox rotate branchbox (eulerAngles rotbranchX rotbranchY rotbranchZ)
			)
		)
		parentbox = newbox
	)
	firstbox
)

function animateTree treeBox currentFrame:0 frameIncrement:1 =
(
	currentScale = treeBox.scale
	
	
	for i = 1 to treeBox.children.count do
	(
		nextFrame = currentFrame + frameIncrement
		animateTree treeBox.children[i] currentFrame:nextFrame
	)
	
	with animate on
	(
		at time 0 treeBox.scale = [0, 0, 0]
		
		at time currentFrame treeBox.scale =  currentScale
	)

	
	
)
 

myTree = tree 0 15 branchingChance:0.15
animateTree myTree