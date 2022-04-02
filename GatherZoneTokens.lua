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

local WORLD_MAP_ID = 946

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

local MapIdToTokenMap = {
		[14] = "AZEROTH",

	-- Kalimdor
		[13] = "KALIMDOR",
		[772] = "AHNQIRAJ_THE_FALLEN_KINGDOM",
		[894] = "AMMEN_VALE",
		[43]  = "ASHENVALE",
		[181] = "AZSHARA",
		[464] = "AZUREMYST_ISLE",
		[476] = "BLOODMYST_ISLE",
		[890] = "CAMP_NARACHE",
		[42]  = "DARKSHORE",
		[381] = "DARNASSUS",
		[101] = "DESOLACE",
		[4]   = "DUROTAR",
		[141] = "DUSTWALLOW_MARSH",
		[891] = "ECHO_ISLES",
		[471] = "EXODAR",
		[182] = "FELWOOD",
		[121] = "FERALAS",
		[241] = "MOONGLADE",
		[606] = "MOUNT_HYJAL",
		[9]   = "MULGORE",
		[11]  = "NORTHERN_BARRENS",
		[321] = "ORGRIMMAR",
		[888] = "SHADOWGLEN",
		[261] = "SILITHUS",
		[607] = "SOUTHERN_BARRENS",
		[81]  = "STONETALON_MOUNTAINS",
		[161] = "TANARIS",
		[41]  = "TELDRASSIL",
		[61]  = "THOUSAND_NEEDLES",
		[362] = "THUNDER_BLUFF",
		[720] = "ULDUM",
		[201] = "UNGORO_CRATER",
		[889] = "VALLEY_OF_TRIALS",
		[281] = "WINTERSPRING",

	-- Eastern Kingdoms
		[614] = "ABYSSAL_DEPTHS",
		[16]  = "ARATHI_HIGHLANDS",
		[17]  = "BADLANDS",
		[19]  = "BLASTED_LANDS",
		[29]  = "BURNING_STEPPES",
		[673] = "CAPE_OF_STRANGLETHORN",
		[866] = "COLDRIDGE_VALLEY",
		[32]  = "DEADWIND_PASS",
		[892] = "DEATHKNELL",
		[27]  = "DUN_MOROGH",
		[34]  = "DUSKWOOD",
		[23]  = "EASTERN_PLAGUELANDS",
		[30]  = "ELWYNN_FOREST",
		[462] = "EVERSONG_WOODS",
		[463] = "GHOSTLANDS",
		[24]  = "HILLSBRAD_FOOTHILLS",
		[26]  = "HINTERLANDS",
		[341] = "IRONFORGE",
		[610] = "KELPTHAR_FOREST",
		[35]  = "LOCH_MODAN",
		[895] = "NEW_TINKERTOWN",
		[37]  = "NORTHERN_STRANGLETHORN",
		[864] = "NORTHSHIRE",
		
		[499] = "QUEL_DANAS",
		[122] = "QUEL_DANAS",
		
		[36]  = "REDRIDGE_MOUNTAINS",
		[684] = "RUINS_OF_GILNEAS",
		[685] = "RUINS_OF_GILNEAS_CITY",
		[28]  = "SEARING_GORGE",
		[615] = "SHIMMERING_EXPANSE",
		[480] = "SILVERMOON",
		[21]  = "SILVERPINE_FOREST",
		[301] = "STORMWIND",
		[689] = "STRANGLETHORN_VALE",
		[893] = "SUNSTRIDER_ISLE",
		[38]  = "SWAMP_OF_SORROWS",
		[20]  = "TIRISFAL_GLADES",
		[708] = "TOL_BARAD",
		[709] = "TOL_BARAD_PENINSULA",
		[700] = "TWILIGHT_HIGHLANDS",
		[382] = "UNDERCITY",
		[613] = "VASHJIR",
		[22]  = "WESTERN_PLAGUELANDS",
		[39]  = "WESTFALL",
		[40]  = "WETLANDS",

	-- Outland
		[466] = "OUTLAND",
		[475] = "BLADES_EDGE_MOUNTAINS",
		[465] = "HELLFIRE_PENINSULA",
		[477] = "NAGRAND",
		[479] = "NETHERSTORM",
		[473] = "SHADOWMOON_VALLEY",
		[481] = "SHATTRATH",
		[478] = "TEROKKAR_FOREST",
		[467] = "ZANGARMARSH",

	-- Northrend
		[485] = "NORTHREND",
		[486] = "BOREAN_TUNDRA",
		[510] = "CRYSTALSONG_FOREST",
		[504] = "DALARAN",
		[488] = "DRAGONBLIGHT",
		[490] = "GRIZZLY_HILLS",
		[491] = "HOWLING_FJORD",
		[541] = "HROTHGARS_LANDING",
		[492] = "ICECROWN_GLACIER",
		[501] = "LAKE_WINTERGRASP",
		[493] = "SHOLAZAR_BASIN",
		[495] = "STORM_PEAKS",
		[496] = "ZULDRAK",

	-- The Maelstrom
		[751] = "MAELSTROM_CONTINENT",
		[640] = "DEEPHOLM",
		[605] = "KEZAN",
		[544] = "LOST_ISLES",
		[737] = "MAELSTROM",

	-- Pandaria
		[862] = "PANDARIA",
		[858] = "DREAD_WASTES",
		[806] = "JADE_FOREST",
		[857] = "KRASARANG_WILDS",
		[809] = "KUNLAI_SUMMIT",
		[905] = "SHRINE_OF_SEVEN_STARS",
		[903] = "SHRINE_OF_TWO_MOONS",
		[810] = "TOWNLONG_STEPPES",
		[811] = "VALE_OF_ETERNAL_BLOSSOMS",
		[807] = "VALLEY_OF_THE_FOUR_WINDS",
		[873] = "VEILED_STAIR",
		[928] = "ISLE_THUNDER",
		[929] = "ISLE_GIANTS",
		[951] = "TIMELESS_ISLE",
	
	-- Draenor
		[962] = "DRAENOR",
		[978] = "DRAENOR_ASHRAN",
		[941] = "DRAENOR_FROSTFIRE_RIDGE",
		[949] = "DRAENOR_GORGROND",
		[950] = "DRAENOR_NAGRAND",
		[947] = "DRAENOR_SHADOWMOON_VALLEY",
		[948] = "DRAENOR_SPIRES_OF_ARAK",
		[946] = "DRAENOR_TALADOR",
		[945] = "DRAENOR_TANAAN_JUNGLE",
		[1009] = "ASHRAN_ALLIANCE_HUB",
		[1011] = "ASHRAN_HORDE_HUB",
	
	-- MISC
		[971] = "GARRISON_ALLIANCE_TIER3",	-- only shows up sometimes, and has multiple names? Wowhead has no record for it.
		[976] = "GARRISON_HORDE_TIER3",
	
	-- Broken Isles
		[1007] = "LEGION_BROKENISLES",
		[1014] = "LEGION_DALARAN",
		[1015] = "LEGION_AZSUNA",
		[1017] = "LEGION_STORMHEIM",
		[1018] = "LEGION_VALSHARA",
		[1021] = "LEGION_BROKEN_SHORE",
		[1024] = "LEGION_HIGHMOUNTAIN",
		[1096] = "LEGION_EYE_OF_AZSHARA",
		[1033] = "LEGION_SURAMAR",
		[1072] = "LEGION_TRUESHOTLODGE",
		[1077] = "LEGION_DREAMGROVE",
		[1080] = "LEGION_THUNDERTOTEM",

  -- Argus
		[1184] = "LEGION_ARGUS",
		[1135] = "LEGION_KROKUUN",
		[1171] = "LEGION_ANTORAN_WASTES",
		[1170] = "LEGION_MACAREE",
		
  -- BfA
    
  -- The Shadowlands
        [1550] = "SHADOWLANDS",
        [1525] = "SHADOWLANDS_REVENDRETH",
        [1536] = "SHADOWLANDS_MALDRAXXUS",
        [1533] = "SHADOWLANDS_BASTION",
        [1565] = "SHADOWLANDS_ARDENWEALD",
        [1970] = "SHADOWLANDS_ZERETH_MORTIS",
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
        -- print("continent id: "..id.." | map id: "..id_.." | name: "..name_  )
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
