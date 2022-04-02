--[[
	Gatherer Addon for World of Warcraft(tm).
	Version: 7.0.1 (<%codename%>)
	Revision: $Id: GatherZoneTokens.lua 1182 2017-09-19 15:59:33Z dinesh $

	License:
		This program is free software; you can redistribute it and/or
		modify it under the terms of the GNU General Public License
		as published by the Free Software Foundation; either version 2
		of the License, or (at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program(see GPL.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

	Note:
		This AddOn's source code is specifically designed to work with
		World of Warcraft's interpreted AddOn system.
		You have an implicit licence to use this AddOn with these facilities
		since that is it's designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat

	Functions for converting to and from the locale independent zone tokens
--]]
Gatherer_RegisterRevision("$URL: http://svn.norganna.org/gatherer/tags/REL_7.3.1/Gatherer/GatherZoneTokens.lua $", "$Rev: 1182 $")

-- reference to the Astrolabe mapping library
--local Astrolabe = DongleStub(Gatherer.AstrolabeVersion)
local HBD = LibStub("HereBeDragons-2.0")    

local _tr = Gatherer.Locale.Tr
local _trC = Gatherer.Locale.TrClient
local _trL = Gatherer.Locale.TrLocale

local metatable = { __index = getfenv(0) }
setmetatable( Gatherer.ZoneTokens, metatable )
setfenv(1, Gatherer.ZoneTokens)

local WORLD_MAP_ID = 947

------ to store GetMapZones
local mapZonesByContinentID = {}
------
local allZonesByContinent = {}

print("GatherZoneTokens.lua loaded")

------------ from libTourist
function GetMapContinents()
	local continents = C_Map.GetMapChildrenInfo(WORLD_MAP_ID, Enum.UIMapType.Continent, true)
	local retValue = {}
	for i, continentInfo in ipairs(continents) do
		--trace("Continent "..tostring(i)..": "..continentInfo.mapID..": ".. continentInfo.name)
		retValue[continentInfo.mapID] = continentInfo.name
	end
	return retValue
end

----------- from recipe radar
function GetMapZones(continentID)
	if mapZonesByContinentID[continentID] then
		-- Get from cache
		return mapZonesByContinentID[continentID]
	else	
		local mapZones = {}
		local recursive = (continentID ~= WORLD_MAP_ID )  -- 947 = Azeroth, parent for Nazjatar zone -> get Nazjatar only and not all zones of the Azeroth continents
		local mapChildrenInfo = { C_Map.GetMapChildrenInfo(continentID, Enum.UIMapType.Zone, recursive) }
		for key, zones in pairs(mapChildrenInfo) do  -- don't know what this extra table is for
			for zoneIndex, zone in pairs(zones) do
				-- Get the localized zone name
				mapZones[zone.mapID] = zone.name
			end
		end

		-- Add to cache
		mapZonesByContinentID[continentID] = mapZones		
		
		return mapZones
	end
end

--------------

--- ZONE TOKENS ARE ALLL WRONG GOTTA UPDATE TO 8.0.1 NEW UiMapIDs

local MapIdToTokenMap = {
		[947] = "AZEROTH",

	-- Kalimdor
		[12] = "KALIMDOR",
		[327] = "AHNQIRAJ_THE_FALLEN_KINGDOM",
		[468] = "AMMEN_VALE",
		[63]  = "ASHENVALE",
		[76] = "AZSHARA",
		[97] = "AZUREMYST_ISLE",
		[106] = "BLOODMYST_ISLE",
		[462] = "CAMP_NARACHE",
		[62]  = "DARKSHORE",
		[89] = "DARNASSUS",
		[66] = "DESOLACE",
		[1]   = "DUROTAR",
		[70] = "DUSTWALLOW_MARSH",
		[463] = "ECHO_ISLES",
		[103] = "EXODAR",
		[77] = "FELWOOD",
		[69] = "FERALAS",
		[80] = "MOONGLADE",
		[198] = "MOUNT_HYJAL",
		[7]   = "MULGORE",
		[10]  = "NORTHERN_BARRENS",
		[85] = "ORGRIMMAR",
		[460] = "SHADOWGLEN",
		[81] = "SILITHUS",
		[199] = "SOUTHERN_BARRENS",
		[65]  = "STONETALON_MOUNTAINS",
		[71] = "TANARIS",
		[57]  = "TELDRASSIL",
		[64]  = "THOUSAND_NEEDLES",
		[88] = "THUNDER_BLUFF",
		[249] = "ULDUM",
		[78] = "UNGORO_CRATER",
		[461] = "VALLEY_OF_TRIALS",
		[83] = "WINTERSPRING",

	-- Eastern Kingdoms
	    [13] = "EASTER_KINGDOMS",
		[204] = "ABYSSAL_DEPTHS",
		[14]  = "ARATHI_HIGHLANDS",
		[15]  = "BADLANDS",
		[17]  = "BLASTED_LANDS",
		[36]  = "BURNING_STEPPES",
		[210] = "CAPE_OF_STRANGLETHORN",
		[427] = "COLDRIDGE_VALLEY",
		[42]  = "DEADWIND_PASS",
		[465] = "DEATHKNELL",
		[27]  = "DUN_MOROGH",
		[47]  = "DUSKWOOD",
		[23]  = "EASTERN_PLAGUELANDS",
		[37]  = "ELWYNN_FOREST",
		[94] = "EVERSONG_WOODS",
		[95] = "GHOSTLANDS",
		[25]  = "HILLSBRAD_FOOTHILLS",
		[26]  = "HINTERLANDS",
		[87] = "IRONFORGE",
		[201] = "KELPTHAR_FOREST",
		[48]  = "LOCH_MODAN",
		[30] = "NEW_TINKERTOWN",
		[50]  = "NORTHERN_STRANGLETHORN",
		[425] = "NORTHSHIRE",
		[122] = "QUEL_DANAS",
		[49]  = "REDRIDGE_MOUNTAINS",
		[217] = "RUINS_OF_GILNEAS",
		[218] = "RUINS_OF_GILNEAS_CITY",
		[32]  = "SEARING_GORGE",
		[205] = "SHIMMERING_EXPANSE",
		[110] = "SILVERMOON",
		[21]  = "SILVERPINE_FOREST",
		[84] = "STORMWIND",
		[224] = "STRANGLETHORN_VALE",
		[467] = "SUNSTRIDER_ISLE",
		[51]  = "SWAMP_OF_SORROWS",
		[18]  = "TIRISFAL_GLADES",
		[244] = "TOL_BARAD",
		[245] = "TOL_BARAD_PENINSULA",
		[241] = "TWILIGHT_HIGHLANDS",
		[90] = "UNDERCITY",
		[203] = "VASHJIR",
		[22]  = "WESTERN_PLAGUELANDS",
		[52]  = "WESTFALL",
		[5]  = "WETLANDS",

	-- Outland
		[101] = "OUTLAND",
		[105] = "BLADES_EDGE_MOUNTAINS",
		[100] = "HELLFIRE_PENINSULA",
		[107] = "NAGRAND",
		[109] = "NETHERSTORM",
		[104] = "SHADOWMOON_VALLEY",
		[111] = "SHATTRATH",
		[108] = "TEROKKAR_FOREST",
		[102] = "ZANGARMARSH",

	-- Northrend
		[113] = "NORTHREND",
		[114] = "BOREAN_TUNDRA",
		[127] = "CRYSTALSONG_FOREST",
		[125] = "DALARAN",
		[115] = "DRAGONBLIGHT",
		[116] = "GRIZZLY_HILLS",
		[117] = "HOWLING_FJORD",
		[170] = "HROTHGARS_LANDING",
		[118] = "ICECROWN",
		[123] = "WINTERGRASP",
		[119] = "SHOLAZAR_BASIN",
		[120] = "STORM_PEAKS",
		[121] = "ZULDRAK",

	-- The Maelstrom
		[948] = "MAELSTROM_CONTINENT", --??
		[207] = "DEEPHOLM",
		[194] = "KEZAN",
		[174] = "LOST_ISLES",
		[276] = "MAELSTROM",           ---??

	-- Pandaria
		[424] = "PANDARIA",
		[422] = "DREAD_WASTES",
		[371] = "JADE_FOREST",
		[418] = "KRASARANG_WILDS",
		[379] = "KUNLAI_SUMMIT",
		[393] = "SHRINE_OF_SEVEN_STARS_EMPEROR_STEPS",
		[394] = "SHRINE_OF_SEVEN_STARS_IMPERIAL_EXANGE",		
		[391] = "SHRINE_OF_TWO_MOONS_HALL_OF_THE_CRESCENT",
     	[392] = "SHRINE_OF_TWO_MOONS_IMPERIAL_MERCANTILE",
		[388] = "TOWNLONG_STEPPES",
		[390] = "VALE_OF_ETERNAL_BLOSSOMS",
		[376] = "VALLEY_OF_THE_FOUR_WINDS",
		[433] = "VEILED_STAIR",
		[504] = "ISLE_THUNDER",
		[507] = "ISLE_GIANTS",
		[554] = "TIMELESS_ISLE",
	
	-- Draenor
		[572] = "DRAENOR",
		[588] = "DRAENOR_ASHRAN",
		[525] = "DRAENOR_FROSTFIRE_RIDGE",
		[543] = "DRAENOR_GORGROND",
		[550] = "DRAENOR_NAGRAND",
		[539] = "DRAENOR_SHADOWMOON_VALLEY",
		[542] = "DRAENOR_SPIRES_OF_ARAK",
		[535] = "DRAENOR_TALADOR",
		[534] = "DRAENOR_TANAAN_JUNGLE",
		[1408] = "ASHRAN_ALLIANCE_HUB",
		[1478] = "ASHRAN_HORDE_HUB",
	
	-- MISC NEEDS TESTING
		[971] = "GARRISON_ALLIANCE_TIER3",	-- only shows up sometimes, and has multiple names? Wowhead has no record for it.
		[976] = "GARRISON_HORDE_TIER3",
	
	-- Broken Isles
		[619] = "LEGION_BROKENISLES",
		[627] = "LEGION_DALARAN",
		[630] = "LEGION_AZSUNA",
		[634] = "LEGION_STORMHEIM",
		[641] = "LEGION_VALSHARA",
		[646] = "LEGION_BROKEN_SHORE",
		[650] = "LEGION_HIGHMOUNTAIN",
		[790] = "LEGION_EYE_OF_AZSHARA",
		[680] = "LEGION_SURAMAR",
		[739] = "LEGION_TRUESHOTLODGE",
		[747] = "LEGION_DREAMGROVE",
		[750] = "LEGION_THUNDERTOTEM",

  -- Argus
		[905] = "LEGION_ARGUS",
		[830] = "LEGION_KROKUUN",
		[885] = "LEGION_ANTORAN_WASTES",
		[882] = "LEGION_MACAREE",
		
  -- BfA
    
  -- The Shadowlands
        [1550] = "SHADOWLANDS",
        [1525] = "SHADOWLANDS_REVENDRETH",
        [1536] = "SHADOWLANDS_MALDRAXXUS",
        [1533] = "SHADOWLANDS_BASTION",
        [1565] = "SHADOWLANDS_ARDENWEALD",
        [1970] = "SHADOWLANDS_ZERETH_MORTIS",
  -- Zereth Mortis
        [2046] = "ZERETH_MORTIS"

}


-- convert list of zoneID1, zoneName1, zoneID2, zoneName2, etc.
-- into just a list of zone names
local function stripZoneIDs(list)
   print("called function stripZoneIds")
   local temp = {};
   local index = 1;
   local n = select("#", list)
   --print("zoneList count = ", n );
   for k,v in pairs(list) do
      --  print("strip | key: "..k.."value: "..v )
      temp[index] = v
      --print("  item = ", temp[index] )
      index = index + 1
   end
   return temp;
end


Tokens = {}
TokensByContinent = {}
TokenToMapID = {}
ZoneNames = stripZoneIDs(GetMapContinents())

unrecognizedZones = {}

Ver3To4TempTokens = {
	["AhnQirajTheFallenKingdom"] = "AHNQIRAJ_THE_FALLEN_KINGDOM",
	["Uldum"] = "ULDUM",
	["SouthernBarrens"] = "SOUTHERN_BARRENS",
	["Orgrimmar"] = "ORGRIMMAR",
	["Hyjal_terrain1"] = "MOUNT_HYJAL",
	["Darnassus"] = "DARNASSUS",
	["VashjirRuins"] = "SHIMMERING_EXPANSE",
	["StormwindCity"] = "STORMWIND",
	["RuinsofGilneasCity"] = "RUINS_OF_GILNEAS_CITY",
	["StranglethornVale"] = "STRANGLETHORN_VALE",
	["TwilightHighlands"] = "TWILIGHT_HIGHLANDS",
	["VashjirKelpForest"] = "KELPTHAR_FOREST",
	["HillsbradFoothills"] = "HILLSBRAD_FOOTHILLS",
	["StranglethornJungle"] = "NORTHERN_STRANGLETHORN",
	["RuinsofGilneas"] = "RUINS_OF_GILNEAS",
	["Vashjir"] = "VASHJIR",
	["TolBaradDailyArea"] = "TOL_BARAD_PENINSULA",
	["TolBarad"] = "TOL_BARAD",
	["TheCapeOfStranglethorn"] = "CAPE_OF_STRANGLETHORN",
	["VashjirDepths"] = "ABYSSAL_DEPTHS",
	["Kezan"] = "KEZAN",
	["TheLostIsles"] = "LOST_ISLES",
	["Deepholm"] = "DEEPHOLM",
	["TheMaelstrom"] = "MAELSTROM",
}

-- ??
local continentWorldMapIDs = {}
for i, _ in pairs(GetMapContinents()) do
	continentWorldMapIDs[i] = C_Map.GetMapInfo(i)
end

-- this funtions creates a table with continent id, zone id, and zone id as follows: {id,{id_, name_}}
for id, name in pairs(GetMapContinents()) do
    local temporal_list = {}
    for id_, name_ in pairs(GetMapZones(id)) do
        print("continent id: "..id.." | map id: "..id_.." | name: "..name_  )
        table.insert(temporal_list, id_)
        
    end
    allZonesByContinent[id] = temporal_list
end

-- this appears to search for new zones not listed in the internal database or
-- zones not foud by the addon for any reason
for continent, zoneList in pairs(allZonesByContinent) do
	local continentZoneNames = stripZoneIDs(GetMapZones(continent))	-- incomplete list, due to Blizzard bugs
	ZoneNames[continent] = { CONTINENT = ZoneNames[continent] }
	local tokenMap = {}
	for zoneIndex, mapID in pairs(zoneList) do
		if ( zoneIndex > 0 ) then
			local zoneName = continentZoneNames[zoneIndex]
			--print("zone name: "..zoneName)
			if (not zoneName) then	-- because Blizz doesn't include all zones in continents...
				zoneName = HBD.mapData[mapID]._name
			print("HBD zone name: "..zoneName)
			end
			local zoneToken = MapIdToTokenMap[mapID]
			if (not zoneToken) then
				-- use the mapID as a temporary token and save it so we can warn the user
				zoneToken = mapID;
				table.insert(unrecognizedZones, zoneName.." ("..mapID..")")
			end
			Tokens[zoneToken] = zoneToken
			Tokens[mapID] = zoneToken
			tokenMap[zoneIndex] = zoneToken
			tokenMap[zoneToken] = zoneIndex
			TokenToMapID[zoneToken] = mapID
			ZoneNames[continent][zoneToken] = zoneName
			ZoneNames[zoneToken] = zoneName
			if not ( ZoneNames[ zoneName ] ) then
				ZoneNames[ zoneName ] = zoneToken
			else
				if not ( type(ZoneNames[ zoneName ]) == "table" ) then
					local origZoneToken = ZoneNames[ zoneName ]
					ZoneNames[ zoneName ] = {}
					ZoneNames[ zoneName ][""] = origZoneToken
				end
				ZoneNames[ zoneName ][ continentWorldMapIDs[continent] ] = zoneToken
			end
		end
	end
	TokensByContinent[continent] = tokenMap
end

if ( next(unrecognizedZones) ) then
	-- some zones were unrecognized, warn user
	local zoneList = string.join(", ", unpack(unrecognizedZones))
	Gatherer.Locale.SECTION_HIGHLIGHT_CODE = HIGHLIGHT_FONT_COLOR_CODE
	Gatherer.Notifications.AddInfo(_tr("ZONETOKENS_UNIDENTIFIED_ZONES_WARNING", zoneList))
end
unrecognizedZones = nil


function GetZoneTokenByContZone( continent, zone )
	if not ( TokensByContinent[continent] ) then
		return nil
	end
	local val = TokensByContinent[continent][zone]
	if ( val ) then
		if ( type(zone) == "number" ) then
			return val
		else
			return zone
		end
	else
		-- try other sources
		val = Ver3To4TempTokens[zone]
		if ( val ) then
			return val
		end
	end
end

function GetContinentAndZone( token )
	for continent, zoneTokens in pairs(TokensByContinent) do
		if ( zoneTokens[token] ) then
			return continent, zoneTokens[token]
		end
	end
end

function GetZoneIndex( continent, token )
	if not ( Tokens[continent] ) then
		return nil
	end
	local val = Tokens[continent][token]
	if ( val ) then
		if ( type(token) == "string" ) then
			return val
		else
			return token
		end
	end
end

--function GetZoneMapID( continent, token )
--	local zone = nil
--	if ( Tokens[continent] ) then
--		zone = Tokens[continent][token]
--	end
--	if ( type(zone) ~= "number" and type(token) == "number" ) then
--		zone = Tokens[continent][Tokens[continent][token]]
--	end
--	return Astrolabe:GetMapID(continent, zone)
--end

function getFloors( mapID )
    local map = C_Map.GetMapGroupMembersInfo(mapID)
    local floors = 0
    if ( map ) then
        for k,v in pairs(map) do
           if ( k ) then
               floors = k
           end
        end
        return floors
    end
end

function GetZoneMapIDAndFloor( mapToken )
	local mapID = TokenToMapID[mapToken]
	if ( mapID ) then
		return mapID, ((getFloors(mapID) == 0) and 0 or 1)
	end
end

function GetZoneToken( mapID )
	local token = Tokens[mapID]
--	if (not token) then token = tostring(mapID) end	-- temporarily deal with Blizz borked zones, so we can debug
	return token
end

function getPlayerCurrentPosition()
    local map = C_Map.GetBestMapForUnit("player")
    local position = C_Map.GetPlayerMapPosition(map, "player")
    return position
end
