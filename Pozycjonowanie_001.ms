try (closerolloutfloater ScriptMenu) catch()

shiftX = 0
shiftY = 0
shiftZ = 5
quality = 10

rotX = 0
rotY = 0
rotZ = 10

option = 0
----------------------------------------------------------------Menu01---------------------
Rollout Menu01 "Ilosc"
(
	Spinner num "ilosc" type:#integer range:[0, 1000, 10]
	
	on num changed val do
	(quality = Val)
)
----------------------------------------------------------------Menu02---------------------
Rollout Menu02 "Przesuwanie"
(
	Spinner valX "X" range:[0, 10000, 0]
	Spinner valY "Y" range:[0, 10000, 0]
	Spinner valZ "Z" range:[0, 10000, 5]
	
	on valX changed val do
	(shiftX = Val)
	on valY changed val do
	(shiftY = Val)
	on valZ changed val do
	(shiftZ = Val)
)
----------------------------------------------------------------Menu03---------------------
Rollout Menu03 "Obracanie"
(
	Spinner valX "rot X" range:[0, 10000, 0]
	Spinner valY "rot Y" range:[0, 10000, 0]
	Spinner valZ "rot Z" range:[0, 10000, 10]
	
	on valX changed val do
	(rotX = Val)
	on valY changed val do
	(rotY = Val)
	on valZ changed val do
	(rotZ = Val)
)
----------------------------------------------------------------Menu04---------------------
--Rollout Menu04 "Skalowanie"
--(
--)
----------------------------------------------------------------Menu05---------------------
Rollout Menu05 "Opcje Dodatkowe"
(
	checkbox iterat "Iteracyjnie" pos:[2, 40]
	button make "Dzialaj" pos:[2, 6] width:80 height:20
	
	on iterat changed theState do
	(if iterat.checked==true then option = 1
	 else option = 0)
	
	on make pressed do
	(
		if selection.count > 0 then 
		(
			parentbox = theOldest selection[1]
			
			case option of
			(
				0:(
					first = parentbox
					for i=1 to quality do
					(
						maxOps.cloneNodes first cloneType:#instance newNodes:&nnl
						newbox = nnl[1]

						rotStaticX = rotX*i
						rotStaticY = rotY*i
						rotStaticZ = rotZ*i
						shiftStaticX = shiftX*i
						shiftStaticY = shiftY*i
						shiftStaticZ = shiftZ*i
						
						in coordsys first newbox.pos = [shiftStaticX, shiftStaticY, shiftStaticZ]
						
						rotate newbox(eulerAngles rotStaticX rotStaticY rotStaticZ)
					)
				)
				1:	for i=1 to quality do
					(
						maxOps.cloneNodes parentbox cloneType:#instance newNodes:&nnl
						newbox = nnl[1]

						newbox.parent = parentbox
						
						in coordsys parent newbox.pos = [shiftX, shiftY, shiftZ]
							
						about newbox.parent rotate newbox(eulerAngles rotX rotY rotZ)
						
						parentbox = newbox
					)
			)
		)
	)
)



ScriptMenu = NewRolloutFloater "POS" 200 500
addRollout Menu01 ScriptMenu
addRollout Menu02 ScriptMenu
addRollout Menu03 ScriptMenu
--addRollout Menu04 ScriptMenu
addRollout Menu05 ScriptMenu

function theOldest element =
(
	while element.parent!=undefined do element = element.parent
	
	element
)