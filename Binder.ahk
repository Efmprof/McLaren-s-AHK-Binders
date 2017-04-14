;#################### 
; #### SAMP UDF R15.1 ####
; ####################
; Written by Chuck_Floyd 
; =======================
; Developer Matteo_McLaren
; Developer #2 Dmitriy_MCLaren
; DLL API библиотека: https://yadi.sk/d/WYNP9ryTxXuDf
; Библиотека dx9_overlay: https://yadi.sk/d/6iQMTa043FFAZ6

; Samp-udf-addon

; ###############################################################################################################################
; # 														                                                                    #
; # Функции для взаимодействия с клиентом SAMP                                                                                  #
; #     - IsSAMPAvailable()                         - Возвращает состояние SAMP (0 - Запущен, 1 - Выключен)                     #
; #     - isInChat()                                - Проверяет открыт ли чат (0 - нет, 1 - да)                                 #
; #     - getUsername()                             - Возвращает ник локального игрока                                          #
; #     - getId()                                   - Возвращает id локального игрока                                           #
; #     - SendChat(wText)                           - Отправка сообщения/команды серверу                                        #
; #     - addChatMessage(wText)                     - Локальное сообдещие в чат                                                 #
; #     - showGameText(wText, dwTime, dwTextsize)   - Отоброжение Game Text                                                     #
; #     - playAudioStream(wUrl)                     - Воспроизведение аудиопотока                                               #
; #     - stopAudioStream()                         - Остановка аудиопотока                                                     #
; #	    - GetChatLine(Line, Output)		            - Вывод строки из чат лога (0 - Последняя строка)                           #
; # 	- blockChatInput() 					        - Блокировка отправления сообщений серверу                                  #
; # 	- unBlockChatInput() 						- Разблокировка отправлений сообщений серверу                               #
; # 														                                                                    #
; # --------------------------------------------------------------------------------------------------------------------------- #
; # 														                                                                    #
; #     - getServerName()                           - Возвращает название сервера                       						#
; #     - getServerIP()                             - Возвращает IP сервера      						    			        #
; #     - getServerPort()                           - Возвращает порт сервера              									    #
; #     - CountOnlinePlayers()                      - Возвращает текущий онлайн на сервере                                      #
; # 														                                                                    #
; # --------------------------------------------------------------------------------------------------------------------------- #
; # 														                                                                    #
; #	    - getWeatherID()			                - Возвращает ID текущей погоды                                              #
; #	    - getWeatherName()			                - Возвращает название текущей погоды                                        #
; # 														                                                                    #
; # --------------------------------------------------------------------------------------------------------------------------- #
; # 														                                                                    #
; #     - patchRadio()                              - Включает патч для аудиопотока                                             #
; #     - unPatchRadio()                            - Выключает патч для аудиопотока 		                                    #
; # 														                                                                    #
; ###############################################################################################################################
; # Функции для взаимодействия с диалогами (v.0.3.7)	        											                    #
; # --------------------------------------------------------------------------------------------------------------------------- #
; #	    - isDialogOpen()                            - Проверяет открыт ли диалог                       	                       	#
; #	    - getDialogStyle()                          - Возвращает id стиля диалога                              					#
; #	    - getDialogID()                             - Возвращает id диалога (исходя из данных сервера)                  		#
; #	    - setDialogID(id)                           - Изменение ID диалога          				                        	#
; #	    - getDialogCaption()                        - Возвращает заголовок диалога           			                        #
; #	    - getDialogText()                           - Возвращает текст диалога                                                  #
; #	    - getDialogLineCount()                      - Возвращает количество строк диалога                                       #
; #	    - getDialogLine(index)                      - Возвращает содержимое строки по номеру           	                       	#
; #	    - getDialogLines()                          - Возвращает массив строк диалога  	     	        	                   	#
; #     - getDialogStructPtr()                      - Возвращает указатель на структуру диалога                                	#
; #	    - showDialog(style, caption, text, button1, button2, id) - Создание локального диалога         	                       	#
; ###############################################################################################################################
; # 														                                                                    #
; # Функции для взаимодействия с игроками                                                                                       #
; #	    - getTargetPed(dwPED)   			        - Возвращает PED ID, по таргету                                             #
; #     - getPedById(dwId)                          - Возвращает PED ID по id игрока                                            #
; #     - getIdByPed(dwId)                          - Возвращает id игрока по PED                                               #
; #     - getStreamedInPlayersInfo()                - Возвращает объект, хранящий информацию об игроках в зоне стрима           #
; #     - callFuncForAllStreamedInPlayers(cfunc)    - Вызывает функцию отображающую всю информации о игроках в зоне стрима      #
; #	    - getDist(pos1, pos2)   			        - Возвращает растояние между двумя точками                                  #
; #     - getClosestPlayerPed()                     - Возвращает PED ID ближайшего игрока                                       #
; #     - getClosestPlayerId()                      - Возвращает id ближайшего игрока                                           #
; #	    - getPedCoordinates(dwPED)   			    - Возвращает кординаты (в зоне стрима) по PED ID                            #
; #     - getTargetPosById(dwId)                    - Возвращает позицию игрока по id                                           #
; #     - getTargetPlayerSkinIdByPed(dwPED)         - Возвращает id скина по PED ID                                             #
; #     - getTargetPlayerSkinIdById(dwId)           - Возвращает id скина по id игрока                                          #
; #     - calcScreenCoors(fX,fY,fZ)                 - Возвращает массив координат [fX,fY,fZ] относительно экрана                #
; # 														                                                                    #
; # Функции для взаимодействия с транспортом:                                                                                   #
; #	    - getVehiclePointerByPed(dwPED)   			- Возвращает указатель на транспорт по PED ID                               #
; #	    - getVehiclePointerById(dwId)   			- Возвращает указатель на транспорт по id игрока                            #
; #     - isTargetInAnyVehicleByPed(dwPED)          - Проверяет находится ли игрок в транспорте по PED ID                       #
; #     - isTargetInAnyVehicleById(dwId)            - Проверяет находится ли игрок в транспорте по id игрока                    #
; #     - getTargetVehicleHealthByPed(dwPED)        - Возвращает hp транспорта по PED ID                                        #
; #     - getTargetVehicleHealthById(dwId)          - Возвращает hp транспорта по id игрока                                     #
; #     - getTargetVehicleTypeByPed(dwPED)          - Возвращает тип транспорта по PED ID (возвращает число, а не название)     #
; #     - getTargetVehicleTypeById(dwId)            - Возвращает тип транспорта по id игрока (возвращает число, а не название)  #
; #     - getTargetVehicleModelIdByPed(dwPED)       - Возвращает номер модели транспорта по PED ID                              #
; #     - getTargetVehicleModelIdById(dwId)         - Возвращает номер модели транспорта по id игрока                           #
; #     - getTargetVehicleModelNameByPed(dwPED)     - Возвращает название модели транспорта по PED ID 				            #
; #     - getTargetVehicleModelNameById(dwId)       - Возвращает название модели транспорта по id игрока 				        #
; #     - getTargetVehicleLightStateByPed(dwPED)    - Возвращает состояние света транспорта по PED ID (вкл./выкл.)			    #
; #     - getTargetVehicleLightStateById(dwId)      - Возвращает состояние света транспорта по id игрока (вкл./выкл.)		    #
; #     - getTargetVehicleEngineStateByPed(dwPED)   - Возвращает состояние мотора транспорта по PED ID (вкл./выкл.)			    #
; #     - getTargetVehicleEngineStateById(dwId)     - Возвращает состояние мотора транспорта по id игрока (вкл./выкл.) 			#
; #     - getTargetVehicleLockStateByPed(dwPED)     - Возвращает состояние дверей транспорта по PED ID (закрыты/открыты) 	    #
; #     - getTargetVehicleLockStateById(dwId)       - Возвращает состояние дверей транспорта по id игрока (закрыты/открыты)     #
; #     - getTargetVehicleColor1ByPed(dwPED)        - Возвращает 1-й цвет транспорта по PED ID 			                        #
; #     - getTargetVehicleColor1ById(dwId)          - Возвращает 1-й цвет транспорта по id игрока			                    #
; #     - getTargetVehicleColor2ByPed(dwPED)        - Возвращает 2-й цвет транспорта по PED ID 			                        #
; #     - getTargetVehicleColor2ById(dwId)          - Возвращает 2-й цвет транспорта по id игрока 			                    #
; #     - getTargetVehicleSpeedByPed(dwPED)         - Возвращает текущую скорость транспорта по PED ID			                #
; #     - getTargetVehicleSpeedById(dwId)           - Возвращает текущую скорость транспорта по id игрока		                #
; # 														                                                                    #
; ###############################################################################################################################
; # 														                                                                    #
; # Функции для взаимодейтвия с общим списком игроков (Tab):                                                                    #
; #     - getPlayerScoreById(dwId)                  - Возвращает уровень игрока по id                                           #
; #     - getPlayerPingById(dwId)                   - Возвращает ping игрока по id                                              #
; #     - getPlayerNameById(dwId)                   - Возвращает ник игрока по id                                               #
; #     - getPlayerIdByName(wName)                  - Возвращает id игрока по нику                                              #
; #     - updateScoreboardDataEx()                  - Обновление данных Tab'a                                                   #
; #     - updateOScoreboardData()                   - Обновление данных игроков на сервере                                      #
; #	    - isNPCById(dwId)   			            - Проверяет является ли персонаж NPC по id		                            #
; # 														                                                                    #
; ###############################################################################################################################
; # 														                                                                    #
; # Функции для взаимодействия с локальным игроком:                                                                             #
; #     - getPlayerHealth()                         - Возвращает hp локального игрока                                           #
; #     - getPlayerArmour()                         - Возвращает количество брони локального игрока                             #
; # 	- getPlayerInteriorId()			            - Возвращает id интерьера 		                                            #
; # 	- getPlayerSkinId()			                - Возвращает id скина локального игрока          		                    #
; # 	- getPlayerMoney() 			                - Возвращает количество денег на руках у локального игрока                  #
; #	    - getPlayerWanteds()			            - Возвращает уровень розыска локального игрока                              #
; #	    - getPlayerWeaponId()			            - Возвращает id оружия в руках у локального игрока                          #
; #	    - getPlayerWeaponName()			            - Возвращает название оружия в руках у локального игрока                    #
; #	    - getPlayerState()			                - Возвращает состояние локального игрока (возвращает число)                 #
; #	    - getPlayerMapPosX()			            - Возвращает X позицию на карте (Esc > Карта) локального игрока             #
; #	    - getPlayerMapPosY()			            - Возвращает Y позицию на карте (Esc > Карта) локального игрока             #
; #	    - getPlayerMapZoom()			            - Возвращает коэф. увеличения карты (Esc > Карта) локального игрока         #
; #	    - IsPlayerFreezed()			                - Проверяет заморожен ли локальний игрок                                    #
; # 														                                                                    #
; ###############################################################################################################################
; # 														                                                                    #
; # Функции для взаимодействия с текущим транспортом:                                                                           #
; #     - isPlayerInAnyVehicle()                    - Проверяет находится ли локальный игрок в транспорте (любом)               #
; #     - getVehicleHealth()                        - Возвращает hp текущего транспорта                                         #
; # 	- isPlayerDriver() 			                - Проверяет является ли локальный игрок водителем		                    #
; # 	- getVehicleType() 			                - Возвращает тип текущего транспорта                                        #
; # 	- getVehicleModelId()			            - Возвращает номер модели текущего транспорта 				                #
; # 	- getVehicleModelName() 		            - Возвращает название модели текущего транспорта 				            #
; # 	- getVehicleLightState() 		            - Возвращает состояние света текущего транспорта (вкл./выкл.) 			    #
; # 	- getVehicleEngineState() 		            - Возвращает состояние мотора текущего транспорта (вкл./выкл.)			    #
; # 	- getVehicleLockState() 		            - Возвращает состояние дверей текущего транспорта 			                #
; # 	- getVehicleColor1() 		                - Возвращает 1-й цвет текущего транспорта   			                    #
; # 	- getVehicleColor2() 		                - Возвращает 2-й цвет текущего транспорта   			                    #
; # 	- getVehicleSpeed() 		                - Возвращает текущую скорость текущего транспорта   			            #
; # 	- getPlayerRadiostationID() 		        - Возвращает номер радиостанции текущего транспорта   			            #
; # 	- getPlayerRadiostationName() 		        - Возвращает название радиостанции текущего транспорта   			        #
; # 														                                                                    #
; ###############################################################################################################################
; # 														                                                                    #
; # Функции для взаимодействия с координатами:                                                                                  #
; #     - getCoordinates()                          - Возвращает массив координат [fX,fY,fZ] локального игрока                  #
; #	    - getPlayerPos(X,Y,Z) 			            - Возвращает координаты локального игрока в указанные перменные             #
; # 														                                                                    #
; # --------------------------------------------------------------------------------------------------------------------------- #
; # 														                                                                    #
; #     - initZonesAndCities()                      - Инициализация районов и городов карты                                     #
; #     - calculateZone(X, Y, Z)                    - Возвращает название района по координатам                                 #
; #     - calculateCity(X, Y, Z)                    - Возвращает название города по координатам                                 #
; #     - getCurrentZonecode()                      - ..:: НЕ РАБОТАЕТ ::..                                                     #
; #     - AddZone(Name, X1, Y1, Z1, X2, Y2, Z2)     - Добавление нового района                                                  #
; #     - AddCity(Name, X1, Y1, Z1, X2, Y2, Z2)     - Добавление нового города                                                  #
; #	    - IsPlayerInRangeOfPoint(X, Y, Z, Radius)   - Проверяет находится ли локальный игрок в радиусе 3D координат             #
; #	    - IsIsPlayerInRangeOfPoint2D(X, Y, Radius)  - Проверяет находится ли локальный игрок в радиусе 2D координат             #
; #	    - getPlayerZone()                   		- Возвращает название района локального игрока		                        #
; #	    - getPlayerCity()                   		- Возвращает название района локального игрока			                    #
; # 														                                                                    #
; ###############################################################################################################################
; # Sonstiges:                                                                                                                  #
; #     - checkHandles()                                                                                                        #
; #     - AntiCrash()								- AntiCrash                                                                 #
; ###############################################################################################################################
; # Функции для взаимодействия с памятью (внутренние функции):                                                                  #
; #     - checkHandles()                                                                                                        #
; #     - refreshGTA()                                                                                                          #
; #     - refreshSAMP()                                                                                                         #
; #     - refreshMemory()                                                                                                       #
; #     - getPID(szWindow)                                                                                                      #
; #     - openProcess(dwPID, dwRights)                                                                                          #
; #     - closeProcess(hProcess)                                                                                                #
; #     - getModuleBaseAddress(sModule, dwPID)                                                                                  #
; #     - readString(hProcess, dwAddress, dwLen)                                                                                #
; #     - readFloat(hProcess, dwAddress)                                                                                        #
; #     - readDWORD(hProcess, dwAddress)                                                                                        #
; #     - readMem(hProcess, dwAddress, dwLen=4, type="UInt")                                                                    #
; #     - writeString(hProcess, dwAddress, wString)                                                                             #
; #     - writeRaw(hProcess, dwAddress, data, dwLen)                                                                            #
; #     - Memory_ReadByte(process_handle, address)                                                                              #
; #     - callWithParams(hProcess, dwFunc, aParams, bCleanupStack = true)                                                       #
; #     - virtualAllocEx(hProcess, dwSize, flAllocationType, flProtect)                                                         #
; #     - virtualFreeEx(hProcess, lpAddress, dwSize, dwFreeType)                                                                #
; #     - createRemoteThread(hProcess, lpThreadAttributes, dwStackSize, lpStartAddress, lpParameter,                            #
; #     - dwCreationFlags, lpThreadId)                                                                                          #
; #     - waitForSingleObject(hThread, dwMilliseconds)                                                                          #
; #     - __ansiToUnicode(sString, nLen = 0)                                                                                    #
; #     - __unicodeToAnsi(wString, nLen = 0)                                                                                    #
; ###############################################################################################################################
; # by MurKotik                                                                                                                 #
; #     - setCoordinates(x, y, z, Interior)         - Изменяет координаты локальному игроку                                     #
; #     - setIP(IP)                                 - Изменяет IP сервера (Не доработано)                                       #
; #     - setUsername(username)                     - Изменяет ник (Не доработано)                                              #
; #     - colorhud(color)                           - Изменяет зелёный цвет в игре на указаный                                  #
; #	    - setTime(hour)	                            - Изменяет времени на сервере (визуально)                                   #
; #	    - getSkinID()   	                        - Возвращает ID Скина локального игрока                                     #
; #	    - getDialogTitle() 	                        - Возвращает заголовок последнего диалога                                   #
; #	    - getPlayerColor(id)                        - Возвращает ID цвета ника игрока по id игрока                              #
; #	    - setPlayerColor(id,color)                  - Изменяет цвет ника игроку по id игрока                                    #
; #	    - colorToStr(color)	                        - Конвертация цвета из десятичной в шестнадцатиричную систему измерения     #
; #	    - getWeaponId() 	                        - Возвращает ID оружия локального персонажа                                 #
; #     - restartGameEx()                           - Рестарт игры (Не отключает от сервера)                                    #
; #     - setrestart()                              - Изменяет состояние игрока на Restart (Переподключение к серверу)          #
; #     - disconnectEx()                            - Отключение от сервера                                                     #
; #     - WriteProcessMemory(title,addresse,wert,size) - Работа с пресетам                                                      #
; #     - FloatToHex(value)                         - Перевод из Float в Hex                                                    #
; #     - IntToHex(int)                             - Перевод из Int в Hex                                                      #
; #     - HexToDec(str)                             - Перевод из Hex в Dec (Строковых значений)                                 #
; #     - addChatMessageEx(Color, wText)            - Локальное сообщение с изменением цвета timestamp'a                        #
; #     - connect(IP)                               - Подключение к серверу по IP (Пока что без смены Порта)                    #
; #     - setWeather(id)                            - Изменяет погоду (визуально)                                               #
; #     - setPlayerFreeze(status)                   - Изменяет статус заморозки (0 - разморозка, 2 - заморозка)                 #    
; # by McFree                                                                                                                   #
; #     - getPlayerPosById(dwId)                    - Возвращает позицию игрока по id игрока                                    #
; #     - HexToDecOne(Hex)                          - Перевод из Hex в Dec                                                      #
; #     - HexToDecTwo(Hex)                          - Перевод шестнадцатиричного числа в десятичное                             #
; #     - hex2rgb(CR)                               - Перевод шестнадцатиричного цвета в rgb строку (255,255,255)               #
; #     - rgb2hex(R, G, B)                          - Перевод RGB цвета в шестнадцатиричное значение (FFFFFF)                   #
; #     - ProcessWriteMemory(Str ,addresse, process, Str, byte) - Запись в память                                               #
; #     - ProcessReadMemory(address, processIDorName, type, numBytes) - Чтение из памяти                                        #
; #     - GetCoordsSamp(ByRef ResX, ByRef ResY)     - Перевод кординат монитора на кординаты SA-MP                              #
; #     - getZoneByName(zName, ByRef CurZone)       - Возвращает координаты зоны по имени                                       #
; #     - getCenterPointToZone(zName, ByRef PointPos)- Возвращает координаты центра зоны по имени                               #
; # by Godarck                                                                                                                  #
; #     - GetInterior()                             - Проверяет находится ли персонаж в интерьере (true/false)                  #
; #     - getVehicleSirenState()                    - Проверяет в ключена ли сирена (true/false)                                #
; #     - CoordsFromRedmarker()                     - Возвращает координаты метки с карты.                                      #
; #     - NearPlayerInCar(dist)                     - Определяет игрока в автомобиле рядом                                      #
; #     - isTargetDriverbyId(dwId)                  - Проверяет является ли игрок водителем т/с по id                           #
; #     - ConvertCarColor(Color)                    - Конвертация цвета в RGB для getVehicleColor1() и getVehicleColor2()       #
; # By Unknown                                                                                                                  #
; #     - disableCheckpoint()                       - Отключает маркер на карте (Disable RED Marker on map)                     #
; #     - setCheckpoint(xpos,ypos,zpos,Radius)      - Устанавливает маркер на карте                                             #
; # By MrGPro                                                                                                                   #
; #     - getServerHour()                           - Возвращает минуты по серверному времени (Только серверах где отображается)#
; #     - getServerMinute()                         - Возвращает часы по серверному времени (Только серверах где отображается)  #
; #     - getVehicleIdServer()                      - Возвращает ID транспорта на сервере в который сидит локальный игрок       #
; # By Слюнявчик                                                                                                                #
; #     - IsInAFK()                                 - Проверяет находится ли локальный игрока в AFK                             #
; #                                                      (1 - AFK, 0 - не AFK, -1 - Игра закрыта)                               #
; # By Phoenixxx_Czar                                                                                                           #
; #     - isPlayerStreamebyid(id, dist)             - Определяет есть ли игрок на заданной дистации от вас                      #
; #     - getDialogLineNumber()                     - Замена, в случае не работоспособности getDialogIndex()                    #
; #     - getsexbyskin(skin)                        - Выдает пол по иду скина (0 - Ошибка, 1 - Мужской, 2 - Женский)            #
; # By aknqkzxlcs                                                                                                               #
; #     - setPlayerName(playerid, newnick)          - Визуальная смена Ника игрока по id                                        #
; #     - getDialogIndex()                          - Возвращает индекс выбранной строки, начиная с 1                           #
; #     - isDialogButtonSelected(Button id)         - Наведена ли мышка на кнопку                                               #
; #     - set_player_armed_weapon_to(weaponid)      - Меняет оружие в руках на указанное путем перелистывания                   #
; #     - setPlayerHealth(float)                    - Установить уровень ХП персонажу      (Пример данных: float := 50.0)       #
; #     - setPlayerArmor(float)                     - Установить уровень брони персонажу                                        #
; #     - setVehicleHealth(float)                   - Установить уровень ХП автомобиля                                          #
; #     - getPlayerAnim()                           - Получение ID анимации                                                     #
; #     - toggleUnlimitedAmmo()                     - Бесконечные патроны                                                       #
; #     - toggleNoReload()                          - Стрельба без перезарядки                                                  #
; #     - toggleNoRecoil()                          - Стрельба без отдачи                                                       #
; #     - getKillStat()                             - Возвращает киллстат в виде массива из 5 строк                             #
; #     - getLastDamagePed(playerid, weapon)        - Получить ид того игрока, который тебя дамажил последний                   #
; #     - toggleAntiBikeFall()                      - не падать с байка                                                         #
; #     - toggleAntiCarEject()                      - вас не могут выкинуть из машины                                           #
; #     - toggleNoAnimations()                      - анимации не отображаются                                                  #
; #     - toggleObjectDrawMode()                    - курсор для отображения информации о streamer объектах на сервере          #
; #     - toggleMotionBlur()                        - размытость при движении на большой скорости как в сингле                  #
; #     - toggleNoDamageByWeapon()                  - вкл/выкл невосприимчивость к пулям, без gm patch в samp 0.3.7 не работает #
; #     - toggleInfiniteRun()                       - вкл/выкл бесконечный бег                                                  #
; #     - isPlayerCrouch()                          - Положение персонажа 1 - сидит 0 - Стоит                                   #
; #     - multVehicleSpeed(MultValue, SleepTime, MaxSpeedX, MaxSpeedY)    - Устанавливает максимальную скорость автомобиля      #
; #     - setFireImmunity(state)                    - Устанавливает время горения огня                                          #
; #     - setDialogState(state)                     - Свернуть / развернуть диалог 0 - Скрыть 1 - Развернуть                    #
; #     - blurlevel()                               - Выдаёт / устанавливает уровень размытости пример - blurlevel(level)       #
; #     - getWeaponAmmo(аргументы)                  - Получение патрон                                                          #
; #     - gmpatch()                                 - by FYP, отключает встроенный клиентский античит на бессмертие             #
; #     - getVehicleMaxPassengers()                 - Максимальное количество пассажирских мест в текущем транспорте            #
; #     - getVehiclePassenger(место)                - Возвращает CPed pointer пассажира/водителя                                #
; #     - getVehiclePassengerId(место)              - возвращает id пассажира/водителя места: 0 водительское, 1-8 пассажирские  #
; #     - writeBytes(hProcess, dwAddress, bytes)    - записать несколько байтов по адресу (служебная функция)                   #
; # By Dworkin                                                                                                                  #
; #     - getCameraCoordinates()                    - Получение координаты вашей камеры                                         #
; # By Ghost29                                                                                                                  #
; #     - togglekillstat(state)                     - Переключает киллстат. (1 - вкл, 0 - выкл)                                 #
; #     - setkillstatwidth(width)                   - Ширина между строками киллстата                                           #
; #     - movekillstat(x)                           - Двигает киллстат по Х                                                     #
; #     - setdistkillstat(int)                      - Расстояние между правым столбиком и иконкой гана                          #
; ###############################################################################################################################
; # Аргументы: для getWeaponAmmo(аргументы) 
; # [1] Ammo - возвращает в переменную общее количество патрон
; # [2] Clip (необязательный) - возвращает в переменную количество патрон в магазине
; # [3] Slot (необязательный) - если не указан, то возвращает патроны текущего оружия, иначе патроны из указанного слота (2 - пистолеты, 
; #  3 - дробовики, 
#Include core.ahk


Loop {
    if( getPlayerWeaponId() != weaponID )
    {
        weaponID := getPlayerWeaponId()
        ;FBI and PD
        if(weaponId == 24){ 
            SendChat("/me достал(а) пистолет DesertEagle из кобуры") 
        }
        if(weaponId == 3){ 
            SendChat("/me достал(а) Полицейскую дубинку") 
        }
        if(weaponId == 17){ 
            SendChat("/me достал(а) Дымовую шашку") 
        }
        if(weaponId == 23){ 
            SendChat("/me достал(а) Электрошокер из кобуры") 
        }
        if(weaponId == 29){ 
            SendChat("/me достал(а) MP5") 
        }
        if(weaponId == 31){ 
            SendChat("/me достал(а) M4") 
        }
        if(weaponId == 34){ 
            SendChat("/me достал(а) Снайперскую винтовку") 
        }
        ;DIFERENT AMMO
        if(weaponId == 3){ 
            SendChat("/me достал(а) Букет цветов") 
        }
        if(weaponId == 25){ 
            SendChat("/me достал(а) Дробовик") 
        }
        if(weaponId == 33){ 
            SendChat("/me достал(а) Охотничье ружье") 
        }
        if(weaponId == 43){ 
            SendChat("/me достал(а) Фотоаппарат") 
        }
        if(weaponId == 46){ 
            SendChat("/me надел(а)  Парашют") 
        }
        if(weaponId == 0){ 
            SendChat("/me спрятал(а)  оружие") 
        }
    }
    else
    {
        weaponID := getPlayerWeaponId()
    }
    sleep 1000
}

;=======================================================================
:?:/information::
ShowDialog("0", "Справочная информация.", "{FFFFFF}Приветствуем Вас в {000080}Федеральном Бюро Расследований!`n {FFFFFF}Сейчас Вы сможете узнать немного справочной информации о работе Бюро в целом`n", "Закрыть")
return

:?:/help::
ShowDialog("0", "Окно помощи в управлении скриптом", "{8B0000}[!] {FF0000}Внимание! {FFFFFF}Данный скрипт настроен на работу со стандартными командами.`n {8B0000}[!] {FFFFFF}Это обозначает то, что для того, что бы произошла отыгровка какой-либо команды достаточно вписать ее в чистом виде.`n`n {8B008B}/information {FFFFFF}- Получить информацию по работе Федерального Бюро Расследований.`n {8B008B}", "Закрыть")
return


:?:/restart::
{
    setrestart()  
    addChatMessageEx(0xFFFFFFFF, "{FFC800}[Подсказка] {ffffff}Переподключение к серверу.")
}
return

:?:/time::
{
    FormatTime, TimeString,, Time
    SendChat("/me закатав рукав, взглянул на наручные часы")
    sleep 2100
    SendChat("/do Время на часах: " TimeString ".")
    sleep 700
    FormatTime, TimeString,, LongDate
    addChatMessageEx(0xFFFFFFFF, "{FFC800}[Подсказка] {ffffff}Сегодня: " TimeString )
    SendChat("/time")
}
return

:?:/family_info::
{
    SendChat("/k [INFO] Mc")
    sleep 500
    SendChat("/k [INFO]")
    sleep 500
    SendChat("/k [INFO]")
    sleep 500
    SendChat("/k [INFO]")
}
return
;========================================================================
NumPad1::
{
    SendChat("Семья McLaren ищет родствеников.")
}
return

NumPad2::
{
    SendChat("Семья McLaren ищет родствеников.")
}
return

;=========================================================================
LAlt & 1::
izi:="-1"
File = %A_MyDocuments%\GTA San Andreas User Files\SAMP\chatlog.txt
Loop, Read, %File%
   {
   if RegExMatch(A_LoopReadLine, "[A-Za-z_0-9]*\(тел\.")
      izi:=id1
   }
if (izi!="-1")
{
   SendChat("/p")
   SendChat("Добрый день. Это FBI.")
   sleep 1000
   SendChat("Мы вычислили Ваш IP адрес и уже знаем где Вы находитесь.")
   sleep 1200
   SendChat("Ожидайте, скоро к Вам подъеду 4 мужчины в костюмах.")
   sleep 1200
   SendChat("Всего Вам доброго!")
   sleep 200
   SendChat("/h")
   
}
return


;=========================================================================

End::
addChatMessage("{FFC800}[Подсказка] {ffffff}Скрипт {00FF00}успешно {ffffff}перезагружен. ")
Reload
return




