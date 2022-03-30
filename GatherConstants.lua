--[[
	Various Constant Information definitions
	Revision: $Id: GatherConstants.lua 1182 2017-09-19 15:59:33Z dinesh $

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

]]
Gatherer_RegisterRevision("$URL: http://svn.norganna.org/gatherer/tags/REL_7.3.1/Gatherer/GatherConstants.lua $", "$Rev: 1182 $")

local metatable = { __index = getfenv(0) }
setmetatable( Gatherer.Constants, metatable )
setfenv(1, Gatherer.Constants)

Gatherer.Var.Skills.OPEN = true

-- Skill levels required
SkillLevel = {
-- Ores
["ORE_COPPER"] = 1,
["ORE_TIN"] = 1,
["ORE_INCENDICITE"] = 50,
["ORE_SILVER"] = 50,
["ORE_BLOODSTONE"] = 65,
["ORE_IRON"] = 100,
["ORE_INDURIUM"] = 150,
["ORE_GOLD"] = 115,
["ORE_MITHRIL"] = 150,
["ORE_DARKIRON"] = 175,
["ORE_TRUESILVER"] = 165,
["ORE_THORIUM"] = 200,
["ORE_RTHORIUM"] = 215,
["ORE_OBSIDIAN"] = 305,
-- TBC ORES
["ORE_FELIRON"] = 275,
["ORE_ADAMANTITE"] = 325,
["ORE_ETERNIUM"] = 350,
["ORE_KHORIUM"] = 375,
["ORE_RADAMANTITE"] = 350,
["ORE_NETHERCITE"] = 275,
-- WotLK ores
["ORE_COBALT"] = 350,
["ORE_RCOBALT"] = 375,
["ORE_SARONITE"] = 400,
["ORE_RSARONITE"] = 425,
["ORE_TITANIUM"] = 450,
-- Cata ores
["ORE_OBSIDIUM"] = 425,
["ORE_ROBSIDIUM"] = 450,
["ORE_ELEMENTIUM"] = 475,
["ORE_RELEMENTIUM"] = 500,
["ORE_PYRITE"] = 525,
["ORE_RPYRITE"] = 525,
-- MoP Ores, which technically require just level 1
["ORE_GHOSTIRON"] = 500,
["ORE_RGHOSTIRON"] = 550,
["ORE_KYPARITE"] = 550,
["ORE_RKYPARITE"] = 575,
["ORE_TRILLIUM"] = 600,
["ORE_RTRILLIUM"] = 600,
-- WoD Ores, which technically require just level 1
["ORE_TRUEIRON"] = 610, -- True Iron Deposit
["ORE_RTRUEIRON"] = 610, -- Rich True Iron Deposit
["ORE_BLACKROCK"] = 610, -- Blackrock Deposit
["ORE_RBLACKROCK"] = 610, -- Rich Blackrock Deposit
-- Legion Ores, which technically require just level 1
["ORE_LEYSTONE"] = 710,
["ORE_RLEYSTONE"] = 710,
["ORE_SEAMLEYSTONE"] = 710,
["ORE_FELSLATE"] = 710,
["ORE_RFELSLATE"] = 710,
["ORE_SEAMFELSLATE"] = 710,
["ORE_EMPYRIUM"] = 710,
["ORE_REMPYRIUM"] = 710,
["ORE_SEAMEMPYRIUM"] = 710,

-- Herbs
["HERB_PEACEBLOOM"] = 1,
["HERB_SILVERLEAF"] = 1,
["HERB_EARTHROOT"] = 1,
["HERB_MAGEROYAL"] = 1,
["HERB_BRIARTHORN"] = 1,
["HERB_SWIFTTHISTLE"] = 50,
["HERB_STRANGLEKELP"] = 85,
["HERB_BRUISEWEED"] = 1,
["HERB_WILDSTEELBLOOM"] = 115,
["HERB_GRAVEMOSS"] = 105,
["HERB_KINGSBLOOD"] = 125,
["HERB_LIFEROOT"] = 150,
["HERB_FADELEAF"] = 150,
["HERB_GOLDTHORN"] = 150,
["HERB_KHADGARSWHISKER"] = 160,
["HERB_WINTERSBITE"] = 195, -- Dragon's Teeth
["HERB_FIREBLOOM"] = 205,
["HERB_PURPLELOTUS"] = 210,
["HERB_WILDVINE"] = 210,
["HERB_ARTHASTEAR"] = 220,
["HERB_SUNGRASS"] = 230,
["HERB_BLINDWEED"] = 235,
["HERB_GHOSTMUSHROOM"] = 245,
["HERB_GROMSBLOOD"] = 250,
["HERB_GOLDENSANSAM"] = 260,
["HERB_DREAMFOIL"] = 270,
["HERB_ICECAP"] = 270,
["HERB_MOUNTAINSILVERSAGE"]= 280,
["HERB_PLAGUEBLOOM"] = 285,
["HERB_SORROWMOSS"] = 285,
["HERB_BLACKLOTUS"] = 300,
-- TBC HERBS
["HERB_FELWEED"] = 300,
["HERB_DREAMINGGLORY"] = 315,
["HERB_TEROCONE"] = 325,
["HERB_RAGVEIL"] = 325,
["HERB_NETHERBLOOM"] = 350,
["HERB_FLAMECAP"] = 335,
["HERB_BLOODTHISTLE"] = 1, -- Bloodthistle
["HERB_ANCIENTLICHEN"] = 340, -- Ancient Lichen
["HERB_NIGHTMAREVINE"] = 365, -- Nightmare Vine
["HERB_MANATHISTLE"] = 375, -- Mana Thistle
["HERB_NETHERDUST"] = 350,
-- WotLK herbs
["HERB_GOLDCLOVER"] = 350,
["HERB_TIGERLILY"] = 375,
["HERB_TALANDRASROSE"] = 385,
["HERB_LICHBLOOM"] = 425,
["HERB_ICETHORN"] = 435,
["HERB_FROZENHERB"] = 400,
["HERB_FROSTLOTUS"] = 450,
["HERB_ADDERSTONGUE"] = 400,
["HERB_FIRETHORN"] = 360,
-- Cata herbs
["HERB_CINDERBLOOM"] = 425,
["HERB_STORMVINE"] = 425,
["HERB_AZSHARASVEIL"] = 425,
["HERB_HEARTBLOSSOM"] = 475,
["HERB_WHIPTAIL"] = 500,
["HERB_TWILIGHTJASMINE"] = 525,
-- MoP Herbs, which technically require level 1
["HERB_GREENTEALEAF"] = 500, -- Green Tea Leaf
["HERB_RAINPOPPY"] = 525, -- Rain Poppy
["HERB_SILKWEED"] = 545, -- Silkweed
["HERB_GOLDENLOTUS"] = 550, -- Golden Lotus
["HERB_SHATOUCHEDHERB"] = 575, -- Sha-Touched Herb
["HERB_SNOWLILY"] = 575, -- Snow Lily
["HERB_FOOLSCAP"] = 600, -- Fool's Cap
-- WoD Herbs, which technically require level 1
["HERB_FROSTWEED"] = 610, -- Frostweed
["HERB_FIREWEED"] = 610, -- Fireweed
["HERB_GORGRONDFLYTRAP"] = 610, -- Gorgrond Flytrap
["HERB_STARFLOWER"] = 610, -- Starflower
["HERB_NAGRANDARROWBLOOM"] = 610, -- Nagrand Arrowbloom
["HERB_TALADORORCHID"] = 610, -- Talador Orchid
["HERB_WITHEREDHERB"] = 610, -- Withered Herb
-- Legion Herbs, which technically require level 1
["HERB_AETHRIL"] = 710,
["HERB_DREAMLEAF"] = 710,
["HERB_FOXFLOWER"] = 710,
["HERB_FJARNSKAGGL"] = 710,
["HERB_STARLIGHTROSE"] = 710,
["HERB_FELENCRUSTEDHERB"] = 710,
["HERB_FELENCRUSTEDCLUSTER"] = 710,
["HERB_ASTRALGLORY"] = 710,

	-- Archaeology
	["ARCH_DRAENEI"] = 300,		-- Draenei Archaeology Find
	["ARCH_DWARF"] = 1,		-- Dwarf Archaeology Find
	["ARCH_FOSSIL"] = 1,		-- Fossil Archaeology Find
	["ARCH_NERUBIAN"] = 375,	-- Nerubian Archaeology Find
	["ARCH_NIGHTELF"] = 1,		-- Night Elf Archaeology Find
	["ARCH_ORC"] = 300,		-- Orc Archaeology Find
	["ARCH_TOLVIR"] = 450,		-- Tol'vir Archaeology Find
	["ARCH_TROLL"] = 1,		-- Troll Archaeology Find
	["ARCH_VRYKUL"] = 375,		-- Vrykul Archaeology Find

-- WoD Archaeology nodes?
-- Legion Archaeology nodes?

}

-- lists item categories which are tracked by a tracking skill
-- that is different from their gather type
TrackingOverrides = {
	["TREASURE_BLOODPETAL"] = "HERB",
}

-- This table defines remappings of old object ids which need
-- to be remapped to new ones
Gatherer.Nodes.ReMappings = {
	[183043] = 181275,
	[2846] = 2844,
	[164883] = 174622, -- Cleansed Whipper Root re-numbered to 174622
}

-- Keys in this table must match the 'texture' (2nd) value returned by GetTrackingInfo(id)
TrackingTextures = {
	[136025] = "MINE",
	[133939] = "HERB",
	--["Interface\\Icons\\Racial_Dwarf_FindTreasure"] = "OPEN", -- racial no longer exists
	[133888] = "FISH",
}

-- Keys in this table must match the 'texture' (2nd) value returned by GetProfessionInfo(id)
ProfessionTextures = {
	[134708] = "MINE",
	[136246] = "HERB",
	[136245] = "FISH",
	[441139] = "ARCH",
}

SupportedGatherTypes = {
	MINE = "MINE",
	HERB = "HERB",
	OPEN = "OPEN",
	ARCH = "ARCH",
}

SurveySpellName = GetSpellInfo(80451)
