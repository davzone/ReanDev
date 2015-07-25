/* 
* updates\world\2012_09_16_00_world_version.sql 
*/ 
UPDATE `version` SET `db_version`='TDB 335.49', `cache_id`=49 LIMIT 1;
 
 
/* 
* updates\world\2012_09_16_01_world_conditions.sql 
*/ 
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=10 AND `SourceGroup`=34379;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(10,34379,50452,0,0,19,0,8,0,0,0,0,'', 'Wodin''s Lucky Necklace only 25 heroic'),
(10,34379,50453,0,0,19,0,8,0,0,0,0,'', 'Ring of Rotting Sinew only 25 heroic');
 
 
/* 
* updates\world\2012_09_16_01_world_creature_loot_template.sql 
*/ 
UPDATE `creature_loot_template` SET `item`=39657 WHERE `entry`=28546 AND `item`=36657;
 
 
/* 
* updates\world\2012_09_16_01_world_creature_template_addon.sql 
*/ 
DELETE FROM `creature_template_addon` WHERE `entry`=28670; -- Frostbrood Vanquisher
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES 
(28670,0,0,0x3000000,0x1,0,'53112');
 
 
/* 
* updates\world\2012_09_16_02_world_fires_over_skettis.sql 
*/ 
-- Add support for quest ID: 11008 - "Fires Over Skettis" Warpten fix and Nelegalno/shlomi1515 updates
-- Also add support for achievement - http://www.wowhead.com/achievement=1275/bombs-away
-- Fix previous SQL what is not changed is not included
SET @TRIGGER := 22991;
SET @EGG := 185549;
SET @SKYBLAST := 39844;
SET @SUMMEGG := 39843;
-- Adds SAI support for Monstrous Kaliri Egg Trigger and the GO
UPDATE `creature_template` SET `AIName`= 'SmartAI' WHERE `entry`=@TRIGGER;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@TRIGGER AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@TRIGGER*100 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@TRIGGER,0,0,0,25,0,100,0,0,0,0,0,11,@SUMMEGG,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Monstrous Kaliri Egg Trigger - On spawn/reset - Summon Monstrous Kaliri Egg (object wild)'),
(@TRIGGER,0,1,2,8,0,100,0,@SKYBLAST,0,0,0,33,@TRIGGER,0,0,0,0,0,16,0,0,0,0,0,0,0, 'Monstrous Kaliri Egg Trigger - On Skyguard Blasting Charge hit - Give kill credit to invoker party'),
(@TRIGGER,0,2,0,61,0,100,0,0,0,0,0,80,@TRIGGER*100,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Monstrous Kaliri Egg Trigger - Linked with previous event - Start script 0'),
(@TRIGGER*100,9,0,0,0,0,100,0,44000,44000,0,0,11,@SUMMEGG,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Monstrous Kaliri Egg Trigger /On actionlist/ - Action 0 - Cast Summon Monstrous Kaliri Egg');
-- Add conditions (thanks to Vincent-Michael for adding and Shauren for noticing my failure miss)
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=@SKYBLAST;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1,@SKYBLAST,0,0,31,0,3,22991,0,0,0,'','Skyguard Blasting Charge can hit only Monstrous Kaliri Egg Trigger'),
(13,2,@SKYBLAST,0,0,31,0,5,185549,0,0,0,'','Skyguard Blasting can hit only Monstrous Kaliri Egg');
-- Remove SAI for Cannonball Stack
UPDATE `gameobject_template` SET `AIName`='' WHERE `entry`=@EGG;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@EGG AND `source_type`=1;
-- Delete GO spawns that are not needed
DELETE FROM `gameobject` WHERE `id`=@EGG;
 
 
/* 
* updates\world\2012_09_16_03_world_spell_script_names.sql 
*/ 
DELETE FROM spell_script_names WHERE scriptName="spell_dru_savage_roar";
INSERT INTO spell_script_names (spell_id, ScriptName) VALUES
(52610, 'spell_dru_savage_roar');
 
 
/* 
* updates\world\2012_09_17_00_world_spell_bonus_data.sql 
*/ 
DELETE FROM spell_bonus_data WHERE entry IN (33778,33763);
INSERT INTO spell_bonus_data (entry, direct_bonus, dot_bonus, ap_bonus, ap_dot_bonus, comments) VALUES
(33778, 0, 0, 0, 0, 'Druid - Lifebloom final heal'),
(33763, 0.516, 0.0952, 0, 0, 'Druid - Lifebloom HoT(rank 1)');
 
 
/* 
* updates\world\2012_09_17_01_world_spell_bonus_data.sql 
*/ 
DELETE FROM `spell_bonus_data` WHERE `entry` = 61840;
INSERT INTO `spell_bonus_data` (`entry`,`direct_bonus`, `dot_bonus`,`ap_bonus`,`ap_dot_bonus`,`comments`) VALUES
(61840, 0, 0, 0, 0, 'No bonus for Righteous Vengance DoT');
 
 
/* 
* updates\world\2012_09_17_01_world_spell_script_names.sql 
*/ 
DELETE FROM `spell_proc_event` WHERE `entry` IN (48492,48494,48495);
DELETE FROM `spell_script_names` WHERE `spell_id` IN(-5217, -5229);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(-5217, "spell_dru_tiger_s_fury"),
(-5229, "spell_dru_enrage");
 
 
/* 
* updates\world\2012_09_17_02_world_misc.sql 
*/ 
-- The Call to Command (6144, 6145, 6146, 14349, 14350) quest chain fix by nelegalno
-- The first 2 quests in the chain ware replaced with new ones after the removal of Varimathras (2425) but players that completed
-- the old quests shouldn't get the new ones and the third quest Nathanos' Ruse (6146) should require 6145 or 14350 completed 

-- The Call to Command ExclusiveGroup
UPDATE `quest_template` SET `ExclusiveGroup` = 6144 WHERE `Id` = 6144; -- The Call to Command (6144) quest
UPDATE `quest_template` SET `ExclusiveGroup` = 6144 WHERE `Id` = 14349; -- The Call to Command (14349) quest

-- You should be able to take the quest from Varimathras (2425) or Lady Sylvanas Windrunner (10181) [proof http://old.wowhead.com/quest=6145]
DELETE FROM `creature_questrelation` WHERE `quest` = 6145;
INSERT INTO `creature_questrelation` (`id`,`quest`) VALUES (2425, 6145);
INSERT INTO `creature_questrelation` (`id`,`quest`) VALUES (10181, 6145);

-- The Crimson Courier ExclusiveGroup
UPDATE `quest_template` SET `ExclusiveGroup` = 6145 WHERE `Id` = 6145; -- The Crimson Courier (6145) quest
UPDATE `quest_template` SET `ExclusiveGroup` = 6145 WHERE `Id` = 14350; -- The Crimson Courier (14350) quest

-- Nathanos' Ruse PrevQuestId conditions
UPDATE `quest_template` SET `PrevQuestId` = 0 WHERE `Id` = 6146;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=19 AND `SourceEntry`=6146;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(19,0,6146,0,1,8,0, 6145,0,0,0,0,'',"Nathanos' Ruse requires quest The Crimson Courier (6145)"),
(19,0,6146,0,2,8,0,14350,0,0,0,0,'',"Nathanos' Ruse requires quest The Crimson Courier (14350)");


-- The Scarlet Oracle, Demetria (6148) quest fix by nelegalno
-- TODO: NPC must spawn when the quest is acepted
SET @ID := 12339;
SET @GUID := 42575; -- set by TDB team

DELETE FROM `creature` WHERE `id`=@ID;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(@GUID,@ID,0,1,1,0,0,1567.16,-5611,114.19,1.084,900,0,1,26412,35250,2,0,0,0);

DELETE FROM `creature_template_addon` WHERE `entry`=@ID;
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(@ID,@ID,0,0,0,0,'');

DELETE FROM `waypoint_data` WHERE `id`=@ID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@ID,1,1567.42,-5610.38,114.189,0,0,0,0,100,0),
(@ID,2,1564.17,-5609.18,114.183,0,0,0,0,100,0),
(@ID,3,1566.34,-5605.47,114.183,0,0,0,0,100,0),
(@ID,4,1569.38,-5606.32,114.188,0,0,0,0,100,0),
(@ID,5,1573.89,-5597.87,111.171,0,0,0,0,100,0),
(@ID,6,1578.76,-5588.57,111.171,0,0,0,0,100,0),
(@ID,7,1585.31,-5576.2,111.171,0,0,0,0,100,0),
(@ID,8,1594.85,-5557.49,111.171,0,0,0,0,100,0),
(@ID,9,1603.55,-5557.01,111.171,0,0,0,0,100,0),
(@ID,10,1610.81,-5541.87,111.171,0,0,0,0,100,0),
(@ID,11,1604.87,-5538.01,111.171,0,0,0,0,100,0),
(@ID,12,1612.66,-5523.97,111.147,0,0,0,0,100,0),
(@ID,13,1618.32,-5514.03,107.117,0,0,0,0,100,0),
(@ID,14,1627.73,-5496.36,100.729,0,0,0,0,100,0),
(@ID,15,1633,-5484.04,100.729,0,0,0,0,100,0),
(@ID,16,1638.35,-5469.5,98.6581,0,0,0,0,100,0),
(@ID,17,1645.41,-5450.02,92.1866,0,0,0,0,100,0),
(@ID,18,1652.78,-5430.76,84.4578,0,0,0,0,100,0),
(@ID,19,1657.93,-5416.62,79.8772,0,0,0,0,100,0),
(@ID,20,1661.83,-5406.66,76.2934,0,0,0,0,100,0),
(@ID,21,1669.8,-5383.78,73.6196,0,0,0,0,100,0),
(@ID,22,1677.99,-5358.84,73.6117,0,0,0,0,100,0),
(@ID,23,1695.25,-5350.09,73.6118,0,0,0,0,100,0),
(@ID,24,1687.04,-5321.94,73.6112,0,0,0,0,100,0),
(@ID,25,1688.58,-5304.51,73.6112,0,0,0,0,100,0),
(@ID,26,1691,-5283.65,73.6122,0,0,0,0,100,0),
(@ID,27,1691.91,-5262.08,73.6113,0,0,0,0,100,0),
(@ID,28,1692.66,-5241.1,73.6185,0,0,0,0,100,0),
(@ID,29,1692.85,-5206.13,74.6546,0,0,0,0,100,0),
(@ID,30,1690.64,-5185.28,73.9301,0,0,0,0,100,0),
(@ID,31,1688.08,-5167.96,73.9937,0,0,0,0,100,0),
(@ID,32,1690.38,-5149.03,74.0396,0,0,0,0,100,0),
(@ID,33,1697.51,-5118.86,73.6245,0,0,0,0,100,0),
(@ID,34,1704.67,-5099.13,74.6873,0,0,0,0,100,0),
(@ID,35,1711.01,-5080.54,77.301,0,0,0,0,100,0),
(@ID,36,1718.55,-5057.22,80.1628,0,0,0,0,100,0),
(@ID,37,1730.24,-5032.73,80.6236,0,0,0,0,100,0),
(@ID,38,1742.91,-5011.79,79.9012,0,0,0,0,100,0),
(@ID,39,1754.95,-4994.6,80.643,0,0,0,0,100,0),
(@ID,40,1766.67,-4977.18,81.2274,0,0,0,0,100,0),
(@ID,41,1773.03,-4950.42,81.449,0,0,0,0,100,0),
(@ID,42,1777.47,-4922.77,81.5212,0,0,0,0,100,0),
(@ID,43,1782.09,-4902.3,84.2517,0,0,0,0,100,0),
(@ID,44,1788.34,-4877.56,87.4965,0,0,0,0,100,0),
(@ID,45,1796.57,-4845.8,89.4469,0,0,0,0,100,0),
(@ID,46,1809.45,-4798.58,91.0304,0,0,0,0,100,0),
(@ID,47,1816.93,-4777.84,90.0115,0,0,0,0,100,0),
(@ID,48,1831.75,-4734.83,90.0915,0,0,0,0,100,0),
(@ID,49,1862.63,-4701.05,93.0158,0,0,0,0,100,0),
(@ID,50,1889.08,-4684.05,92.355,0,0,0,0,100,0),
(@ID,51,1910.74,-4672.59,91.1087,0,0,0,0,100,0),
(@ID,52,1927.94,-4658.95,87.5957,0,0,0,0,100,0),
(@ID,53,1935.76,-4647.33,84.3063,0,0,0,0,100,0),
(@ID,54,1944.66,-4632.27,79.9795,0,0,0,0,100,0),
(@ID,55,1954.98,-4609.24,74.7545,0,0,0,0,100,0),
(@ID,56,1958.16,-4599.23,73.7161,0,0,0,0,100,0),
(@ID,57,1968.46,-4572.57,73.6229,0,0,0,0,100,0),
(@ID,58,1979.44,-4555.29,73.6229,0,0,0,0,100,0),
(@ID,59,1984,-4549.99,73.6229,0,0,0,0,100,0),
(@ID,60,1996.94,-4538.24,73.6229,0,0,0,0,100,0),
(@ID,61,2005.36,-4531.97,73.6229,0,0,0,0,100,0),
(@ID,62,2016.76,-4523.84,73.6213,0,0,0,0,100,0),
(@ID,63,2027.83,-4517.97,73.6213,0,0,0,0,100,0),
(@ID,64,2045.28,-4518.38,73.6213,0,0,0,0,100,0),
(@ID,65,2061.31,-4534.8,73.6213,0,0,0,0,100,0),
(@ID,66,2086.08,-4561.88,73.6213,0,0,0,0,100,0),
(@ID,67,2105.32,-4580.45,73.6238,0,0,0,0,100,0),
(@ID,68,2121.3,-4594.16,73.6238,0,0,0,0,100,0),
(@ID,69,2146.73,-4612.71,73.6218,0,0,0,0,100,0),
(@ID,70,2177.86,-4627.43,73.6067,0,0,0,0,100,0),
(@ID,71,2197.77,-4633.93,73.6226,0,0,0,0,100,0),
(@ID,72,2219.97,-4633.96,73.6226,0,0,0,0,100,0),
(@ID,73,2250.74,-4627.66,73.6226,0,0,0,0,100,0),
(@ID,74,2274.12,-4620.36,73.6226,0,0,0,0,100,0),
(@ID,75,2304.25,-4611.22,73.6227,0,0,0,0,100,0),
(@ID,76,2338.64,-4604.74,73.6227,0,0,0,0,100,0),
(@ID,77,2389.36,-4603.99,73.6227,0,0,0,0,100,0),
(@ID,78,2457.27,-4631.39,74.092,0,0,0,0,100,0),
(@ID,79,2493.9,-4652.17,75.2848,0,0,0,0,100,0),
(@ID,80,2535.82,-4654.52,77.3071,0,0,0,0,100,0),
(@ID,81,2567.1,-4644.61,79.4072,0,0,0,0,100,0),
(@ID,82,2594.36,-4628.84,81.876,0,0,0,0,100,0),
(@ID,83,2617.07,-4615.06,84.1387,0,0,0,0,100,0),
(@ID,84,2689.76,-4571.94,87.2045,0,0,0,0,100,0),
(@ID,85,2745.8,-4539.07,88.764,0,0,0,0,100,0),
(@ID,86,2839.33,-4436.83,89.7157,0,0,0,0,100,0),
(@ID,87,2880.41,-4361.54,90.2576,0,0,0,0,100,0),
(@ID,88,2923.76,-4110.16,96.3698,0,0,0,0,100,0),
(@ID,89,2947.2,-4033.15,99.8002,0,0,0,0,100,0),
(@ID,90,2968.64,-3982.02,104.423,0,0,0,0,100,0),
(@ID,91,2976.9,-3964.26,107.058,0,0,0,0,100,0),
(@ID,92,2983.54,-3937.96,111.717,0,0,0,0,100,0),
(@ID,93,3000.21,-3877.74,118.93,0,0,0,0,100,0),
(@ID,94,3011.92,-3842.22,119.306,0,0,0,0,100,0),
(@ID,95,3021.88,-3813.28,118.955,0,0,0,0,100,0),
(@ID,96,3028.71,-3797.17,120.17,0,0,0,0,100,0),
(@ID,97,3042.19,-3764.47,119.971,0,0,0,0,100,0),
(@ID,98,3057.23,-3724.98,119.568,0,0,0,0,100,0),
(@ID,99,3062.31,-3690.16,121.125,0,0,0,0,100,0),
(@ID,100,3048.16,-3659.65,122.811,0,0,0,0,100,0),
(@ID,101,3041.49,-3641.07,125.02,0,0,0,0,100,0),
(@ID,102,3039.91,-3617.72,123.977,0,0,0,0,100,0),
(@ID,103,3040.67,-3597.35,124.377,0,0,0,0,100,0),
(@ID,104,3042.45,-3556.22,126.571,0,0,0,0,100,0),
(@ID,105,3046.02,-3530.23,129.898,0,0,0,0,100,0),
(@ID,106,3057.06,-3493.26,131.601,0,0,0,0,100,0),
(@ID,107,3076.38,-3462.24,134.709,0,0,0,0,100,0),
(@ID,108,3086.02,-3451.18,136,0,0,0,0,100,0),
(@ID,109,3097.45,-3438.57,136.842,0,0,0,0,100,0),
(@ID,110,3133.22,-3404.77,139.345,0,0,0,0,100,0),
(@ID,111,3150.28,-3401.16,140.105,0,0,0,0,100,0),
(@ID,112,3172.46,-3393.09,142.015,0,0,0,0,100,0),
(@ID,113,3191.09,-3389.1,143.607,0,0,0,0,100,0),
(@ID,114,3210.72,-3387.02,144.24,0,0,0,0,100,0),
(@ID,115,3250.95,-3382.95,143.581,0,0,0,0,100,0),
(@ID,116,3269.06,-3382.33,143.195,0,0,0,0,100,0),
(@ID,117,3286.95,-3382.42,142.377,0,0,0,0,100,0),
(@ID,118,3307.89,-3382.95,144.951,0,0,0,0,100,0),
(@ID,119,3329.2,-3382.28,144.845,0,0,0,0,100,0),
(@ID,120,3347.55,-3381.64,144.779,0,0,0,0,100,0),
(@ID,121,3361.09,-3380.75,144.781,0,0,0,0,100,0),
(@ID,122,3339.81,-3380.58,144.774,0,0,0,0,100,0),
(@ID,123,3311.44,-3380.27,145.017,0,0,0,0,100,0),
(@ID,124,3296.01,-3380.1,143.741,0,0,0,0,100,0),
(@ID,125,3274.59,-3380.86,142.727,0,0,0,0,100,0),
(@ID,126,3274.59,-3380.86,142.727,0,0,0,0,100,0),
(@ID,127,3251.44,-3382.31,143.585,0,0,0,0,100,0),
(@ID,128,3217.38,-3385.87,144.301,0,0,0,0,100,0),
(@ID,129,3189.08,-3389.3,143.545,0,0,0,0,100,0),
(@ID,130,3168.36,-3392.69,141.758,0,0,0,0,100,0),
(@ID,131,3128.73,-3405.3,139.154,0,0,0,0,100,0),
(@ID,132,3104.29,-3429.73,137.697,0,0,0,0,100,0),
(@ID,133,3079.44,-3458.29,135.39,0,0,0,0,100,0),
(@ID,134,3062.03,-3484.05,132.59,0,0,0,0,100,0),
(@ID,135,3051.15,-3508.73,131.122,0,0,0,0,100,0),
(@ID,136,3044.5,-3543.07,128.53,0,0,0,0,100,0),
(@ID,137,3040.58,-3585.59,124.369,0,0,0,0,100,0),
(@ID,138,3040.05,-3618.85,124.055,0,0,0,0,100,0),
(@ID,139,3041.87,-3636.23,125.378,0,0,0,0,100,0),
(@ID,140,3048.01,-3656.25,122.83,0,0,0,0,100,0),
(@ID,141,3059.89,-3685.41,121.254,0,0,0,0,100,0),
(@ID,142,3063.62,-3704.59,120.885,0,0,0,0,100,0),
(@ID,143,3049.97,-3743.53,120.437,0,0,0,0,100,0),
(@ID,144,3038.77,-3773.26,119.728,0,0,0,0,100,0),
(@ID,145,3029.37,-3797.56,120.123,0,0,0,0,100,0),
(@ID,146,3017.78,-3822.93,118.882,0,0,0,0,100,0),
(@ID,147,3011.9,-3841.29,119.307,0,0,0,0,100,0),
(@ID,148,2999.1,-3881.4,118.595,0,0,0,0,100,0),
(@ID,149,2992.82,-3899.77,116.742,0,0,0,0,100,0),
(@ID,150,2987.35,-3919.01,114.686,0,0,0,0,100,0),
(@ID,151,2979.54,-3951.23,108.575,0,0,0,0,100,0),
(@ID,152,2974.35,-3965.01,106.582,0,0,0,0,100,0),
(@ID,153,2965.39,-3989.01,103.564,0,0,0,0,100,0),
(@ID,154,2947.58,-4032.49,99.8551,0,0,0,0,100,0),
(@ID,155,2940.68,-4050.84,98.8149,0,0,0,0,100,0),
(@ID,156,2927.47,-4095.16,96.9418,0,0,0,0,100,0),
(@ID,157,2922.28,-4117.41,96.1034,0,0,0,0,100,0),
(@ID,158,2916.91,-4141.33,95.1063,0,0,0,0,100,0),
(@ID,159,2912.33,-4161.43,94.1942,0,0,0,0,100,0),
(@ID,160,2906.67,-4194.05,92.8009,0,0,0,0,100,0),
(@ID,161,2902.22,-4224.72,91.8676,0,0,0,0,100,0),
(@ID,162,2898.62,-4254.12,91.3725,0,0,0,0,100,0),
(@ID,163,2896.84,-4270.08,91.1643,0,0,0,0,100,0),
(@ID,164,2892.88,-4300.96,90.6728,0,0,0,0,100,0),
(@ID,165,2882.86,-4347.85,90.3236,0,0,0,0,100,0),
(@ID,166,2875.88,-4369.2,90.0259,0,0,0,0,100,0),
(@ID,167,2866.06,-4388.72,89.6369,0,0,0,0,100,0),
(@ID,168,2855.15,-4407.04,89.3003,0,0,0,0,100,0),
(@ID,169,2844.51,-4424.87,89.4741,0,0,0,0,100,0),
(@ID,170,2835.01,-4439.19,89.6752,0,0,0,0,100,0),
(@ID,171,2825.9,-4452.37,89.8312,0,0,0,0,100,0),
(@ID,172,2781.37,-4503.54,89.6992,0,0,0,0,100,0),
(@ID,173,2768.3,-4516.57,89.4068,0,0,0,0,100,0),
(@ID,174,2751.64,-4531.98,88.9045,0,0,0,0,100,0),
(@ID,175,2738.52,-4542.49,88.4996,0,0,0,0,100,0),
(@ID,176,2714.09,-4557.62,87.6424,0,0,0,0,100,0),
(@ID,177,2699.67,-4566.29,87.4294,0,0,0,0,100,0),
(@ID,178,2684.52,-4575.58,87.001,0,0,0,0,100,0),
(@ID,179,2667.22,-4586.17,85.7211,0,0,0,0,100,0),
(@ID,180,2630.76,-4606.45,84.5909,0,0,0,0,100,0),
(@ID,181,2618.07,-4614.37,84.1965,0,0,0,0,100,0),
(@ID,182,2592.51,-4629.78,81.6831,0,0,0,0,100,0),
(@ID,183,2570.53,-4643.56,79.6884,0,0,0,0,100,0),
(@ID,184,2558.75,-4648.16,78.7332,0,0,0,0,100,0),
(@ID,185,2544.22,-4651.95,77.8191,0,0,0,0,100,0),
(@ID,186,2528.11,-4654.63,76.8986,0,0,0,0,100,0),
(@ID,187,2511.76,-4655.66,76.0362,0,0,0,0,100,0),
(@ID,188,2487.63,-4647.41,75.1608,0,0,0,0,100,0),
(@ID,189,2467.38,-4636.04,74.6576,0,0,0,0,100,0),
(@ID,190,2453.17,-4627.91,73.6226,0,0,0,0,100,0),
(@ID,191,2437.83,-4620.44,73.6179,0,0,0,0,100,0),
(@ID,192,2425.09,-4614.63,73.613,0,0,0,0,100,0),
(@ID,193,2401.34,-4604.92,73.6229,0,0,0,0,100,0),
(@ID,194,2367.28,-4602.14,73.6229,0,0,0,0,100,0),
(@ID,195,2348.43,-4603.85,73.6229,0,0,0,0,100,0),
(@ID,196,2312.07,-4610.25,73.6226,0,0,0,0,100,0),
(@ID,197,2289.67,-4616.1,73.6237,0,0,0,0,100,0),
(@ID,198,2270.18,-4621.81,73.6232,0,0,0,0,100,0),
(@ID,199,2237.91,-4633.07,73.623,0,0,0,0,100,0),
(@ID,200,2211.17,-4636.19,73.623,0,0,0,0,100,0),
(@ID,201,2185.27,-4631.85,73.6238,0,0,0,0,100,0),
(@ID,202,2161.67,-4621.89,73.6227,0,0,0,0,100,0),
(@ID,203,2149.52,-4615.7,73.6227,0,0,0,0,100,0),
(@ID,204,2128.18,-4600.53,73.6227,0,0,0,0,100,0),
(@ID,205,2110.23,-4586.01,73.6227,0,0,0,0,100,0),
(@ID,206,2094.4,-4570.16,73.6232,0,0,0,0,100,0),
(@ID,207,2059.78,-4531.27,73.6232,0,0,0,0,100,0),
(@ID,208,2025.92,-4515.28,73.6218,0,0,0,0,100,0),
(@ID,209,1981.81,-4549.69,73.6228,0,0,0,0,100,0),
(@ID,210,1968.69,-4574.04,73.6228,0,0,0,0,100,0),
(@ID,211,1957.36,-4608.7,74.4979,0,0,0,0,100,0),
(@ID,212,1948.95,-4627.72,78.4405,0,0,0,0,100,0),
(@ID,213,1940.18,-4642.16,82.8813,0,0,0,0,100,0),
(@ID,214,1932.32,-4651.64,85.6817,0,0,0,0,100,0),
(@ID,215,1923.41,-4662.78,88.4994,0,0,0,0,100,0),
(@ID,216,1912.89,-4671.55,90.7472,0,0,0,0,100,0),
(@ID,217,1904.98,-4676.2,91.9429,0,0,0,0,100,0),
(@ID,218,1880.51,-4687.26,92.3027,0,0,0,0,100,0),
(@ID,219,1854.01,-4707.87,93.1035,0,0,0,0,100,0),
(@ID,220,1840.53,-4719.99,92.1716,0,0,0,0,100,0),
(@ID,221,1833.29,-4732.42,90.4734,0,0,0,0,100,0),
(@ID,222,1825.75,-4748.92,88.8841,0,0,0,0,100,0),
(@ID,223,1822.27,-4758.66,89.1826,0,0,0,0,100,0),
(@ID,224,1817.98,-4771.4,89.7992,0,0,0,0,100,0),
(@ID,225,1813.98,-4783.45,90.3784,0,0,0,0,100,0),
(@ID,226,1810.56,-4794.25,91.0151,0,0,0,0,100,0),
(@ID,227,1805.81,-4811.34,90.581,0,0,0,0,100,0),
(@ID,228,1801.15,-4827.95,90.0279,0,0,0,0,100,0),
(@ID,229,1791.34,-4861.33,88.9552,0,0,0,0,100,0),
(@ID,230,1787.86,-4875.91,87.5166,0,0,0,0,100,0),
(@ID,231,1780.76,-4905.48,84.0821,0,0,0,0,100,0),
(@ID,232,1776.19,-4928.71,81.4626,0,0,0,0,100,0),
(@ID,233,1774.3,-4938.49,81.4626,0,0,0,0,100,0),
(@ID,234,1771.16,-4965.22,81.2126,0,0,0,0,100,0),
(@ID,235,1757.6,-4990.9,80.8461,0,0,0,0,100,0),
(@ID,236,1748.01,-5004.46,79.9039,0,0,0,0,100,0),
(@ID,237,1738.94,-5016.73,79.9039,0,0,0,0,100,0),
(@ID,238,1730.81,-5028.28,80.3151,0,0,0,0,100,0),
(@ID,239,1720.51,-5053.17,80.4197,0,0,0,0,100,0),
(@ID,240,1713.61,-5072.05,78.6081,0,0,0,0,100,0),
(@ID,241,1704.71,-5094.96,75.245,0,0,0,0,100,0),
(@ID,242,1692.75,-5131.78,73.8809,0,0,0,0,100,0),
(@ID,243,1689.73,-5148.36,74.0206,0,0,0,0,100,0),
(@ID,244,1688.35,-5178.24,73.7731,0,0,0,0,100,0),
(@ID,245,1692.81,-5201.48,74.6409,0,0,0,0,100,0),
(@ID,246,1690.74,-5274.98,73.6232,0,0,0,0,100,0),
(@ID,247,1687.05,-5306.95,73.6112,0,0,0,0,100,0),
(@ID,248,1686.21,-5322.85,73.6114,0,0,0,0,100,0),
(@ID,249,1688.3,-5343.87,74.2449,0,0,0,0,100,0),
(@ID,250,1672.16,-5377.38,73.6118,0,0,0,0,100,0),
(@ID,251,1667.54,-5388.89,73.6137,0,0,0,0,100,0),
(@ID,252,1664.18,-5398.35,74.3809,0,0,0,0,100,0),
(@ID,253,1659.56,-5411.51,78.0987,0,0,0,0,100,0),
(@ID,254,1657.63,-5416.96,80.0233,0,0,0,0,100,0),
(@ID,255,1654.7,-5425.03,82.2941,0,0,0,0,100,0),
(@ID,256,1652.04,-5432.05,84.9364,0,0,0,0,100,0),
(@ID,257,1649.05,-5439.55,87.5085,0,0,0,0,100,0),
(@ID,258,1646.61,-5446.01,90.2014,0,0,0,0,100,0),
(@ID,259,1644.44,-5452.14,93.1195,0,0,0,0,100,0),
(@ID,260,1641.84,-5459.95,95.4057,0,0,0,0,100,0),
(@ID,261,1639.43,-5466.45,97.7334,0,0,0,0,100,0),
(@ID,262,1635.2,-5476.15,100.195,0,0,0,0,100,0),
(@ID,263,1631.56,-5485.27,100.73,0,0,0,0,100,0),
(@ID,264,1627.96,-5493.81,100.73,0,0,0,0,100,0),
(@ID,265,1623.74,-5501.82,102.308,0,0,0,0,100,0),
(@ID,266,1621.54,-5506.67,104.154,0,0,0,0,100,0),
(@ID,267,1619.31,-5510.5,105.706,0,0,0,0,100,0),
(@ID,268,1617.2,-5514.39,107.478,0,0,0,0,100,0),
(@ID,269,1615.11,-5518.38,108.951,0,0,0,0,100,0),
(@ID,270,1613.27,-5521.97,110.422,0,0,0,0,100,0),
(@ID,271,1610.31,-5527.82,111.163,0,0,0,0,100,0),
(@ID,272,1606.59,-5535.3,111.171,0,0,0,0,100,0),
(@ID,273,1596.95,-5537.16,111.171,0,0,0,0,100,0),
(@ID,274,1591.5,-5546.99,111.171,0,0,0,0,100,0),
(@ID,275,1594.64,-5559.12,111.171,0,0,0,0,100,0),
(@ID,276,1587.05,-5573.4,111.171,0,0,0,0,100,0),
(@ID,277,1576.47,-5592.38,111.171,0,0,0,0,100,0),
(@ID,278,1569.09,-5606.81,114.19,0,0,0,0,100,0);

UPDATE `script_texts` SET `sound`=5802 WHERE `npc_entry`=4832 AND `entry`='-1048002';
 
 
/* 
* updates\world\2012_09_18_00_world_creature_template.sql 
*/ 
UPDATE `creature_template` SET `unit_flags2`=0 WHERE `entry`=33109; -- Salvaged Demolisher
UPDATE `creature_template` SET `unit_flags2`=2049 WHERE `entry`=33063; -- Wrecked Siege Engine
UPDATE `creature_template` SET `unit_flags2`=1 WHERE `entry`=33059; -- Wrecked Demolisher
UPDATE `creature_template` SET `unit_flags2`=0 WHERE `entry`=33167; -- Salvaged Demolisher Mechanic Seat
 
 
/* 
* updates\world\2012_09_18_01_world_creature_template.sql 
*/ 
-- Razorscale
UPDATE `creature_template` SET `InhabitType`=4 WHERE `entry` IN (33186,33724);

DELETE FROM `creature_template_addon` WHERE `entry` IN (33186,33724);
INSERT INTO `creature_template_addon` (`entry`, `mount`, `bytes1`, `bytes2`, `auras`) VALUES
(33186, 0, 0x3000000, 0x1, ''),
(33724, 0, 0x3000000, 0x1, '');
 
 
/* 
* updates\world\2012_09_19_00_world_dwarfageddon.sql 
*/ 
-- Edit the required spell credit markers for Dwarfageddon (10/25 player) achievements
UPDATE `spell_dbc` SET `attributes`=0x00800100,`DmgMultiplier1`=0, `DmgMultiplier2`=0, `DmgMultiplier3`=0,`RangeIndex`=12 WHERE `ID`=65387; -- (SPELL_ATTR0_HIDE_IN_COMBAT_LOG, SPELL_ATTR0_CASTABLE_WHILE_DEAD)
-- Edit SAI support for Dwarfageddon (10 and 25 player) achievement /required changes since attribute castable_while_dead is not working/
SET @Defender := 33236;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@Defender AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@Defender,0,0,0,25,0,100,0,0,0,0,0,42,0,1,0,0,0,0,1,0,0,0,0,0,0,0,'Steelforged Defender - On reset - Set Invincibility for 1%'),
(@Defender,0,1,2,2,0,100,0,1,1,0,0,11,65387,0,0,0,0,0,1,0,0,0,0,0,0,0,'Steelforged Defender - Health Percentage (1%) - Cast spell for achievement credit'),
(@Defender,0,2,0,61,0,100,0,0,0,0,0,37,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Steelforged Defender - Linked with previous event - Die'),
(@Defender,0,3,0,0,0,100,0,0,2500,9000,12000,11,62845,0,0,0,0,0,2,0,0,0,0,0,0,0,'Steelforged Defender - IC - Hamstring'),
(@Defender,0,4,0,0,0,100,0,0,2600,13000,14000,11,50370,0,0,0,0,0,2,0,0,0,0,0,0,0,'Steelforged Defender - IC - Cast Sunder armor'),
(@Defender,0,5,0,0,0,100,0,500,4000,4500,9000,11,57780,0,0,0,0,0,2,0,0,0,0,0,0,0,'Steelforged Defender - IC - Cast Lightening Bolt');
-- Add conditions to prevent lag and for the sake of logic
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (65387);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1,65387,0,1,31,0,4,0,0,0,0,'','Steelforged Defender kill credit for achievement can hit only players');
 
 
/* 
* updates\world\2012_09_19_00_world_reference_loot_template.sql 
*/ 
-- Changes To VOA Loot
-- Update gold drops for bosses
-- Archavon 10 & 25
UPDATE `creature_template` SET `mingold`=1700000,`maxgold`=1800000 WHERE `entry` IN (31125,31722);
-- Emalon & koralon 10 & 25
UPDATE `creature_template` SET `mingold`=1800000,`maxgold`=1900000 WHERE `entry` IN (33993,33994,35013,35360);
-- Toravon 10 & 25
UPDATE `creature_template` SET `mingold`=1900000,`maxgold`=2000000 WHERE `entry` IN (38433,38462);
-- Combine PVP and PVE ref templates so loot has chance to be all pvp or all pve not one of each
-- Revome deadly items other than chest lega and hands from Archavon 25 loot
-- Toravon 25 drops 3 items
SET @ARCHAVON10 = 34209;
SET @ARCHAVON25 = 34216;
SET @EMALON10 = 34208;
SET @EMALON25 = 34215;
SET @TORAVON10 = 34206;
SET @TORAVON25 = 34207;
SET @KORALON10 = 34204;
SET @KORALON25 = 34205;
-- Create Reference loot template for @ARCHAVON25 T7(25) & Deadly Chest,Legs,Hands
DELETE FROM `reference_loot_template` WHERE `entry` IN (@ARCHAVON25,@KORALON25,@EMALON25);
INSERT INTO `reference_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(@ARCHAVON25,40550,0,1,1,1,1), -- Valorous Scourgeborne Battleplate
(@ARCHAVON25,40552,0,1,1,1,1), -- Valorous Scourgeborne Gauntlets
(@ARCHAVON25,40556,0,1,1,1,1), -- Valorous Scourgeborne Legplates
(@ARCHAVON25,40559,0,1,1,1,1), -- Valorous Scourgeborne Chestguard
(@ARCHAVON25,40563,0,1,1,1,1), -- Valorous Scourgeborne Handguards
(@ARCHAVON25,40567,0,1,1,1,1), -- Valorous Scourgeborne Legguards
(@ARCHAVON25,40463,0,1,1,1,1), -- Valorous Dreamwalker Robe
(@ARCHAVON25,40460,0,1,1,1,1), -- Valorous Dreamwalker Handguards
(@ARCHAVON25,40462,0,1,1,1,1), -- Valorous Dreamwalker Leggings
(@ARCHAVON25,40503,0,1,1,1,1), -- Valorous Cryptstalker Tunic
(@ARCHAVON25,40504,0,1,1,1,1), -- Valorous Cryptstalker Handguards
(@ARCHAVON25,40506,0,1,1,1,1), -- Valorous Cryptstalker Legguards
(@ARCHAVON25,40418,0,1,1,1,1), -- Valorous Frostfire Robe
(@ARCHAVON25,40415,0,1,1,1,1), -- Valorous Frostfire Gloves
(@ARCHAVON25,40417,0,1,1,1,1), -- Valorous Frostfire Leggings
(@ARCHAVON25,40569,0,1,1,1,1), -- Valorous Redemption Tunic
(@ARCHAVON25,40570,0,1,1,1,1), -- Valorous Redemption Gloves
(@ARCHAVON25,40572,0,1,1,1,1), -- Valorous Redemption Greaves
(@ARCHAVON25,40579,0,1,1,1,1), -- Valorous Redemption Breastplate
(@ARCHAVON25,40580,0,1,1,1,1), -- Valorous Redemption Handguards
(@ARCHAVON25,40583,0,1,1,1,1), -- Valorous Redemption Legguards
(@ARCHAVON25,40574,0,1,1,1,1), -- Valorous Redemption Chestpiece
(@ARCHAVON25,40575,0,1,1,1,1), -- Valorous Redemption Gauntlets
(@ARCHAVON25,40577,0,1,1,1,1), -- Valorous Redemption Legplates
(@ARCHAVON25,40449,0,1,1,1,1), -- Valorous Robe of Faith
(@ARCHAVON25,40445,0,1,1,1,1), -- Valorous Gloves of Faith
(@ARCHAVON25,40448,0,1,1,1,1), -- Valorous Leggings of Faith
(@ARCHAVON25,40458,0,1,1,1,1), -- Valorous Raiments of Faith
(@ARCHAVON25,40454,0,1,1,1,1), -- Valorous Handwraps of Faith
(@ARCHAVON25,40457,0,1,1,1,1), -- Valorous Pants of Faith
(@ARCHAVON25,40495,0,1,1,1,1), -- Valorous Bonescythe Breastplate
(@ARCHAVON25,40496,0,1,1,1,1), -- Valorous Bonescythe Gauntlets
(@ARCHAVON25,40500,0,1,1,1,1), -- Valorous Bonescythe Legplates
(@ARCHAVON25,40514,0,1,1,1,1), -- Valorous Earthshatter Hauberk
(@ARCHAVON25,40515,0,1,1,1,1), -- Valorous Earthshatter Gloves
(@ARCHAVON25,40517,0,1,1,1,1), -- Valorous Earthshatter Kilt
(@ARCHAVON25,40523,0,1,1,1,1), -- Valorous Earthshatter Chestguard
(@ARCHAVON25,40520,0,1,1,1,1), -- Valorous Earthshatter Grips
(@ARCHAVON25,40522,0,1,1,1,1), -- Valorous Earthshatter War-Kilt
(@ARCHAVON25,40508,0,1,1,1,1), -- Valorous Earthshatter Tunic
(@ARCHAVON25,40509,0,1,1,1,1), -- Valorous Earthshatter Handguards
(@ARCHAVON25,40512,0,1,1,1,1), -- Valorous Earthshatter Legguards
(@ARCHAVON25,40423,0,1,1,1,1), -- Valorous Plagueheart Robe
(@ARCHAVON25,40420,0,1,1,1,1), -- Valorous Plagueheart Gloves
(@ARCHAVON25,40422,0,1,1,1,1), -- Valorous Plagueheart Leggings
(@ARCHAVON25,40525,0,1,1,1,1), -- Valorous Dreadnaught Battleplate
(@ARCHAVON25,40527,0,1,1,1,1), -- Valorous Dreadnaught Gauntlets
(@ARCHAVON25,40529,0,1,1,1,1), -- Valorous Dreadnaught Legplates
(@ARCHAVON25,40544,0,1,1,1,1), -- Valorous Dreadnaught Breastplate
(@ARCHAVON25,40545,0,1,1,1,1), -- Valorous Dreadnaught Handguards
(@ARCHAVON25,40547,0,1,1,1,1), -- Valorous Dreadnaught Legguards
(@ARCHAVON25,40469,0,1,1,1,1), -- Valorous Dreamwalker Vestments
(@ARCHAVON25,40466,0,1,1,1,1), -- Valorous Dreamwalker Gloves
(@ARCHAVON25,40468,0,1,1,1,1), -- Valorous Dreamwalker Trousers
(@ARCHAVON25,40471,0,1,1,1,1), -- Valorous Dreamwalker Raiments
(@ARCHAVON25,40472,0,1,1,1,1), -- Valorous Dreamwalker Handgrips
(@ARCHAVON25,40493,0,1,1,1,1), -- Valorous Dreamwalker Legguards
(@ARCHAVON25,40786,0,1,1,1,1), -- Deadly Gladiator's Plate Chestpiece
(@ARCHAVON25,41951,0,1,1,1,1), -- Deadly Gladiator's Silk Raiment
(@ARCHAVON25,41997,0,1,1,1,1), -- Deadly Gladiator's Felweave Raiment
(@ARCHAVON25,41649,0,1,1,1,1), -- Deadly Gladiator's Leather Tunic
(@ARCHAVON25,40784,0,1,1,1,1), -- Deadly Gladiator's Dreadplate Chestpiece
(@ARCHAVON25,41086,0,1,1,1,1), -- Deadly Gladiator's Chain Armor
(@ARCHAVON25,41920,0,1,1,1,1), -- Deadly Gladiator's Satin Robe
(@ARCHAVON25,40785,0,1,1,1,1), -- Deadly Gladiator's Scaled Chestpiece
(@ARCHAVON25,41660,0,1,1,1,1), -- Deadly Gladiator's Dragonhide Robes
(@ARCHAVON25,41858,0,1,1,1,1), -- Deadly Gladiator's Mooncloth Robe
(@ARCHAVON25,40905,0,1,1,1,1), -- Deadly Gladiator's Ornamented Chestguard
(@ARCHAVON25,40990,0,1,1,1,1), -- Deadly Gladiator's Ringmail Armor
(@ARCHAVON25,41315,0,1,1,1,1), -- Deadly Gladiator's Wyrmhide Robes
(@ARCHAVON25,41309,0,1,1,1,1), -- Deadly Gladiator's Kodohide Robes
(@ARCHAVON25,41080,0,1,1,1,1), -- Deadly Gladiator's Linked Armor
(@ARCHAVON25,40991,0,1,1,1,1), -- Deadly Gladiator's Mail Armor
(@ARCHAVON25,40926,0,1,1,1,1), -- Deadly Gladiator's Ornamented Gloves
(@ARCHAVON25,40938,0,1,1,1,1), -- Deadly Gladiator's Ornamented Legplates
(@ARCHAVON25,40846,0,1,1,1,1), -- Deadly Gladiator's Scaled Legguards
(@ARCHAVON25,41863,0,1,1,1,1), -- Deadly Gladiator's Mooncloth Leggings
(@ARCHAVON25,41926,0,1,1,1,1), -- Deadly Gladiator's Satin Leggings
(@ARCHAVON25,41873,0,1,1,1,1), -- Deadly Gladiator's Mooncloth Gloves
(@ARCHAVON25,41032,0,1,1,1,1), -- Deadly Gladiator's Mail Leggings
(@ARCHAVON25,41006,0,1,1,1,1), -- Deadly Gladiator's Mail Gauntlets
(@ARCHAVON25,41198,0,1,1,1,1), -- Deadly Gladiator's Linked Leggings
(@ARCHAVON25,41666,0,1,1,1,1), -- Deadly Gladiator's Dragonhide Legguards
(@ARCHAVON25,41772,0,1,1,1,1), -- Deadly Gladiator's Dragonhide Gloves
(@ARCHAVON25,41000,0,1,1,1,1), -- Deadly Gladiator's Ringmail Gauntlets
(@ARCHAVON25,41136,0,1,1,1,1), -- Deadly Gladiator's Linked Gauntlets
(@ARCHAVON25,41286,0,1,1,1,1), -- Deadly Gladiator's Kodohide Gloves
(@ARCHAVON25,40805,0,1,1,1,1), -- Deadly Gladiator's Scaled Gauntlets
(@ARCHAVON25,41939,0,1,1,1,1), -- Deadly Gladiator's Satin Gloves
(@ARCHAVON25,41297,0,1,1,1,1), -- Deadly Gladiator's Kodohide Legguards
(@ARCHAVON25,41026,0,1,1,1,1), -- Deadly Gladiator's Ringmail Leggings
(@ARCHAVON25,41958,0,1,1,1,1), -- Deadly Gladiator's Silk Trousers
(@ARCHAVON25,41970,0,1,1,1,1), -- Deadly Gladiator's Silk Handguards
(@ARCHAVON25,40844,0,1,1,1,1), -- Deadly Gladiator's Plate Legguards
(@ARCHAVON25,41303,0,1,1,1,1), -- Deadly Gladiator's Wyrmhide Legguards
(@ARCHAVON25,41292,0,1,1,1,1), -- Deadly Gladiator's Wyrmhide Gloves
(@ARCHAVON25,42004,0,1,1,1,1), -- Deadly Gladiator's Felweave Trousers
(@ARCHAVON25,41142,0,1,1,1,1), -- Deadly Gladiator's Chain Gauntlets
(@ARCHAVON25,40845,0,1,1,1,1), -- Deadly Gladiator's Dreadplate Legguards
(@ARCHAVON25,40804,0,1,1,1,1), -- Deadly Gladiator's Plate Gauntlets
(@ARCHAVON25,42016,0,1,1,1,1), -- Deadly Gladiator's Felweave Handguards
(@ARCHAVON25,40806,0,1,1,1,1), -- Deadly Gladiator's Dreadplate Gauntlets
(@ARCHAVON25,41654,0,1,1,1,1), -- Deadly Gladiator's Leather Legguards
(@ARCHAVON25,41766,0,1,1,1,1), -- Deadly Gladiator's Leather Gloves
(@ARCHAVON25,41204,0,1,1,1,1), -- Deadly Gladiator's Chain Leggings
-- Create Ref for Emalon 25 furious PVP + T8(25) (chest,hands,legs)
(@EMALON25,41640,0,1,1,1,1), -- Furious Gladiator's Armwraps of Dominance
(@EMALON25,41625,0,1,1,1,1), -- Furious Gladiator's Armwraps of Salvation
(@EMALON25,41840,0,1,1,1,1), -- Furious Gladiator's Armwraps of Triumph
(@EMALON25,42116,0,1,1,1,1), -- Furious Gladiator's Band of Dominance
(@EMALON25,42117,0,1,1,1,1), -- Furious Gladiator's Band of Triumph
(@EMALON25,41630,0,1,1,1,1), -- Furious Gladiator's Belt of Dominance
(@EMALON25,41617,0,1,1,1,1), -- Furious Gladiator's Belt of Salvation
(@EMALON25,41832,0,1,1,1,1), -- Furious Gladiator's Belt of Triumph
(@EMALON25,41635,0,1,1,1,1), -- Furious Gladiator's Boots of Dominance
(@EMALON25,41621,0,1,1,1,1), -- Furious Gladiator's Boots of Salvation
(@EMALON25,41836,0,1,1,1,1), -- Furious Gladiator's Boots of Triumph
(@EMALON25,40983,0,1,1,1,1), -- Furious Gladiator's Bracers of Salvation
(@EMALON25,40889,0,1,1,1,1), -- Furious Gladiator's Bracers of Triumph
(@EMALON25,41143,0,1,1,1,1), -- Furious Gladiator's Chain Gauntlets
(@EMALON25,41205,0,1,1,1,1), -- Furious Gladiator's Chain Leggings
(@EMALON25,42071,0,1,1,1,1), -- Furious Gladiator's Cloak of Ascendancy
(@EMALON25,42073,0,1,1,1,1), -- Furious Gladiator's Cloak of Deliverance
(@EMALON25,42069,0,1,1,1,1), -- Furious Gladiator's Cloak of Dominance
(@EMALON25,42072,0,1,1,1,1), -- Furious Gladiator's Cloak of Salvation
(@EMALON25,42070,0,1,1,1,1), -- Furious Gladiator's Cloak of Subjugation
(@EMALON25,42074,0,1,1,1,1), -- Furious Gladiator's Cloak of Triumph
(@EMALON25,42075,0,1,1,1,1), -- Furious Gladiator's Cloak of Victory
(@EMALON25,41898,0,1,1,1,1), -- Furious Gladiator's Cord of Dominance
(@EMALON25,41881,0,1,1,1,1), -- Furious Gladiator's Cord of Salvation
(@EMALON25,41909,0,1,1,1,1), -- Furious Gladiator's Cuffs of Dominance
(@EMALON25,41893,0,1,1,1,1), -- Furious Gladiator's Cuffs of Salvation
(@EMALON25,41773,0,1,1,1,1), -- Furious Gladiator's Dragonhide Gloves
(@EMALON25,41667,0,1,1,1,1), -- Furious Gladiator's Dragonhide Legguards
(@EMALON25,40809,0,1,1,1,1), -- Furious Gladiator's Dreadplate Gauntlets
(@EMALON25,42017,0,1,1,1,1), -- Furious Gladiator's Felweave Handguards
(@EMALON25,42005,0,1,1,1,1), -- Furious Gladiator's Felweave Trousers
(@EMALON25,40976,0,1,1,1,1), -- Furious Gladiator's Girdle of Salvation
(@EMALON25,40881,0,1,1,1,1), -- Furious Gladiator's Girdle of Triumph
(@EMALON25,40977,0,1,1,1,1), -- Furious Gladiator's Greaves of Salvation
(@EMALON25,40882,0,1,1,1,1), -- Furious Gladiator's Greaves of Triumph
(@EMALON25,41287,0,1,1,1,1), -- Furious Gladiator's Kodohide Gloves
(@EMALON25,41298,0,1,1,1,1), -- Furious Gladiator's Kodohide Legguards
(@EMALON25,41767,0,1,1,1,1), -- Furious Gladiator's Leather Gloves
(@EMALON25,41655,0,1,1,1,1), -- Furious Gladiator's Leather Legguards
(@EMALON25,41137,0,1,1,1,1), -- Furious Gladiator's Linked Gauntlets
(@EMALON25,41199,0,1,1,1,1), -- Furious Gladiator's Linked Leggings
(@EMALON25,41007,0,1,1,1,1), -- Furious Gladiator's Mail Gauntlets
(@EMALON25,41033,0,1,1,1,1), -- Furious Gladiator's Mail Leggings
(@EMALON25,41874,0,1,1,1,1), -- Furious Gladiator's Mooncloth Gloves
(@EMALON25,41864,0,1,1,1,1), -- Furious Gladiator's Mooncloth Leggings
(@EMALON25,40927,0,1,1,1,1), -- Furious Gladiator's Ornamented Gloves
(@EMALON25,40939,0,1,1,1,1), -- Furious Gladiator's Ornamented Legplates
(@EMALON25,42037,0,1,1,1,1), -- Furious Gladiator's Pendant of Ascendancy
(@EMALON25,42039,0,1,1,1,1), -- Furious Gladiator's Pendant of Deliverance
(@EMALON25,42036,0,1,1,1,1), -- Furious Gladiator's Pendant of Dominance
(@EMALON25,42040,0,1,1,1,1), -- Furious Gladiator's Pendant of Salvation
(@EMALON25,42038,0,1,1,1,1), -- Furious Gladiator's Pendant of Subjugation
(@EMALON25,46373,0,1,1,1,1), -- Furious Gladiator's Pendant of Sundering
(@EMALON25,42034,0,1,1,1,1), -- Furious Gladiator's Pendant of Triumph
(@EMALON25,42035,0,1,1,1,1), -- Furious Gladiator's Pendant of Victory
(@EMALON25,40807,0,1,1,1,1), -- Furious Gladiator's Plate Gauntlets
(@EMALON25,40847,0,1,1,1,1), -- Furious Gladiator's Plate Legguards
(@EMALON25,41001,0,1,1,1,1), -- Furious Gladiator's Ringmail Gauntlets
(@EMALON25,41027,0,1,1,1,1), -- Furious Gladiator's Ringmail Leggings
(@EMALON25,41075,0,1,1,1,1), -- Furious Gladiator's Sabatons of Dominance
(@EMALON25,41055,0,1,1,1,1), -- Furious Gladiator's Sabatons of Salvation
(@EMALON25,41230,0,1,1,1,1), -- Furious Gladiator's Sabatons of Triumph
(@EMALON25,41940,0,1,1,1,1), -- Furious Gladiator's Satin Gloves
(@EMALON25,41927,0,1,1,1,1), -- Furious Gladiator's Satin Leggings
(@EMALON25,40808,0,1,1,1,1), -- Furious Gladiator's Scaled Gauntlets
(@EMALON25,40849,0,1,1,1,1), -- Furious Gladiator's Scaled Legguards
(@EMALON25,41971,0,1,1,1,1), -- Furious Gladiator's Silk Handguards
(@EMALON25,41959,0,1,1,1,1), -- Furious Gladiator's Silk Trousers
(@EMALON25,41903,0,1,1,1,1), -- Furious Gladiator's Slippers of Dominance
(@EMALON25,41885,0,1,1,1,1), -- Furious Gladiator's Slippers of Salvation
(@EMALON25,41070,0,1,1,1,1), -- Furious Gladiator's Waistguard of Dominance
(@EMALON25,41051,0,1,1,1,1), -- Furious Gladiator's Waistguard of Salvation
(@EMALON25,41235,0,1,1,1,1), -- Furious Gladiator's Waistguard of Triumph
(@EMALON25,41065,0,1,1,1,1), -- Furious Gladiator's Wristguards of Dominance
(@EMALON25,41060,0,1,1,1,1), -- Furious Gladiator's Wristguards of Salvation
(@EMALON25,41225,0,1,1,1,1), -- Furious Gladiator's Wristguards of Triumph
(@EMALON25,41293,0,1,1,1,1), -- Furious Gladiator's Wyrmhide Gloves
(@EMALON25,41304,0,1,1,1,1), -- Furious Gladiator's Wyrmhide Legguards
(@EMALON25,40811,0,1,1,1,1), -- Furious Gladiator's Girdle of Triumph
(@EMALON25,46155,0,1,1,1,1), -- Conqueror's Aegis Gauntlets
(@EMALON25,46179,0,1,1,1,1), -- Conqueror's Aegis Gloves
(@EMALON25,46181,0,1,1,1,1), -- Conqueror's Aegis Greaves
(@EMALON25,46174,0,1,1,1,1), -- Conqueror's Aegis Handguards
(@EMALON25,46176,0,1,1,1,1), -- Conqueror's Aegis Legguards
(@EMALON25,46153,0,1,1,1,1), -- Conqueror's Aegis Legplates
(@EMALON25,46113,0,1,1,1,1), -- Conqueror's Darkruned Gauntlets
(@EMALON25,46119,0,1,1,1,1), -- Conqueror's Darkruned Handguards
(@EMALON25,46121,0,1,1,1,1), -- Conqueror's Darkruned Legguards
(@EMALON25,46116,0,1,1,1,1), -- Conqueror's Darkruned Legplates
(@EMALON25,46135,0,1,1,1,1), -- Conqueror's Deathbringer Gloves
(@EMALON25,46139,0,1,1,1,1), -- Conqueror's Deathbringer Leggings
(@EMALON25,46188,0,1,1,1,1), -- Conqueror's Gloves of Sanctification
(@EMALON25,46163,0,1,1,1,1), -- Conqueror's Handwraps of Sanctification
(@EMALON25,46132,0,1,1,1,1), -- Conqueror's Kirin Tor Gauntlets
(@EMALON25,46133,0,1,1,1,1), -- Conqueror's Kirin Tor Leggings
(@EMALON25,46195,0,1,1,1,1), -- Conqueror's Leggings of Sanctification
(@EMALON25,46189,0,1,1,1,1), -- Conqueror's Nightsong Gloves
(@EMALON25,46158,0,1,1,1,1), -- Conqueror's Nightsong Handgrips
(@EMALON25,46183,0,1,1,1,1), -- Conqueror's Nightsong Handguards
(@EMALON25,46185,0,1,1,1,1), -- Conqueror's Nightsong Leggings
(@EMALON25,46160,0,1,1,1,1), -- Conqueror's Nightsong Legguards
(@EMALON25,46192,0,1,1,1,1), -- Conqueror's Nightsong Trousers
(@EMALON25,46170,0,1,1,1,1), -- Conqueror's Pants of Sanctification
(@EMALON25,46142,0,1,1,1,1), -- Conqueror's Scourgestalker Handguards
(@EMALON25,46144,0,1,1,1,1), -- Conqueror's Scourgestalker Legguards
(@EMALON25,46148,0,1,1,1,1), -- Conqueror's Siegebreaker Gauntlets
(@EMALON25,46164,0,1,1,1,1), -- Conqueror's Siegebreaker Handguards
(@EMALON25,46169,0,1,1,1,1), -- Conqueror's Siegebreaker Legguards
(@EMALON25,46150,0,1,1,1,1), -- Conqueror's Siegebreaker Legplates
(@EMALON25,46124,0,1,1,1,1), -- Conqueror's Terrorblade Gauntlets
(@EMALON25,46126,0,1,1,1,1), -- Conqueror's Terrorblade Legplates
(@EMALON25,46207,0,1,1,1,1), -- Conqueror's Worldbreaker Gloves
(@EMALON25,46200,0,1,1,1,1), -- Conqueror's Worldbreaker Grips
(@EMALON25,46199,0,1,1,1,1), -- Conqueror's Worldbreaker Handguards
(@EMALON25,46210,0,1,1,1,1), -- Conqueror's Worldbreaker Kilt
(@EMALON25,46202,0,1,1,1,1), -- Conqueror's Worldbreaker Legguards
(@EMALON25,46208,0,1,1,1,1), -- Conqueror's Worldbreaker War-Kilt
-- Create Ref for koralon 25 relentless + T9.5 (hands,legs)
(@KORALON25,41641,0,1,1,1,1), -- Relentless Gladiator's Armwraps of Dominance
(@KORALON25,41626,0,1,1,1,1), -- Relentless Gladiator's Armwraps of Salvation
(@KORALON25,41841,0,1,1,1,1), -- Relentless Gladiator's Armwraps of Triumph
(@KORALON25,42118,0,1,1,1,1), -- Relentless Gladiator's Band of Ascendancy
(@KORALON25,42119,0,1,1,1,1), -- Relentless Gladiator's Band of Victory
(@KORALON25,41631,0,1,1,1,1), -- Relentless Gladiator's Belt of Dominance
(@KORALON25,41618,0,1,1,1,1), -- Relentless Gladiator's Belt of Salvation
(@KORALON25,41833,0,1,1,1,1), -- Relentless Gladiator's Belt of Triumph
(@KORALON25,41636,0,1,1,1,1), -- Relentless Gladiator's Boots of Dominance
(@KORALON25,41622,0,1,1,1,1), -- Relentless Gladiator's Boots of Salvation
(@KORALON25,41837,0,1,1,1,1), -- Relentless Gladiator's Boots of Triumph
(@KORALON25,40984,0,1,1,1,1), -- Relentless Gladiator's Bracers of Salvation
(@KORALON25,40890,0,1,1,1,1), -- Relentless Gladiator's Bracers of Triumph
(@KORALON25,41144,0,1,1,1,1), -- Relentless Gladiator's Chain Gauntlets
(@KORALON25,41206,0,1,1,1,1), -- Relentless Gladiator's Chain Leggings
(@KORALON25,42078,0,1,1,1,1), -- Relentless Gladiator's Cloak of Ascendancy
(@KORALON25,42080,0,1,1,1,1), -- Relentless Gladiator's Cloak of Deliverance
(@KORALON25,42076,0,1,1,1,1), -- Relentless Gladiator's Cloak of Dominance
(@KORALON25,42079,0,1,1,1,1), -- Relentless Gladiator's Cloak of Salvation
(@KORALON25,42077,0,1,1,1,1), -- Relentless Gladiator's Cloak of Subjugation
(@KORALON25,42081,0,1,1,1,1), -- Relentless Gladiator's Cloak of Triumph
(@KORALON25,42082,0,1,1,1,1), -- Relentless Gladiator's Cloak of Victory
(@KORALON25,41899,0,1,1,1,1), -- Relentless Gladiator's Cord of Dominance
(@KORALON25,41882,0,1,1,1,1), -- Relentless Gladiator's Cord of Salvation
(@KORALON25,41910,0,1,1,1,1), -- Relentless Gladiator's Cuffs of Dominance
(@KORALON25,41894,0,1,1,1,1), -- Relentless Gladiator's Cuffs of Salvation
(@KORALON25,41774,0,1,1,1,1), -- Relentless Gladiator's Dragonhide Gloves
(@KORALON25,41668,0,1,1,1,1), -- Relentless Gladiator's Dragonhide Legguards
(@KORALON25,40851,0,1,1,1,1), -- Relentless Gladiator's Dreadplate Legguards
(@KORALON25,42018,0,1,1,1,1), -- Relentless Gladiator's Felweave Handguards
(@KORALON25,42006,0,1,1,1,1), -- Relentless Gladiator's Felweave Trousers
(@KORALON25,40978,0,1,1,1,1), -- Relentless Gladiator's Girdle of Salvation
(@KORALON25,40883,0,1,1,1,1), -- Relentless Gladiator's Girdle of Triumph
(@KORALON25,40979,0,1,1,1,1), -- Relentless Gladiator's Greaves of Salvation
(@KORALON25,40884,0,1,1,1,1), -- Relentless Gladiator's Greaves of Triumph
(@KORALON25,41288,0,1,1,1,1), -- Relentless Gladiator's Kodohide Gloves
(@KORALON25,41299,0,1,1,1,1), -- Relentless Gladiator's Kodohide Legguards
(@KORALON25,41768,0,1,1,1,1), -- Relentless Gladiator's Leather Gloves
(@KORALON25,41656,0,1,1,1,1), -- Relentless Gladiator's Leather Legguards
(@KORALON25,41138,0,1,1,1,1), -- Relentless Gladiator's Linked Gauntlets
(@KORALON25,41200,0,1,1,1,1), -- Relentless Gladiator's Linked Leggings
(@KORALON25,41008,0,1,1,1,1), -- Relentless Gladiator's Mail Gauntlets
(@KORALON25,41034,0,1,1,1,1), -- Relentless Gladiator's Mail Leggings
(@KORALON25,41875,0,1,1,1,1), -- Relentless Gladiator's Mooncloth Gloves
(@KORALON25,41865,0,1,1,1,1), -- Relentless Gladiator's Mooncloth Leggings
(@KORALON25,40928,0,1,1,1,1), -- Relentless Gladiator's Ornamented Gloves
(@KORALON25,40940,0,1,1,1,1), -- Relentless Gladiator's Ornamented Legplates
(@KORALON25,42044,0,1,1,1,1), -- Relentless Gladiator's Pendant of Ascendancy
(@KORALON25,42046,0,1,1,1,1), -- Relentless Gladiator's Pendant of Deliverance
(@KORALON25,42043,0,1,1,1,1), -- Relentless Gladiator's Pendant of Dominance
(@KORALON25,42047,0,1,1,1,1), -- Relentless Gladiator's Pendant of Salvation
(@KORALON25,42045,0,1,1,1,1), -- Relentless Gladiator's Pendant of Subjugation
(@KORALON25,46374,0,1,1,1,1), -- Relentless Gladiator's Pendant of Sundering
(@KORALON25,42041,0,1,1,1,1), -- Relentless Gladiator's Pendant of Triumph
(@KORALON25,42042,0,1,1,1,1), -- Relentless Gladiator's Pendant of Victory
(@KORALON25,40810,0,1,1,1,1), -- Relentless Gladiator's Plate Gauntlets
(@KORALON25,40850,0,1,1,1,1), -- Relentless Gladiator's Plate Legguards
(@KORALON25,41002,0,1,1,1,1), -- Relentless Gladiator's Ringmail Gauntlets
(@KORALON25,41028,0,1,1,1,1), -- Relentless Gladiator's Ringmail Leggings
(@KORALON25,41076,0,1,1,1,1), -- Relentless Gladiator's Sabatons of Dominance
(@KORALON25,41056,0,1,1,1,1), -- Relentless Gladiator's Sabatons of Salvation
(@KORALON25,41231,0,1,1,1,1), -- Relentless Gladiator's Sabatons of Triumph
(@KORALON25,41941,0,1,1,1,1), -- Relentless Gladiator's Satin Gloves
(@KORALON25,41928,0,1,1,1,1), -- Relentless Gladiator's Satin Leggings
(@KORALON25,40812,0,1,1,1,1), -- Relentless Gladiator's Scaled Gauntlets
(@KORALON25,40852,0,1,1,1,1), -- Relentless Gladiator's Scaled Legguards
(@KORALON25,41972,0,1,1,1,1), -- Relentless Gladiator's Silk Handguards
(@KORALON25,41960,0,1,1,1,1), -- Relentless Gladiator's Silk Trousers
(@KORALON25,41904,0,1,1,1,1), -- Relentless Gladiator's Treads of Dominance
(@KORALON25,41886,0,1,1,1,1), -- Relentless Gladiator's Treads of Salvation
(@KORALON25,41071,0,1,1,1,1), -- Relentless Gladiator's Waistguard of Dominance
(@KORALON25,41052,0,1,1,1,1), -- Relentless Gladiator's Waistguard of Salvation
(@KORALON25,41236,0,1,1,1,1), -- Relentless Gladiator's Waistguard of Triumph
(@KORALON25,41066,0,1,1,1,1), -- Relentless Gladiator's Wristguards of Dominance
(@KORALON25,41061,0,1,1,1,1), -- Relentless Gladiator's Wristguards of Salvation
(@KORALON25,41226,0,1,1,1,1), -- Relentless Gladiator's Wristguards of Triumph
(@KORALON25,41294,0,1,1,1,1), -- Relentless Gladiator's Wyrmhide Gloves
(@KORALON25,41305,0,1,1,1,1), -- Relentless Gladiator's Wyrmhide Legguards
(@KORALON25,48094,0,1,1,1,1), -- Zabra's Pants of Triumph
(@KORALON25,48064,0,1,1,1,1), -- Zabra's Leggings of Triumph
(@KORALON25,48096,0,1,1,1,1), -- Zabra's Handwraps of Triumph
(@KORALON25,48066,0,1,1,1,1), -- Zabra's Gloves of Triumph
(@KORALON25,48271,0,1,1,1,1), -- Windrunner's Legguards of Triumph
(@KORALON25,48273,0,1,1,1,1), -- Windrunner's Handguards of Triumph
(@KORALON25,48362,0,1,1,1,1), -- Thrall's War-Kilt of Triumph
(@KORALON25,48303,0,1,1,1,1), -- Thrall's Legguards of Triumph
(@KORALON25,48332,0,1,1,1,1), -- Thrall's Kilt of Triumph
(@KORALON25,48301,0,1,1,1,1), -- Thrall's Handguards of Triumph
(@KORALON25,48364,0,1,1,1,1), -- Thrall's Grips of Triumph
(@KORALON25,48334,0,1,1,1,1), -- Thrall's Gloves of Triumph
(@KORALON25,47770,0,1,1,1,1), -- Sunstrider's Leggings of Triumph
(@KORALON25,47772,0,1,1,1,1), -- Sunstrider's Gauntlets of Triumph
(@KORALON25,48180,0,1,1,1,1), -- Runetotem's Trousers of Triumph
(@KORALON25,48195,0,1,1,1,1), -- Runetotem's Legguards of Triumph
(@KORALON25,48150,0,1,1,1,1), -- Runetotem's Leggings of Triumph
(@KORALON25,48152,0,1,1,1,1), -- Runetotem's Handguards of Triumph
(@KORALON25,48193,0,1,1,1,1), -- Runetotem's Handgrips of Triumph
(@KORALON25,48182,0,1,1,1,1), -- Runetotem's Gloves of Triumph
(@KORALON25,48623,0,1,1,1,1), -- Liadrin's Legplates of Triumph
(@KORALON25,48660,0,1,1,1,1), -- Liadrin's Legguards of Triumph
(@KORALON25,48658,0,1,1,1,1), -- Liadrin's Handguards of Triumph
(@KORALON25,48591,0,1,1,1,1), -- Liadrin's Greaves of Triumph
(@KORALON25,48593,0,1,1,1,1), -- Liadrin's Gloves of Triumph
(@KORALON25,48625,0,1,1,1,1), -- Liadrin's Gauntlets of Triumph
(@KORALON25,48497,0,1,1,1,1), -- Koltira's Legplates of Triumph
(@KORALON25,48554,0,1,1,1,1), -- Koltira's Legguards of Triumph
(@KORALON25,48556,0,1,1,1,1), -- Koltira's Handguards of Triumph
(@KORALON25,48499,0,1,1,1,1), -- Koltira's Gauntlets of Triumph
(@KORALON25,48394,0,1,1,1,1), -- Hellscream's Legplates of Triumph
(@KORALON25,48464,0,1,1,1,1), -- Hellscream's Legguards of Triumph
(@KORALON25,48462,0,1,1,1,1), -- Hellscream's Handguards of Triumph
(@KORALON25,48392,0,1,1,1,1), -- Hellscream's Gauntlets of Triumph
(@KORALON25,47805,0,1,1,1,1), -- Gul'dan's Leggings of Triumph
(@KORALON25,47803,0,1,1,1,1), -- Gul'dan's Gloves of Triumph
(@KORALON25,48239,0,1,1,1,1), -- Garona's Legplates of Triumph
(@KORALON25,48241,0,1,1,1,1), -- Garona's Gauntlets of Triumph
(@KORALON25,48379,0,1,2,1,1), -- Wrynn's Legplates of Triumph
(@KORALON25,48446,0,1,2,1,1), -- Wrynn's Legguards of Triumph
(@KORALON25,48452,0,1,2,1,1), -- Wrynn's Handguards of Triumph
(@KORALON25,48377,0,1,2,1,1), -- Wrynn's Gauntlets of Triumph
(@KORALON25,48258,0,1,2,1,1), -- Windrunner's Legguards of Triumph
(@KORALON25,48256,0,1,2,1,1), -- Windrunner's Handguards of Triumph
(@KORALON25,48079,0,1,2,1,1), -- Velen's Pants of Triumph
(@KORALON25,48077,0,1,2,1,1), -- Velen's Handwraps of Triumph
(@KORALON25,47983,0,1,2,1,1), -- Velen's Gloves of Triumph
(@KORALON25,48226,0,1,2,1,1), -- VanCleef's Legplates of Triumph
(@KORALON25,48224,0,1,2,1,1), -- VanCleef's Gauntlets of Triumph
(@KORALON25,48610,0,1,2,1,1), -- Turalyon's Legplates of Triumph
(@KORALON25,48638,0,1,2,1,1), -- Turalyon's Legguards of Triumph
(@KORALON25,48640,0,1,2,1,1), -- Turalyon's Handguards of Triumph
(@KORALON25,48578,0,1,2,1,1), -- Turalyon's Greaves of Triumph
(@KORALON25,48576,0,1,2,1,1), -- Turalyon's Gloves of Triumph
(@KORALON25,48608,0,1,2,1,1), -- Turalyon's Gauntlets of Triumph
(@KORALON25,48484,0,1,2,1,1), -- Thassarian's Legplates of Triumph
(@KORALON25,48541,0,1,2,1,1), -- Thassarian's Legguards of Triumph
(@KORALON25,48539,0,1,2,1,1), -- Thassarian's Handguards of Triumph
(@KORALON25,48482,0,1,2,1,1), -- Thassarian's Gauntlets of Triumph
(@KORALON25,48349,0,1,2,1,1), -- Nobundo's War-Kilt of Triumph
(@KORALON25,48288,0,1,2,1,1), -- Nobundo's Legguards of Triumph
(@KORALON25,48319,0,1,2,1,1), -- Nobundo's Kilt of Triumph
(@KORALON25,48286,0,1,2,1,1), -- Nobundo's Handguards of Triumph
(@KORALON25,48347,0,1,2,1,1), -- Nobundo's Grips of Triumph
(@KORALON25,48317,0,1,2,1,1), -- Nobundo's Gloves of Triumph
(@KORALON25,48165,0,1,2,1,1), -- Malfurion's Trousers of Triumph
(@KORALON25,48210,0,1,2,1,1), -- Malfurion's Legguards of Triumph
(@KORALON25,48135,0,1,2,1,1), -- Malfurion's Leggings of Triumph
(@KORALON25,48133,0,1,2,1,1), -- Malfurion's Handguards of Triumph
(@KORALON25,48212,0,1,2,1,1), -- Malfurion's Handgrips of Triumph
(@KORALON25,48163,0,1,2,1,1), -- Malfurion's Gloves of Triumph
(@KORALON25,47755,0,1,2,1,1), -- Khadgar's Leggings of Triumph
(@KORALON25,47753,0,1,2,1,1), -- Khadgar's Gauntlets of Triumph
(@KORALON25,47780,0,1,2,1,1), -- Kel'Thuzad's Leggings of Triumph
(@KORALON25,47782,0,1,2,1,1), -- Kel'Thuzad's Gloves of Triumph
(@KORALON25,47985,0,1,2,1,1); -- Velen's Leggings of Triumph
-- Merge PVP and PVE items to one ref
UPDATE `reference_loot_template` SET `entry`=@TORAVON25 WHERE `entry`=34214; -- 25 Toravon
UPDATE `reference_loot_template` SET `entry`=@TORAVON10 WHERE `entry`=34213; -- 10 Toravon
UPDATE `reference_loot_template` SET `entry`=@ARCHAVON10 WHERE `entry`=34210; -- 10 Archavon
UPDATE `reference_loot_template` SET `entry`=@EMALON10 WHERE `entry`=34211; -- 10 Emalon
UPDATE `reference_loot_template` SET `entry`=@KORALON10 WHERE `entry`=34212; -- 10 Koralon
-- Assign to cratures
SET @Tora10 =38433;
SET @Tora25 =38462;
SET @Arch10 =31125;
SET @Arch25 =31722;
SET @Emal10 =33993;
SET @Emal25 =33994;
SET @Kora10 =35013;
SET @Kora25 =35360;
DELETE FROM `creature_loot_template` WHERE `entry`IN (@Tora10,@Tora25,@Arch10,@Arch25,@Emal10,@Emal25,@Kora10,@Kora25);
INSERT INTO `creature_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
-- Update loot template for Toravon 10
(@Tora10,47241,100,1,0,2,2), -- Emblem of triumph
(@Tora10,1,100,1,0,-@TORAVON10,2), -- Gear(Relentless PVP,T10 PVE)
(@Tora10,2,1,1,0,-34203,1), -- Mount
-- Update loot template for Toravon 25 to drop 3 items
(@Tora25,49426,100,1,0,2,2), -- Emblem of frost
(@Tora25,1,100,1,0,-@TORAVON25,3), -- Gear(Wrathful PVP,T10.5 PVE)
(@Tora25,2,1,1,0,-34203,1), -- Mount
-- Update loot template for Archavon 10
(@Arch10,47241,100,1,0,2,2), -- Emblem of triumph
(@Arch10,1,100,1,0,-@ARCHAVON10,2), -- Gear(Hate PVP,T7 PVE)
(@Arch10,2,1,1,0,-34203,1), -- Mount
-- Update loot template for Archavon 25
(@Arch25,47241,100,1,0,2,2), -- Emblem of triumph
(@Arch25,1,100,1,0,-@ARCHAVON25,4), -- Gear(Deadly PVP,T7(25) PVE)
(@Arch25,2,1,1,0,-34203,1), -- Mount
-- Update loot template for Emalon 10
(@Emal10,47241,100,1,0,2,2), -- Emblem of triumph
(@Emal10,1,100,1,0,-@EMALON10,2), -- Gear(Deadly PVP,T8 PVE)
(@Emal10,2,1,1,0,-34203,1), -- Mount
-- Update loot template for Emalon 25
(@Emal25,47241,100,1,0,2,2), -- Emblem of triumph
(@Emal25,1,100,1,0,-@EMALON25,4), -- Gear(Deadly PVP,T8(25) PVE)
(@Emal25,2,1,1,0,-34203,1), -- Mount
-- Update loot template for Koralon 10
(@Kora10,47241,100,1,0,2,2), -- Emblem of triumph
(@Kora10,1,100,1,0,-@KORALON10,2), -- Gear(Furious PVP,T9 PVE)
(@Kora10,2,1,1,0,-34203,1), -- Mount
-- Update loot template for Koralon 25
(@Kora25,47241,100,1,0,2,2), -- Emblem of triumph
(@Kora25,1,100,1,0,-@KORALON25,4), -- Gear(Relentless PVP,T9.5 PVE)
(@Kora25,2,1,1,0,-34203,1); -- Mount
 
 
/* 
* updates\world\2012_09_20_00_world_creature_loot_template.sql 
*/ 
SET @exists = (SELECT 1 FROM `creature_loot_template` WHERE `entry`=100002);
DELETE FROM `creature_loot_template` WHERE `entry`=100002 AND @exists = 1;
DELETE FROM `creature_loot_template` WHERE `mincountOrRef`=-35069 AND @exists = 1;
INSERT INTO `creature_loot_template`(`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) SELECT `entry`,1,100,1,0,-35069,2 FROM `creature_template` WHERE `lootid` = 100002 AND @exists = 1; -- 2 selection from reference
UPDATE `creature_template` SET `lootid`=`entry` WHERE `lootid` = 100002 AND @exists = 1;
 
 
/* 
* updates\world\2012_09_22_01_world_i_was_a_lot_of_things.sql 
*/ 
-- Quest: I was a lot of things
UPDATE `creature_template` SET `AIName`='',`ScriptName`='npc_shadowmoon_tuber_node',`flags_extra`=`flags_extra`|128 WHERE `entry`=21347;

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=36652;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`Comment`) VALUES 
(13,1,36652,31,3,21347,'Tuber Whistle targets Shadowmoon Valley Tuber Node');

UPDATE `creature_template` SET `AIName`='SmartAI',`ScriptName`='' WHERE `entry`=21195;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=21195;
DELETE FROM `smart_scripts` WHERE `entryorguid`=21195 AND `source_type`=0;
INSERT INTO `smart_scripts`(`entryorguid`,`id`,`link`,`event_type`,`event_param2`,`action_type`,`action_param1`,`action_param2`,`target_type`,`target_param1`,`target_param2`,`comment`) VALUES
(21195,1,0,34,1,24,0,0, 1,    0,0, 'Domesticated Felboar - Movementinform - Evade (Required for core script npc_shadowmoon_tuber_node)'),
(21195,2,0,34,1,45,1,1,11,21347,5, 'Domesticated Felboar - Movementinform - Set data (Required for core script npc_shadowmoon_tuber_node)');

SET @TRIGGER_GUID = 77821; -- 10
SET @BOAR_GUID    = 77832; -- 8

DELETE FROM `creature` WHERE `id`=21347 OR `guid` BETWEEN @TRIGGER_GUID AND @TRIGGER_GUID + 9;
SET @TRIGGER_GUID = @TRIGGER_GUID - 1;
INSERT INTO `creature`(`guid`,`id`,`map`,`phaseMask`,`position_x`,`position_y`,`position_z`) 
SELECT (SELECT @TRIGGER_GUID:=@TRIGGER_GUID+1),21347,`map`,3,`position_x`,`position_y`,`position_z` FROM `gameobject` WHERE `id`=184701 LIMIT 10;

DELETE FROM `creature` WHERE (`id`=21195 AND `map`=530) OR `guid` BETWEEN @BOAR_GUID AND @BOAR_GUID + 7;
INSERT INTO `creature`(`guid`,`id`,`map`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`curhealth`,`MovementType`) VALUES
(@BOAR_GUID  ,21195,530,-2506.78,1190.22,55.9496,4.15084,300,5,6116,1),
(@BOAR_GUID+1,21195,530,-2486.92,1326.49,64.4239,5.31872,300,5,6116,1),
(@BOAR_GUID+2,21195,530,-2476.05,1284.68,48.0809,1.20087,300,5,5914,1),
(@BOAR_GUID+3,21195,530,-2476.74,1228.44,40.4087,3.72907,300,5,5914,1),
(@BOAR_GUID+4,21195,530,-2549.03,1162.94,78.8947,1.48754,300,5,6116,1),
(@BOAR_GUID+5,21195,530,-2553.91,1186.80,78.5604,1.17575,300,5,6116,1),
(@BOAR_GUID+6,21195,530,-2694.88,1495.00,19.2922,2.33106,300,5,5914,1),
(@BOAR_GUID+7,21195,530,-2706.26,1538.41,16.6343,1.96146,300,5,5914,1);
 
 
/* 
* updates\world\2012_09_22_03_world_game_event.sql 
*/ 
-- Brewfest (372) duration fix by nelegalno
UPDATE `game_event` SET `length` = 21600 WHERE `eventEntry` = 24;
 
 
/* 
* updates\world\2012_09_24_00_world_spell_script_names.sql 
*/ 
DELETE FROM `spell_script_names` WHERE `spell_id`=6940;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(6940, 'spell_pal_hand_of_sacrifice');
 
 
/* 
* updates\world\2012_09_24_01_world_spell_script_names.sql 
*/ 
DELETE FROM `spell_script_names` WHERE `spell_id`=64205;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(64205, 'spell_pal_divine_sacrifice');
 
 
/* 
* updates\world\2012_09_24_02_world_misc.sql 
*/ 
-- Bring Down the Warbringer! (10603) quest fix by nelegalno Closes #7840
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-100 WHERE `entry`=21287 AND `item`=30689; -- Razuun's Orders http://old.wowhead.com/item=30689

-- The Only Prescription (8620) quest fix by nelegalno
-- Closes #6653 (was changed to reopened but currently treated by github as closed)
-- Closes #7085

-- Chapter I:
-- Move Doctor Weavil on top of the bed
UPDATE `creature` SET `position_z` = 34.5277 WHERE `guid`=18614;

-- Chapter II:
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=6 WHERE (`entry`=8716 AND `item`=21104);
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=10 WHERE (`entry`=8717 AND `item`=21104);
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=4 WHERE (`entry`=12396 AND `item`=21104);

-- Chapter III:
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=6 WHERE (`entry`=7461 AND `item`=21105);
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=6 WHERE (`entry`=7463 AND `item`=21105);

-- Chapter IV, V and VII:
DELETE FROM `gameobject` WHERE (`guid`=45065); -- Remove duplicate of GUID=4596
DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (6668,6669,6670) AND `id`=0;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES
-- source: https://github.com/TrinityCore/TrinityCore/issues/6653#issuecomment-6956847 ( thanks frostmourne ) + http://thottbot.com/item=21107#comments:id=885246 + http://thottbot.com/item=21106#comments:id=1159575
(6668,0,0,'<Take this book for the good of Azeroth!>',1,1,0,0,0,0,NULL),
(6669,0,0,'<Take this book for the good of Azeroth!>',1,1,0,0,0,0,NULL),
(6670,0,0,'<Take this book for the good of Azeroth!>',1,1,0,0,0,0,NULL);

UPDATE `gameobject_template` SET `AIName`='SmartGameObjectAI' WHERE `entry` IN (180665,180666,180667);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (180665,180666,180667) AND `source_type`=1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(180665,1,0,1,62,0,100,0,6669,0,0,0,56,21107,1,0,0,0,0,7,0,0,0,0,0,0,0,'Draconic for Dummies - take book for quest - The Only Prescription'),
(180665,1,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Draconic for Dummies - close gossip'),
(180666,1,0,1,62,0,100,0,6670,0,0,0,56,21106,1,0,0,0,0,7,0,0,0,0,0,0,0,'Draconic for Dummies - take book for quest - The Only Prescription'),
(180666,1,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Draconic for Dummies - close gossip'),
(180667,1,0,1,62,0,100,0,6668,0,0,0,56,21109,1,0,0,0,0,7,0,0,0,0,0,0,0,'Draconic for Dummies - take book for quest - The Only Prescription'),
(180667,1,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Draconic for Dummies - close gossip');

-- Chapter VI:
-- Chapter VIII:
DELETE FROM `creature_loot_template` WHERE `entry`=10184 AND `item`=21108;
DELETE FROM `creature_loot_template` WHERE `entry`=11502 AND `item`=21110;
INSERT INTO `creature_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(10184,21108,100,1,0,1,1),
(11502,21110,100,1,0,1,1);

-- Conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup` IN (6668,6669,6670);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=1 AND `SourceGroup`=15552 AND `SourceEntry`=21130 AND `ConditionTypeOrReference`=8 AND `ConditionValue1`=8606;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=1 AND `SourceGroup`=15552 AND `SourceEntry`=21103 AND `ConditionTypeOrReference`=9 AND `ConditionValue1`=8620;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=1 AND `SourceGroup`=10184 AND `SourceEntry`=21108 AND `ConditionTypeOrReference`=9 AND `ConditionValue1`=8620;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=1 AND `SourceGroup`=11502 AND `SourceEntry`=21110 AND `ConditionTypeOrReference`=9 AND `ConditionValue1`=8620;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(1,15552,21130,0,0,8,0,8606,0,0,0,0,'','Diary of Weavil will drop only when a player have Decoy! (8606) quest rewarded'),
(1,15552,21103,0,0,9,0,8620,0,0,0,0,'','Draconic for Dummies Chapter I will drop only when a player have The Only Prescription (8620) in their quest log'),
(1,10184,21108,0,0,9,0,8620,0,0,0,0,'','Draconic for Dummies Chapter VI will drop only when a player have The Only Prescription (8620) in their quest log'),
(1,11502,21110,0,0,9,0,8620,0,0,0,0,'','Draconic for Dummies Chapter VIII will drop only when a player have The Only Prescription (8620) in their quest log'),
(15,6668,0,0,0,9,0,8620,0,0,0,0,'',"Show gossip only if player have taken The Only Prescription (8620) quest"),
(15,6668,0,0,0,2,0,21109,1,1,1,0,'',"Show gossip only if player doesn't have the item"),
(15,6669,0,0,0,9,0,8620,0,0,0,0,'',"Show gossip only if player have taken The Only Prescription (8620) quest"),
(15,6669,0,0,0,2,0,21107,1,1,1,0,'',"Show gossip only if player doesn't have the item"),
(15,6670,0,0,0,9,0,8620,0,0,0,0,'',"Show gossip only if player have taken The Only Prescription (8620) quest"),
(15,6670,0,0,0,2,0,21106,1,1,1,0,'',"Show gossip only if player doesn't have the item");

-- Replace placeholder GO by correct GO and remove placeholder GO quest Thwart the Dark Conclave (10808) by aokromes closes #6773
UPDATE `gameobject` SET `id`=184750 WHERE `guid`=99983;
DELETE FROM `gameobject_template` WHERE `entry`=300121;

-- Blending In (11633) quest fix by nelegalno  closes #5980 closes #1004
-- Move Spire of Blood Scouted trigger to floor level so it's not outside LoS
UPDATE `creature` SET `position_z` = 131.750 WHERE `guid` = 85206;

-- Cloak of shadow should not provide immunity to Flare Closes #7856
DELETE FROM `spell_linked_spell` WHERE  `spell_trigger`=31224 AND `spell_effect`=-1543 AND `type`=2;

-- Nergeld (30403) partial npc fix by nelegalno
-- Fix conditions
UPDATE `conditions` SET `ConditionValue1`=4595 WHERE `SourceTypeOrReferenceId`=16 AND `SourceEntry`=30403;
-- NPC Spells
UPDATE `creature_template` SET `spell1` = 56746, `spell2` = 56748, `spell3` = 56747, `spell4` = 60540 WHERE `entry` = 30403;

-- Fix Brann's Communicator Closes #5835 author gecko32
DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=61122 AND `spell_effect`=55038;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES 
(61122, 55038, 0, 'Contact Brann');

-- Fix Black Bruise proc Scaling author Vincent-Michael Closes #7040
-- Fix Warlock Death Coil SP Coeff. Closes #3584
DELETE FROM `spell_bonus_data` WHERE `entry` IN (6489,71878,71879);
INSERT INTO `spell_bonus_data` (`entry`,`direct_bonus`,`dot_bonus`,`ap_bonus`,`ap_dot_bonus`,`comments`) VALUES
(6489,0.2143,0,0,0,'Spell Power Coeff for Death Coil'),
(71878,0,0,0,0,'Item - Black Bruise: Heroic Necrotic Touch Proc'),
(71879,0,0,0,0,'Item - Black Bruise: Necrotic Touch Proc');

-- Fix proc for Elemental Focus author Warpten Closes #7769
DELETE FROM `spell_proc_event` WHERE `entry`=16164;
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
(16164, 0x1C, 0x0B, 0x98101417, 0x80043000, 0x00002004, 0x00010000, 0x00000002, 0, 100, 0); 
 
/* 
* updates\world\2012_09_24_03_world_misc.sql 
*/ 
-- Molten Core + Ruins of Ahn'Qiraj + Blackwing Lair + Zul'Gurub + Temple of Ahn'Qiraj Boss Respawn Fix author armano2 closes #5883
UPDATE `creature` SET `spawntimesecs` = 604800 WHERE `Id` IN (12118,11982,12259,12057,12264,12056,11988,12098);
UPDATE `creature` SET `spawntimesecs` = 259200 WHERE `Id` IN (15348,15341,15340,15370,15369,15339);

-- Fix Fertile Spores Drop Chance authore exodius Closes #7727
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`= 35 WHERE `item`=24449;

-- Fix quest Gammothra the tormentor author gacko Closes #7770
UPDATE `creature_template` SET `minlevel`=71,`maxlevel`=71,`faction_A`=14,`faction_H`=14 WHERE `entry`=25790;
UPDATE `creature_template` SET `AIName`='SmartAI',`ScriptName`='' WHERE `entry`=25789;
DELETE FROM `smart_scripts` WHERE `entryorguid`=25789 AND `source_type`=0;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=25789;
INSERT INTO `smart_scripts`(`entryorguid`,`event_type`,`event_param1`,`action_type`,`action_param1`,`target_type`,`comment`) VALUES
(25789,8,46012,36,25790,1,'Gammothra the Tormentor - On spell hit - Update entry to Weakened Gammothra');

-- Disable Unfinished Gordok Business (1318) replaced with Disable Unfinished Gordok Business (7703) fix by nelegalno Closes #7819
DELETE FROM `disables` WHERE `sourceType`=1 AND `entry`=1318;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `params_0`, `params_1`, `comment`) VALUES
(1,1318,0,'','','Unfinished Gordok Business replaced by 7703');

-- Fix Plague Siphon ability (74074) in Lich King encounter in instance Icecrown Citadel, may only target LK (36597) author elron103 Closes #7729
DELETE FROM `conditions` WHERE `SourceEntry` = 74074 AND `SourceTypeOrReferenceId` = 13;
INSERT INTO `conditions` (SourceTypeOrReferenceId, SourceGroup, SourceEntry, SourceId, ElseGroup, ConditionTypeOrReference, ConditionTarget, ConditionValue1, ConditionValue2, ConditionValue3, NegativeCondition, ErrorTextId, ScriptName, Comment) VALUES
(13, 1, 74074, 0, 0, 31, 0, 3, 36597, 0, 0, 0, '', 'Plague Siphon may only target The Lich King');

-- Gurubashi Arena Grand Master (396) achievement fix by nelegalno Closes #7699
-- Short John Mithril (14508) gossip
UPDATE `creature_template` SET `gossip_menu_id` = 5921 WHERE `entry` = 14508;
DELETE FROM `gossip_menu` WHERE `entry`=5921 AND `text_id`=7074;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES(5921,7074);
-- Arena Master (18706) loot fix
UPDATE `item_template` SET `flagsCustom`=flagsCustom|2 WHERE `entry`=18706;
-- Arena Grandmaster (7838) quest is repeatable (players can get 2x Arena Grand Master trinkets)
-- https://www.youtube.com/watch?v=fkJ3vrwC4q4&feature=player_detailpage#t=170s
UPDATE `quest_template` SET `SpecialFlags` = 1 WHERE `Id` = 7838;

-- Update DisenchantID's to proper values for items from Satchel of Helpful Goods (51999) author Exodius Closes #7572
UPDATE `item_template` SET `DisenchantID`=41 WHERE `entry` IN (51964, 51968, 51978, 51994);

-- X Marks... Your Doom! (11166) quest fix by nelegalno Closes #7528
-- For some reason the script doesn't trigger if `flags_extra` = 128 is set
UPDATE `creature_template` SET `unit_flags` = 33554432, `flags_extra` = 0 WHERE `entry` = 23815;

-- Whitebark's Memory (10166) fix despawn timer author nelegalno Closes #7521
-- TODO: Find fix for one-shot kill by high level players
UPDATE `smart_scripts` SET `event_param1`=60000, `event_param2`=60000, `event_param3`=60000, `event_param4`=60000, `comment`="Whitebark's Spirit - after 60sec OOC - despawn" WHERE `entryorguid`=19456 AND `id`=5;

-- Armor of Darkness (12979) conditions fix by nelegalno Closes #7506
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=1 AND `SourceGroup`=29380 AND `SourceEntry`=42203;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(1,29380,42203,0,0,9,0,12978,0,0,0,0,'',"Dark Armor Plate drops if Facing the Storm taken"),
(1,29380,42203,0,1,8,0,12978,0,0,0,0,'',"Dark Armor Plate drops if Facing the Storm rewarded"),
(1,29380,42203,0,1,8,0,12979,0,0,1,0,'',"Dark Armor Plate drops if Armor of Darkness isn't rewarded");

-- Remove duplicate of Swirling Maelstrom (180669) GO author nelegalno Closes #7498
UPDATE `gameobject` SET `id` = 180669 WHERE `guid` = 99900;
DELETE FROM `gameobject_template` WHERE `entry`=300057;

-- The Scepter of the Shifting Sands quest chain fix by nelegalno based on http://www.wowwiki.com/The_Scepter_of_the_Shifting_Sands_quest_chain Closes #7473
-- What Tomorrow Brings > Only One May Rise
UPDATE `quest_template` SET `NextQuestIdChain` = 8288 WHERE `Id` = 8286;
-- A Pawn on the Eternal Board > The Charge of the Dragonflights
UPDATE `quest_template` SET `NextQuestIdChain` = 8555 WHERE `Id` = 8519;
-- The Nightmare's Corruption > The Nightmare Manifests
UPDATE `quest_template` SET `NextQuestIdChain` = 8736 WHERE `Id` = 8735;
-- Azuregos's Magical Ledger > Translating the Ledger
UPDATE `quest_template` SET `NextQuestIdChain` = 8576 WHERE `Id` = 8575;

-- Hive'Zora Scout Report (8534), Hive'Regal Scout Report (8738) and Hive'Ashi Scout Report (8739) quests fix by Raszagal (Inspired by Justiciar's fix drom #3311) 
-- TODO: Get sniffs for gossip_menu_option placeholder texts
-- Closes #3311 and Closes #7453

SET @GOSSIP1 := 6690; -- need confirmation
SET @GOSSIP2 := 6691; -- need confirmation
SET @GOSSIP3 := 6692; -- need confirmation
SET @NPC1 := 15609;
SET @NPC2 := 15610;
SET @NPC3 := 15611;

-- Update Cenarion Scout Landion's, Azenel's, & Jalia's gossip_menu and AI
UPDATE `creature_template` SET `gossip_menu_id`=@GOSSIP1 WHERE `entry`=@NPC1;
UPDATE `creature_template` SET `gossip_menu_id`=@GOSSIP2 WHERE `entry`=@NPC2;
UPDATE `creature_template` SET `gossip_menu_id`=@GOSSIP3 WHERE `entry`=@NPC3;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (@NPC1,@NPC2,@NPC3);
-- Gossips 
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP1 AND `text_id`=8063;
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP2 AND `text_id`=8064;
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP3 AND `text_id`=8065;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES
(@GOSSIP1,8063),
(@GOSSIP2,8064),
(@GOSSIP3,8065);
-- Gossip Options
DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (@GOSSIP1,@GOSSIP2,@GOSSIP3);
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES
(@GOSSIP1,0,0,"May I have your report?",1,1,0,0,0,0,''), -- placeholder untill sniffed
(@GOSSIP2,0,0,"May I have your report?",1,1,0,0,0,0,''), -- placeholder untill sniffed
(@GOSSIP3,0,0,"May I have your report?",1,1,0,0,0,0,''); -- placeholder untill sniffed
-- Conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup` IN (@GOSSIP1,@GOSSIP2,@GOSSIP3);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,@GOSSIP1,0,0,0,2,0,21160,1,0,1,0,'',"Show gossip only if player dosn't have Hive'Regal Scout Report"),
(15,@GOSSIP1,0,0,0,9,0,8738,0,0,0,0,'',"Show gossip only if Hive'Regal Scout Report quest has been taken"),
(15,@GOSSIP2,0,0,0,2,0,21158,1,0,1,0,'',"Show gossip only if player dosn't have Hive'Zora Scout Report"),
(15,@GOSSIP2,0,0,0,9,0,8534,0,0,0,0,'',"Show gossip only if Hive'Zora Scout Report quest has been taken"),
(15,@GOSSIP3,0,0,0,2,0,21161,1,0,1,0,'',"Show gossip only if player dosn't have Hive'Ashi Scout Report"),
(15,@GOSSIP3,0,0,0,9,0,8739,0,0,0,0,'',"Show gossip only if Hive'Ashi Scout Report quest has been taken");
-- Scripts
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@NPC1,@NPC2,@NPC3) AND source_type=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@NPC1,0,0,1,62,0,100,0,@GOSSIP1,0,0,0,11,25847,1,0,0,0,0,7,0,0,0,0,0,0,0,"Cenarion Scout Landion - on gossip option select - cast Create Hive'Regal Scout Report"),
(@NPC1,0,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Cenarion Scout Landion - Link - close gossip"),
(@NPC2,0,0,1,62,0,100,0,@GOSSIP2,0,0,0,11,25843,1,0,0,0,0,7,0,0,0,0,0,0,0,"Cenarion Scout Azenel - on gossip option select - cast Create Hive'Zora Scout Report"),
(@NPC2,0,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Cenarion Scout Azenel - Link - close gossip"),
(@NPC3,0,0,1,62,0,100,0,@GOSSIP3,0,0,0,11,25845,1,0,0,0,0,7,0,0,0,0,0,0,0,"Cenarion Scout Jalia - on gossip option select - ast Create Hive'Ashi Scout Report"),
(@NPC3,0,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Cenarion Scout Jalia - Link - close gossip");
 
 
/* 
* updates\world\2012_09_26_00_world_misc.sql 
*/ 
-- Scripted Npc Infiltrator Marksen (Zombie Form 7293) From Sniff author expecto Closes #6910
UPDATE creature_template SET AIName = 'SmartAI', `spell1` = 7293 WHERE entry = 5416;
DELETE FROM `smart_scripts` WHERE (`entryorguid`=5416 AND `source_type`=0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(5416, 0, 0, 0, 1, 0, 100, 0, 5000, 5000, 10000, 12000, 11, 7293, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Infiltrator Marksen - Cast Zombie Form');

-- Wildlord Antelarion (22127) gossip fix by nelegalno
-- Thanks to @Aokromes for the sniff and @malcrom for all the help
-- Closes #4444 and #5985

UPDATE `creature_template` SET `gossip_menu_id`=8523 WHERE `entry`=22127;

-- Gossip insert from sniff
DELETE FROM `gossip_menu` WHERE `entry`=8523;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (8523,10657);

-- Gossip option sfiffed by Aokromes
DELETE FROM `gossip_menu_option` WHERE `menu_id`=8523;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES
(8523,0,0,"The Felsworn Gas Mask was destroyed, do you have another one?",1,1,0,0,0,0,'');

-- Gossip option conditions
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId`=15 AND `SourceGroup`=8523);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
-- Felsworn Gas Mask quest taken
(15,8523,0,0,0,2,0,31366,1,0,1,0,'',"Show gossip only if player doesnt have Felsworn Gas Mask"),
(15,8523,0,0,0,9,0,10819,0,0,0,0,'',"Show gossip if Felsworn Gas Mask quest taken"),
-- Felsworn Gas Mask quest rewarded and You're Fired! quest not rewarded
(15,8523,0,0,1,2,0,31366,1,0,1,0,'',"Show gossip only if player doesnt have Felsworn Gas Mask"),
(15,8523,0,0,1,8,0,10819,0,0,0,0,'',"Show gossip if Felsworn Gas Mask quest rewarded"),
(15,8523,0,0,1,8,0,10821,0,0,1,0,'',"Hide gossip when You're Fired! quest rewarded");

-- Spell conditions
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId`=17 AND `SourceEntry`=38448);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(17,0,38448,0,0,3,0,31366,0,0,0,0,'',"Felsworn Gas Mask spell only if the mask is equiped");

-- SAI for Wildlord Antelarion
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=22127;
DELETE FROM `smart_scripts` WHERE (`entryorguid`=22127 AND `source_type`=0);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(22127,0,0,1,62,0,100,0,8523,0,0,0,11,39101,0,0,0,0,0,7,0,0,0,0,0,0,0,"Wildlord Antelarion - On Gossip option select - Cast Create Felsword Gas Mask"),
(22127,0,1,2,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Wildlord Antelarion - On Gossip option select - Close Gossip"),
(22127,0,2,0,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Wildlord Antelarion - On Gossip option select - Say 0");

-- NPC talk text insert from sniff
DELETE FROM `creature_text` WHERE `entry` IN (22127) AND `groupid` IN (0);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(22127,0,0,"It's a good thing I was able to make duplicates of the Felsworn Gas Mask.",12,0,100,1,0,0,"Wildlord Antelarion");

-- A Plague Upon Thee (5902, 5904) quest fix by Svannon and nelegalno Closes #7700

DELETE FROM `gossip_menu_option` WHERE `menu_id`=4362;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES
(4362,0,0,'Put the barrel of termites on this box.',1,1,0,0,0,0,''),
(4362,1,0,'Put the barrel of termites on this box.',1,1,0,0,0,0,'');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=4362;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,4362,0,0,0,28,0,5902,0,0,0,0,'','Only Show Gossip if A Plauge Upon Thee 2 is done (Horde)'),
(15,4362,1,0,1,28,0,5904,0,0,0,0,'','Only Show Gossip if A Plauge Upon Thee 2 is done (Ally)'),
-- Allows you to pickup quest if server crashes
(15,4362,0,0,2, 8,0,5902,0,0,0,0,'','Only Show Gossip if A Plauge Upon Thee 2 is rewarded (Horde)'),
(15,4362,0,0,2,28,0,6390,0,0,1,0,'','Only Show Gossip if A Plauge Upon Thee 3 is not taken (Horde)'),
(15,4362,0,0,2, 8,0,6390,0,0,1,0,'','Only Show Gossip if A Plauge Upon Thee 3 is not rewarded (Horde)'),
(15,4362,1,0,3, 8,0,5904,0,0,0,0,'','Only Show Gossip if A Plauge Upon Thee 2 is rewarded (Ally)'),
(15,4362,1,0,3,28,0,6389,0,0,1,0,'','Only Show Gossip if A Plauge Upon Thee 3 is not taken (Ally)'),
(15,4362,1,0,3, 8,0,6389,0,0,1,0,'','Only Show Gossip if A Plauge Upon Thee 3 is not rewarded (Ally)');

UPDATE `gameobject_template` SET `AIName`='SmartGameObjectAI' WHERE `entry`=177490;
DELETE FROM `smart_scripts` WHERE `entryorguid`=177490 AND `source_type`=1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(177490,1,0,1,62,0,100,0,4362,0,0,0,50,177491,60000,0,0,0,0,8,0,0,0,2449.614014,-1662.360352,104.370209,104.370209,'Temp Spawn Termite Barrel'),
(177490,1,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Close Gossip'),
(177490,1,2,1,62,0,100,0,4362,1,0,0,50,177491,60000,0,0,0,0,8,0,0,0,2449.614014,-1662.360352,104.370209,104.370209,'Temp Spawn Termite Barrel');


-- Sanguine Hibiscus spawns by aokromes Closes #6985
SET @OGUID = 11504; -- Set by TDB
DELETE FROM `gameobject` WHERE `guid` BETWEEN @OGUID+0 AND @OGUID+12;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(@OGUID+0, 183385, 546, 3, 1, 80.50446, -70.98401, -2.75813, -1.518436, 0, 0, 0, 1, 7200, 255, 1), -- 183385 (Area: 0)
(@OGUID+1, 183385, 546, 3, 1, 144.8807, -69.80858, 27.43485, 0.9948372, 0, 0, 0, 1, 7200, 255, 1), -- 183385 (Area: 0)
(@OGUID+2, 183385, 546, 3, 1, 52.38583, -188.3249, -4.27433, -2.478367, 0, 0, 0, 1, 7200, 255, 1), -- 183385 (Area: 0)
(@OGUID+3, 183385, 546, 3, 1, 57.51215, -228.6515, -4.474028, -1.919862, 0, 0, 0, 1, 7200, 255, 1), -- 183385 (Area: 0)
(@OGUID+4, 183385, 546, 3, 1, 1.739941, -246.5631, -4.533222, -1.099556, 0, 0, 0, 1, 7200, 255, 1), -- 183385 (Area: 0)
(@OGUID+5, 183385, 546, 3, 1, -98.4295, -312.3992, -3.895051, -1.204277, 0, 0, 0, 1, 7200, 255, 1), -- 183385 (Area: 0)
(@OGUID+6, 183385, 546, 3, 1, -151.6738, -308.3728, -4.809014, 1.658062, 0, 0, 0, 1, 7200, 255, 1), -- 183385 (Area: 0)
(@OGUID+7, 183385, 546, 3, 1, 22.0234, -339.9811, 29.18158, 1.239183, 0, 0, 0, 1, 7200, 255, 1), -- 183385 (Area: 0)
(@OGUID+8, 183385, 546, 3, 1, 74.19567, -402.8985, 33.69212, 1.745327, 0, 0, 0, 1, 7200, 255, 1), -- 183385 (Area: 0)
(@OGUID+9, 183385, 546, 3, 1, 105.351, -295.466, 32.22884, -2.094393, 0, 0, 0, 1, 7200, 255, 1), -- 183385 (Area: 0)
(@OGUID+10, 183385, 546, 3, 1, 257.2508, -263.9068, 24.64264, -2.007128, 0, 0, 0, 1, 7200, 255, 1), -- 183385 (Area: 0)
(@OGUID+11, 183385, 546, 3, 1, 246.2179, -232.5182, 25.95434, 1.466076, 0, 0, 0, 1, 7200, 255, 1), -- 183385 (Area: 0)
(@OGUID+12, 183385, 546, 3, 1, 295.0749, -124.0022, 29.71378, 0.1745321, 0, 0, 0, 1, 7200, 255, 1); -- 183385 (Area: 0)

-- fix loot of Savage Cave Beast Closes #7874
DELETE FROM `creature_loot_template` WHERE `entry` = 31470;
INSERT INTO `creature_loot_template` 
SELECT 31470, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount` FROM `creature_loot_template` WHERE `entry` = 30329;

-- partially revert commit 0deaa521bcae3ab9004529473aceadee134f3a68 author Elron103 Closes #7580
DELETE FROM `disables` WHERE `sourceType`=1 AND `entry` IN (9713,9926,11087,11115,11116,11353,11518,12186,12187,12494,12845,13807,14185,14186,14187,24808,24809,24810,24811,25238);

-- Add conditions for spell In the Maws of Old the God author trista Closes #1664
SET @ThrowFragments := 64184; -- The spell "In the Maws of Old the God" that you throw at Yogg-Saron while he is casting Deafening Roar.
SET @DeafeningRoar :=  64189; -- The scream that Yogg-Saron makes in 3rd phase of 25 man with 0-3 Guardians alive.
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=@ThrowFragments;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition` ,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(17,0,@ThrowFragments,0,0,1,0,@DeafeningRoar,1,0,0,0,'','In the Maws of the Old God can be casted only under the effect of Deafening Roar'),
(17,0,@ThrowFragments,0,0,31,1,3,33288,0,0,0,'','In the Maws of the Old God can target only Yogg-Saron');

-- Fixes Equip Display on King Varian Wrynn author warriorpoetex Closes #6646
UPDATE `creature_equip_template` SET `itemEntry1`=45899, `itemEntry2`=0 WHERE `entry`=1643;
-- Template updates for creature 29611 (King Varian Wrynn)
-- Model data 28127 (creature 29611 (King Varian Wrynn))
UPDATE `creature_model_info` SET `bounding_radius`=0.3875,`combat_reach`=1.25,`gender`=0 WHERE `modelid`=28127; -- King Varian Wrynn
-- Addon data for creature 29611 (King Varian Wrynn)
DELETE FROM `creature_template_addon` WHERE `entry`=29611;
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(29611,0,0,257,0, NULL); -- King Varian Wrynn

-- fix Crashin' Thrashin' Racer author nelegalno Closes #4363
UPDATE `creature_template` SET `spell1` = 49297 WHERE `entry` IN (27664,40281);

-- Gossip sent from League of Arathor Emissary 14991 if player too low for Arathi Basin author malcorm and pitcrawler Closes #6874
-- Gossip sent from Donal Osgood <Arathi Basin Battlemaster> 857 if player too low for Arathi Basin
-- Gossip for Huntress Kima, Eldrin, Herbalist Pomeroy, Lisbeth Schneider, Warg Deepwater, Donald Rabonne, Gremlock Pilsnor, Apprentice Kryten, Bulrug, Ranshalla, Jaron Stoneshaper, Aurora Skycaller, Spirit of the Vale, Farseer Nobundo, Temper

UPDATE `creature_template` SET `gossip_menu_id`=7377 WHERE `entry`=17204;
UPDATE `creature_template` SET `gossip_menu_id`=6471 WHERE `entry`=857;
UPDATE `creature_template` SET `gossip_menu_id`=7695 WHERE `entry`=18416;
UPDATE `creature_template` SET `gossip_menu_id`=4261 WHERE `entry`=1103;
UPDATE `creature_template` SET `gossip_menu_id`=7691 WHERE `entry`=1218;
UPDATE `creature_template` SET `gossip_menu_id`=685 WHERE `entry`=1299;
UPDATE `creature_template` SET `gossip_menu_id`=5665 WHERE `entry`=1683;
UPDATE `creature_template` SET `gossip_menu_id`=5665 WHERE `entry`=2367;
UPDATE `creature_template` SET `gossip_menu_id`=5853 WHERE `entry`=1699;
UPDATE `creature_template` SET `gossip_menu_id`=2601 WHERE `entry`=2788;
UPDATE `creature_template` SET `gossip_menu_id`=9821 WHERE `entry`=10054;
UPDATE `creature_template` SET `gossip_menu_id`=3131 WHERE `entry`=10300;
UPDATE `creature_template` SET `gossip_menu_id`=3761 WHERE `entry`=10301;
UPDATE `creature_template` SET `gossip_menu_id`=4743 WHERE `entry`=10304;
UPDATE `creature_template` SET `gossip_menu_id`=7376 WHERE `entry`=17087;
UPDATE `creature_template` SET `gossip_menu_id`=7378 WHERE `entry`=17205;

DELETE FROM `gossip_menu` WHERE `entry`=6504 AND `text_id`=7699;
DELETE FROM `gossip_menu` WHERE `entry`=6471 AND `text_id`=7642;
DELETE FROM `gossip_menu` WHERE `entry`=7695 AND `text_id`=9389;
DELETE FROM `gossip_menu` WHERE `entry`=4261 AND `text_id`=5413;
DELETE FROM `gossip_menu` WHERE `entry`=7691 AND `text_id`=9385;
DELETE FROM `gossip_menu` WHERE `entry`=685 AND `text_id`=1235;
DELETE FROM `gossip_menu` WHERE `entry`=5853 AND `text_id`=7016;
DELETE FROM `gossip_menu` WHERE `entry`=2601 AND `text_id` IN (3293,3294);
DELETE FROM `gossip_menu` WHERE `entry`=7376 AND `text_id` IN (8826,8827);
DELETE FROM `gossip_menu` WHERE `entry`=7377 AND `text_id` IN (8828,8829);
DELETE FROM `gossip_menu` WHERE `entry`=7378 AND `text_id`=8832;

INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES 
(2601,3293),
(2601,3294),
(6504,7699),
(6471,7642),
(7695,9389),
(4261,5413),
(7691,9385),
(685,1235),
(5853,7016),
(7376,8826),
(7376,8827),
(7377,8828),
(7377,8829),
(7378,8832);

DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (4261,6471) AND `id` = 0;
DELETE FROM `gossip_menu_option` WHERE `menu_id`=4743 AND `id` IN (0,1);
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES
(4261,0,3, 'Train me.',5,16,0,0,0,0, ''),
(6471,0,9, 'I would like to go to the battleground.',12,1048576,0,0,0,0, ''),
(4743,0,0, 'Where can I get Enchanted Thorium?',1,1,0,0,0,0, ''),
(4743,1,0, 'Where can I find Crystal Restore?',1,1,0,0,0,0, '');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=3131 AND `SourceEntry`=4788;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=4743 AND `SourceEntry` IN (5816,5817);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=7376 AND `SourceEntry`=8827;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=4743 AND `SourceEntry` IN (0,1);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=4743 AND `SourceEntry` IN (5816,5817,5795);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=6471 AND `SourceEntry`=7642;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=6504 AND `SourceEntry`=7699;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=6471 AND `SourceEntry`=0;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=5665 AND `SourceEntry` IN (6960,6961);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=5853 AND `SourceEntry`=7021;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,6471,7642,0,0,27,0,20,2,0,0,0,'','Donal Osgood <Arathi Basin Battlemaster> - Show different gossip if player level is below 20'),
(14,6504,7699,0,0,27,0,20,2,0,0,0,'','League of Arathor Emissary - Show different gossip if player level is below 20'),
(15,6471,0,0,0,27,0,20,3,0,0,0,'','Donal Osgood <Arathi Basin Battlemaster> - Show gossip option only if player level is at least 20'),
(14,5665,6960,0,0,7,0,356,225,0,0,0,'','Show different gossip if player has fishing skill 225'),
(14,5665,6961,0,0,7,0,356,225,0,1,0,'','Show gossip if player has not fishing skill 225'),
(14,5853,7021,0,0,7,0,185,1,0,0,0,'','Show different gossip if player has cooking profession'),
(14,3131,4788,0,0,8,0,979,0,0,0,0,'','Show different gossip if player has completed quest 979'),
(14,4743,5816,0,0,28,0,5245,0,0,0,0,'','Show different gossip if player has quest 5245 objectives complete'),
(14,4743,5817,0,0,8,0,5245,0,0,0,0,'','Show different gossip if player has completed quest 5245'),
(14,4743,5795,0,0,8,0,5247,0,0,0,0,'','Show different gossip if player has completed quest 5247'),
(14,7376,8827,0,0,8,0,9450,0,0,1,0,'','Show different gossip if player has not completed quest 9450'),
(15,4743,0,0,0,9,0,5247,0,0,0,0,'','Show gossip option only if player has taken quest 5247 but not complete'),
(15,4743,1,0,0,9,0,5247,0,0,0,0,'','Show gossip option only if player has taken quest 5247 but not complete');


-- Flesh Eating Worms should not have loot author exodius Closes #7144
UPDATE `creature_template` SET `lootid`=0 WHERE `entry`=2462;
-- Remove loot template for Entry 2462.
-- Flesh Eating Worms should not have loot and ID is not related to any other creature
DELETE FROM `creature_loot_template` WHERE `entry`=2462 and `item` IN (785,2450,2452,2453,2772,2835,2838,3369);

-- Wailing Winds (30450) loot fix by nelegalno Closes #6382
DELETE FROM `creature_loot_template` WHERE (`entry`=30450);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
(30450, 26001, 3, 1, 1, -26001, 1),
(30450, 26002, 3, 1, 1, -26002, 1),
(30450, 26012, 1, 1, 1, -26012, 1),
(30450, 26013, 1, 1, 1, -26013, 1),
(30450, 26014, 1, 1, 1, -26014, 1),
(30450, 26015, 1, 1, 1, -26015, 1),
(30450, 45912, 0.1, 1, 0, 1, 1),
(30450, 39512, 80, 1, 0, 1, 1),
(30450, 37702, 25, 1, 0, 1, 2),
(30450, 39513, 20, 1, 0, 1, 1);

-- Daio the Decrepit (14463) gossip fix by nelegalno Closes #7376
UPDATE `creature_template` SET `gossip_menu_id` = 5824 WHERE `entry` = 14463;
DELETE FROM `gossip_menu` WHERE `entry`=5824 AND `text_id`=6995;
INSERT INTO `gossip_menu` (`entry`, `text_id`) VALUES (5824,6995);

-- Set pickpocketloot data for Skeletal Reavers author trista Closes #7366
SET @SREAVER := 32467;
UPDATE `creature_template` SET `pickpocketloot`=`entry` WHERE `entry`=@SREAVER; 
DELETE FROM `pickpocketing_loot_template` WHERE `entry`=@SREAVER;   
INSERT INTO `pickpocketing_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES 
(@SREAVER,35947,0.7,1,0,1,1), -- Sparkling Frostcap 
(@SREAVER,33447,0.7,1,0,1,1), -- Runic Healing Potion   
(@SREAVER,38269,1.4,1,0,1,1), -- Soggy Handkerchief
(@SREAVER,43575,1.6,1,0,1,1); -- Reinforced Junkbox

-- Bone Gryphon (29414) NPC needed for No Fly Zone (12815) quest by Vincent-Michael Closes #7355
SET @ENTRY := 29414; -- Bone Gryphon

UPDATE `creature_template` SET `spell5`=0, `InhabitType` = 5 WHERE `entry` = @ENTRY;
DELETE FROM `creature_template_addon` WHERE `entry`=@ENTRY;
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(@ENTRY,0,0,0x3000000,0x1,0,'54422 54476');

-- Remove hardcored old model at creature for Rull Snowhoof author aokromes Closes #7261
UPDATE `creature` SET `modelid`=0 WHERE `guid`=32333;

-- Fix NPC Lhara, from Darkmoon Faire author Mick3y16 Closes #6998
-- Fixes Artic Fur (90 minutes)
UPDATE `npc_vendor` SET `incrtime`=9000 WHERE `entry`=14846 AND `item`=44128;
-- Fixes the LK Gems (60 minutes)
UPDATE `npc_vendor` SET `incrtime`=3600 WHERE `entry`=14846 AND `ExtendedCost`=2484;
-- Fixes the BC Gems (60 minutes)
UPDATE `npc_vendor` SET `incrtime`=3600 WHERE `entry`=14846 AND `item` IN (23441,23440,23439,23438,23437,23436);
-- Fixes Black Lotus (30 minutes)
UPDATE `npc_vendor` SET `incrtime`=1800 WHERE `entry`=14846 AND `item`=13468;
-- Fixes The Rest (15 minutes)
UPDATE `npc_vendor` SET `incrtime`=900 WHERE `entry`=14846 AND `item` IN (36906,36905,36904,36903,36901,33568,25708,36907,36908,38425,37921,37705,37704,37703,37702,37701,37700,25707,21887,22572,22573,22574,22575,22576,22577,22578,4304,8170,2319,4234);

-- The Masters Terrace (9645) quest fix by nelegalno Closes #6855
UPDATE `creature_template` SET `InhabitType` = 4 WHERE `entry` = 17652;

DELETE FROM `event_scripts` WHERE `id`=10951;
INSERT INTO `event_scripts` (`id`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`) VALUES
(10951,0,10,17651,300000,0,-11161,-1923.2,91.4737,2.89811);

-- Zeppelin: <The Purple Princess> author malcom Closes #6664
UPDATE `creature_transport` SET `emote`=173 WHERE `transport_entry`=176495 AND `npc_entry`=25101; -- Crewman Cutpipe
UPDATE `creature_transport` SET `emote`=133 WHERE `transport_entry`=176495 AND `npc_entry`=25102; -- Crewman Spinshaft
UPDATE `creature_transport` SET `emote`=173 WHERE `transport_entry`=176495 AND `npc_entry`=25103; -- Crewman Boltshine
UPDATE `creature_model_info` SET `modelid_other_gender`=0 WHERE `modelid`=4083; -- Watcher Umjin should only have a male model
UPDATE `creature_model_info` SET `modelid_other_gender`=0 WHERE `modelid`=4084; -- Watcher Du'una should only have a female model
DELETE FROM `creature_template_addon` WHERE `entry`=25107;
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(25107,0,0,3,1,0, ''); -- STATE_SLEEP
-- Zeppelin: <Iron Eagle>
UPDATE `creature_model_info` SET `modelid_other_gender`=0 WHERE `modelid`=4259; -- Grunt Umgor should only have a male model
UPDATE `creature_transport` SET `TransOffsetX`=-10.3057, `TransOffsetY`=-12.10524, `TransOffsetZ`=-16.96907, `TransOffsetO`=5.927236 WHERE `transport_entry`=175080 AND`npc_entry`=24926; -- Chief Officer Brassbolt
UPDATE `creature_transport` SET `emote`=133 WHERE `transport_entry`=175080 AND `npc_entry`=24931; -- Crewman Fastwrench
DELETE FROM `creature_transport` WHERE `transport_entry`=175080 AND `npc_entry` IN (24927,24929,24930);
INSERT INTO `creature_transport` (`guid`,`transport_entry`,`npc_entry`,`TransOffsetX`,`TransOffsetY`,`TransOffsetZ`,`TransOffsetO`,`emote`) VALUES
(3,175080,24927,-1.874165,-7.847112,-23.68718,3.385939,0), -- Navigator Sparksizzle
(4,175080,24929,9.083008,-4.964111,-23.59211,1.594056,133), -- Crewman Crosswire
(5,175080,24930,-17.0083,-7.874878,-15.18782,3.141593,133); -- Crewman Gazzlegear
-- Zeppelin: <The Cloudkisser>
-- Deleting some NPCs that are double spawned out of the zeppelin. They are already spawned by `creature_transport` table
DELETE FROM `creature` WHERE `guid` IN (
116702, -- Crewman Coilspan
116703, -- Crewman Coilspan
117715, -- Deathguard Hicks
117750 ); -- Sky-Captain Cryoflight
UPDATE `creature_transport` SET `npc_entry`=31715 WHERE `guid`=3 AND `transport_entry`=181689; -- Deathguard Hicks
UPDATE `creature_transport` SET `emote`=133 WHERE `transport_entry`=181689 AND `npc_entry`=31704; -- Crewman Spinwheel
UPDATE `creature_transport` SET `emote`=133 WHERE `transport_entry`=181689 AND `npc_entry`=31705; -- Crewman Coilspan
UPDATE `creature_transport` SET `emote`=133, `TransOffsetO`=4.64346 WHERE `transport_entry`=181689 AND`npc_entry`=31706; -- Crewman Stembolt
DELETE FROM `creature_transport` WHERE `transport_entry`=181689 AND `npc_entry`=25075; -- Zeppelin Controls
INSERT INTO `creature_transport` (`guid`,`transport_entry`,`npc_entry`,`TransOffsetX`,`TransOffsetY`,`TransOffsetZ`,`TransOffsetO`,`emote`) VALUES
(7,181689,25075,4.362147,-2.254167,-23.59002,4.712389,0); -- Zeppelin Controls
UPDATE `creature_template` SET `exp`=2 WHERE `entry`=31708; -- Deathguard Barth
-- Zeppelin: <The Mighty Wind>
UPDATE `creature_model_info` SET `gender`=0, `modelid_other_gender`=0 WHERE `modelid`=4601; -- Grunt Gritch should only have a male model
UPDATE `creature_model_info` SET `gender`=1, `modelid_other_gender`=0 WHERE `modelid`=4602; -- Grunt Grikee should only have a female model
UPDATE `creature_transport` SET `TransOffsetO`=1.16964 WHERE `transport_entry`=186238 AND `npc_entry`=31726; -- Grunt Gritch orientation
UPDATE `creature_transport` SET `TransOffsetO`=5.47991 WHERE `transport_entry`=186238 AND `npc_entry`=31727; -- Grunt Grikee orientation
UPDATE `creature_transport` SET `emote`=133 WHERE `transport_entry`=186238 AND `npc_entry`=31720; -- Crewman Shubbscoop
UPDATE `creature_transport` SET `emote`=133 WHERE `transport_entry`=186238 AND `npc_entry`=31723; -- Crewman Barrowswizzle
UPDATE `creature_transport` SET `emote`=133 WHERE `transport_entry`=186238 AND `npc_entry`=31724; -- Crewman Paltertop
-- Zeppelin: <The Thundercaller>
UPDATE `creature_transport` SET `emote`=133 WHERE `transport_entry`=164871 AND `npc_entry`=25071; -- Crewman Rusthammer
UPDATE `creature_transport` SET `emote`=133 WHERE `transport_entry`=164871 AND `npc_entry`=25072; -- Crewman Quickfix
UPDATE `creature_transport` SET `emote`=133 WHERE `transport_entry`=164871 AND `npc_entry`=25074; -- Crewman Sparkfly
DELETE FROM `creature_transport` WHERE `transport_entry`=164871 AND `npc_entry`=25077; -- Sky-Captain Cloudkicker
INSERT INTO `creature_transport` (`guid`,`transport_entry`,`npc_entry`,`TransOffsetX`,`TransOffsetY`,`TransOffsetZ`,`TransOffsetO`,`emote`) VALUES
(18,164871,25077,-19.68856,-8.170582,-14.37648,3.176499,0); -- Sky-Captain Cloudkicker
-- Zeppelin: <The Zephyr>
UPDATE `creature_transport` SET `emote`=173 WHERE `transport_entry`=190549 AND `npc_entry`=34719; 

-- Fix flight masters around the Dark Portal in Outland (16.11.2011) by SignFinder ( https://github.com/TrinityCore/TrinityCore/issues/2596#issuecomment-4450115 ) Closes #6401

-- Vlagga Freyfeather SAI
SET @NPC := 18930;
SET @GOSSIP_VLAGGA := 7938;
SET @SPELL_STAIR_OF_DESTINY_THRALLMAR := 34924;
DELETE FROM `creature_ai_scripts` WHERE `creature_id` =@NPC;
UPDATE `creature_template` SET `AIName`= "SmartAI" WHERE `entry` =@NPC;
DELETE FROM `smart_scripts` WHERE `entryorguid` =@NPC;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@NPC,0,0,0,62,0,100,0,@GOSSIP_VLAGGA,1,0,0,11,@SPELL_STAIR_OF_DESTINY_THRALLMAR,2,0,0,0,0,7,0,0,0,0,0,0,0,"Vlagga Freyfeather - On Gossip Select - Cast Stair of Destiny to Thrallmar"),
(@NPC,0,1,2,4,0,100,0,0,0,0,0,12,9297,4,30000,0,0,0,1,0,0,0,0,0,0,0,"Vlagga Freyfeather - On Aggro - Summon Enraged Wyvern"),
(@NPC,0,2,3,61,0,100,0,0,0,0,0,12,9297,4,30000,0,0,0,1,0,0,0,0,0,0,0,"Vlagga Freyfeather - On Aggro - Summon Enraged Wyvern"),
(@NPC,0,3,0,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Vlagga Freyfeather - On Aggro - Say Line 0");

-- Amish Wildhammer SAI
SET @NPC := 18931;
SET @GOSSIP_AMISH := 7939;
SET @SPELL_STAIR_OF_DESTINY_HONOR_HOLD := 34907;
DELETE FROM `creature_ai_scripts` WHERE `creature_id` =@NPC;
UPDATE `creature_template` SET `AIName`= "SmartAI" WHERE `entry` =@NPC;
DELETE FROM `smart_scripts` WHERE `entryorguid` =@NPC;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@NPC,0,0,0,62,0,100,0,@GOSSIP_AMISH,1,0,0,11,@SPELL_STAIR_OF_DESTINY_HONOR_HOLD,2,0,0,0,0,7,0,0,0,0,0,0,0,"Amish Wildhammer - On Gossip Select - Cast Stair of Destiny to Honor Hold"),
(@NPC,0,1,2,4,0,100,0,0,0,0,0,12,9526,4,30000,0,0,0,1,0,0,0,0,0,0,0,"Amish Wildhammer - On Aggro - Summon Enraged Gryphon"),
(@NPC,0,2,3,61,0,100,0,0,0,0,0,12,9526,4,30000,0,0,0,1,0,0,0,0,0,0,0,"Amish Wildhammer - On Aggro - Summon Enraged Gryphon"),
(@NPC,0,3,0,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Amish Wildhammer - On Aggro - Say Line 0");

-- Gossip inserts
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP_AMISH;
DELETE FROM `npc_text` WHERE `ID` IN (9935,9991);
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP_AMISH,10052);
DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (@GOSSIP_AMISH,@GOSSIP_VLAGGA);
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES
(@GOSSIP_AMISH,0,2,"Show me where I can fly.",4,8192,0,0,0,0,''),
(@GOSSIP_AMISH,1,2,"Send me to Honor Hold!",4,8192,0,0,0,0,''),
(@GOSSIP_VLAGGA,0,2,"Show me where I can fly.",4,8192,0,0,0,0,''),
(@GOSSIP_VLAGGA,1,2,"Send me to Thrallmar!",4,8192,0,0,0,0,'');

-- Gossip conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup` IN (@GOSSIP_AMISH,@GOSSIP_VLAGGA);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,@GOSSIP_AMISH,0,0,0,8,10140,0,0,0,'',"Show gossip option 0 if player has rewarded quest Journey to Honor Hold"),
(15,@GOSSIP_AMISH,1,0,0,28,10140,0,0,0,'',"Show gossip option 1 if player has complete quest Journey to Honor Hold"),
(15,@GOSSIP_VLAGGA,0,0,0,8,10289,0,0,0,'',"Show gossip option 0 if player has rewarded quest Journey to Thrallmar"),
(15,@GOSSIP_VLAGGA,1,0,0,28,10289,0,0,0,'',"Show gossip option 1 if player has complete quest Journey to Thrallmar");

-- fix dedication of honor movie playback. author trista and vincent-michael. Closes 	#5754
SET @MEMORIAL := 202443;
SET @Script := 20244300;
UPDATE `gameobject_template` SET AIName = 'SmartGameObjectAI' WHERE entry = @MEMORIAL;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@MEMORIAL);
DELETE FROM `smart_scripts` WHERE `source_type`=9 AND `entryorguid`=@Script;
INSERT INTO `smart_scripts` VALUES
(@MEMORIAL,1,0,0,62,0,100,0,11431,0,0,0,80,@Script,0,0,0,0,0,1,0,0,0,0,0,0,0,'Memorial - On gossip select - Run Script'),
(@Script,9,0,0,0,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Actionlist - On action 0 - Close gossip'),
(@Script,9,1,0,0,0,100,0,0,0,0,0,68,16,0,0,0,0,0,7,0,0,0,0,0,0,0,'Actionlist - On action 1 - Startmovie');
SET @OGUID := 342;

DELETE FROM `gameobject` WHERE `id`=@MEMORIAL;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(@OGUID,@MEMORIAL,571,1,1,5804.526,638.5417,647.6481,2.460913,0,0,0,1,120,255,1); -- Dedication of Honor

-- Add immune to interrupt for hodir & ignis AUTHOR gecko32 Closes #5617
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|2|4|8|16|64|256|512|1024|2048|4096|8192|65536|131072|524288|4194304|8388608|33554432|67108864|536870912 WHERE `entry` IN (32845,32846,33118,33190);

-- Leader of the Deranged ID: 11240 - adds spawn and SAI author trista Closes #5556
SET @GUID := 42567;
SET @ID := 24048;
SET @Dynamite := 7978;
-- Add spawn
DELETE FROM `creature` WHERE `id`=@ID;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `MovementType`) VALUES
(@GUID, @ID, 571, 1, 3, 1742.082764, -3339.336426, 79.993713, 2.515936, 120, 20, 0, 1);
-- Add simple SAI for Squeeg Idolhunter
UPDATE `creature_template` SET `AIName`= 'SmartAI' WHERE `entry`=@ID;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ID;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ID,0,1,0,0,0,100,0,2000,6000,12000,15000,11,@Dynamite,0,0,0,0,0,2,0,0,0,0,0,0,0,'Combat - Throw Dynamite');

-- Gnomish Army Knife Resurrection (54732) is restricted to Grand Master Engineers (51306) author mweinelt Closes #5415
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 17 AND `SourceEntry` = 54732 LIMIT 1;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 54732, 0, 0, 25, 0, 51306, 0, 0, 0, 0, '', 'Only Grand-Masters in Engineering can use the Gnomish Army Knife to resurrect players.');

-- Add Pint-Sized Pink Pachyderm to Brewfest vendors author Exodius Closes #4907
SET @PINT := 46707; -- Pint-Sized Pink Pachyderm
DELETE FROM `npc_vendor` WHERE `item`=@PINT;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`) VALUES
(23710,0,@PINT,0,0,2275), -- Vendor Belbi Quikswitch
(24495,0,@PINT,0,0,2275), -- Vendor Blix Fixwidget
(27478,0,@PINT,0,0,2275), -- Vendor Larkin Thunderbrew
(27489,0,@PINT,0,0,2275); -- Vendor Rayma

-- Kalu'ak Fishing Derby start time fix ( http://old.wowhead.com/event=424 ) author neglanalgo Closes #4743 Closes #4717
UPDATE `game_event` SET `start_time` = '2012-01-07 14:00:00' WHERE `eventEntry` = 64;
UPDATE `game_event` SET `start_time` = '2012-01-07 13:00:00' WHERE `eventEntry` = 63;

-- Stranglethorn Fishing Extravaganza start time fix ( http://old.wowhead.com/event=301 )
UPDATE `game_event` SET `start_time` = '2012-01-01 14:00:00' WHERE `eventEntry` IN (15, 62);
UPDATE `game_event` SET `start_time` = '2012-01-01 00:00:00', `length` = 1440 WHERE `eventEntry` = 14; -- Grinkle and Barrus should appear before the event starts (1440=24h, currently set to 27h from event start)

-- [QUEST] All Along The Watchtowers author valcorb and kaelima Closes #4637
SET @GUID := 5282;
SET @ENTRY := 300030;
SET @NEWENTRY := 176095;
UPDATE `gameobject_template` SET `entry`=@NEWENTRY WHERE `entry`=@ENTRY;
DELETE FROM `gameobject` WHERE `id` IN (@ENTRY,@NEWENTRY) OR `guid` BETWEEN @GUID+0 AND @GUID+3;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(@GUID  ,@NEWENTRY,0,1,1,1308.24 ,-1303.41 ,64.3047 ,4.15194,0,0,0.875091,-0.483959,300,0,1),
(@GUID+1,@NEWENTRY,0,1,1,1473.977,-1409.814,67.76421,5.60571,0,0,0.332297,-0.943175,300,0,1),
(@GUID+2,@NEWENTRY,0,1,1,1560.28 ,-1485.03 ,68.3929 ,1.36456,0,0,0.630563, 0.776138,300,0,1),
(@GUID+3,@NEWENTRY,0,1,1,1327.56 ,-1581.53 ,61.7238 ,3.42781,0,0,0.989778,-0.14262 ,300,0,1);

-- [NPC] Fix behaviour of Scarlet Peasant author Valcorb Closes #3925
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=28557;
DELETE FROM `smart_scripts` WHERE `entryorguid`=28557 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(28557, 0, 0, 0, 2, 0, 20, 1, 0, 20, 1, 1, 1, 0, 10, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'At 0-20% hp- say text'),
(28557, 0, 1, 0, 2, 0, 20, 1, 0, 20, 1, 1, 1, 1, 10, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'At 0-20% hp- say text'),
(28557, 0, 2, 0, 2, 0, 20, 1, 0, 20, 1, 1, 1, 2, 10, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'At 0-20% hp- say text'),
(28557, 0, 3, 0, 2, 0, 20, 1, 0, 20, 1, 1, 1, 3, 10, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'At 0-20% hp- say text'),
(28557, 0, 4, 0, 2, 0, 20, 1, 0, 20, 1, 1, 1, 4, 10, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'At 0-20% hp- say text');

DELETE FROM `creature_text` WHERE `entry`=28557 AND `probability`=100;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`)
VALUES
(28557, 0, 0, 'Ungh! I ... I think I pooped...', 12, 0, 100, 0, 0, 0, 'Scarlet Peasant'),
(28557, 0, 1, 'I... I have a sick grandmother at home... I--I''m all she''s got.', 12, 0, 100, 0, 0, 0, 'Scarlet Peasant'),
(28557, 0, 2, 'I picked the wrong week to quit drinkin''!', 12, 0, 100, 0, 0, 0, 'Scarlet Peasant'),
(28557, 0, 3, 'I''ve got five kids lady, they''ll die without me!', 12, 0, 100, 0, 0, 0, 'Scarlet Peasant'),
(28557, 0, 4, 'You don''t have to do this! Nobody has to die!', 12, 0, 100, 0, 0, 0, 'Scarlet Peasant');

-- Cast Terrified! when Citizen of New Avalon enters combat author Valcorb Closes #3734
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (28941,28942);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (28941, 28942);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28941, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 52716, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon 1 - if enter combat - fear'),
(28942, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 52716, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon 2 - if enter combat - fear');

-- Credit fix for stinking up southshore 1657 author Norfik Closes #3552
DELETE FROM `event_scripts` WHERE `id`=9417;
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES
(9417, 3, 8, 15415, 0, 0, 0, 0, 0, 0);

-- Alexstrasza and Korialstrasz author vlomax Closes #7746
SET @PHASE := 2;
SET @GGUID := 76055;
-- Plants & flames
DELETE FROM `gameobject` WHERE `id` BETWEEN 193196 AND 193198 OR `id` BETWEEN 193220 AND 193386 OR `id` BETWEEN 193388 AND 193393 OR `id` BETWEEN 193396 AND 193399 OR `guid` BETWEEN @GGUID AND @GGUID+181;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(@GGUID+0,193196, 571, 1, @PHASE, 4840.929, 1494.97, 209.6041, 2.103119, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+1,193197, 571, 1, @PHASE, 4875.424, 1486.991, 209.5768, 2.120576, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+2,193198, 571, 1, @PHASE, 4875.969, 1487.23, 209.6242, 5.707228, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+3,193220, 571, 1, @PHASE, 4901.706, 1501.568, 214.8973, 0.0005237369, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+4,193221, 571, 1, @PHASE, 4899.952, 1499.167, 214.9082, 5.41925, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+5,193223, 571, 1, @PHASE, 4867.679, 1501.424, 209.7898, 0.969179, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+6,193225, 571, 1, @PHASE, 4869.894, 1498.136, 209.9754, 2.077466, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+7,193229, 571, 1, @PHASE, 4899.046, 1500.026, 213.7757, 4.281601, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+8,193222, 571, 1, @PHASE, 4867.967, 1505.212, 209.1965, 1.82941, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+9,193224, 571, 1, @PHASE, 4867.233, 1510.344, 210.8179, 2.48454, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+10,193228, 571, 1, @PHASE, 4867.919, 1513.521, 211.374, 4.224219, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+11,193227, 571, 1, @PHASE, 4872.966, 1514.59, 212.3312, 4.885982, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+12,193226, 571, 1, @PHASE, 4868.827, 1515.047, 210.5834, 1.567609, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+13,193230, 571, 1, @PHASE, 4875.33, 1483.97, 209.321, 1.099933, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+14,193231, 571, 1, @PHASE, 4875.167, 1482.726, 209.5813, 3.899255, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+15,193232, 571, 1, @PHASE, 4873.677, 1479.37, 209.2619, 6.044956, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+16,193233, 571, 1, @PHASE, 4878.027, 1483.453, 209.3674, 3.726801, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+17,193234, 571, 1, @PHASE, 4874.569, 1482.123, 209.5809, 5.821372, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+18,193235, 571, 1, @PHASE, 4874.725, 1480.063, 209.5809, 3.477762, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+19,193236, 571, 1, @PHASE, 4877.155, 1482.281, 209.5077, 6.219547, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+20,193237, 571, 1, @PHASE, 4879.968, 1484.747, 209.8505, 4.501981, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+21,193238, 571, 1, @PHASE, 4876.323, 1484.97, 208.3138, 2.230834, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+22,193239, 571, 1, @PHASE, 4877.1, 1484.656, 209.1863, 2.269449, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+23,193240, 571, 1, @PHASE, 4871.932, 1485.224, 209.3937, 1.457871, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+24,193241, 571, 1, @PHASE, 4868.574, 1498.977, 210.52, 0.1396255, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+25,193242, 571, 1, @PHASE, 4868.924, 1496.627, 210.149, 3.220151, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+26,193243, 571, 1, @PHASE, 4866.884, 1497.613, 209.2193, 5.581869, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+27,193244, 571, 1, @PHASE, 4870.409, 1485.929, 208.8148, 2.012669, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+28,193245, 571, 1, @PHASE, 4873.674, 1463.747, 209.9446, 1.692968, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+29,193246, 571, 1, @PHASE, 4867.43, 1463.248, 208.1823, 3.382769, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+30,193247, 571, 1, @PHASE, 4870.533, 1463.094, 209.2539, 2.985031, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+31,193248, 571, 1, @PHASE, 4872.965, 1463.778, 208.817, 0.3284273, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+32,193249, 571, 1, @PHASE, 4866.135, 1454.382, 209.254, 2.906489, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+33,193250, 571, 1, @PHASE, 4863.497, 1511.99, 211.0073, 5.427976, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+34,193251, 571, 1, @PHASE, 4862.127, 1509.542, 210.2737, 4.765272, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+35,193252, 571, 1, @PHASE, 4865.178, 1507.217, 210.3379, 5.044526, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+36,193253, 571, 1, @PHASE, 4853.508, 1504.255, 209.7053, 1.998924, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+37,193254, 571, 1, @PHASE, 4849.161, 1504.778, 210.4205, 4.066619, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+38,193255, 571, 1, @PHASE, 4835.896, 1488.719, 209.5815, 3.416903, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+39,193256, 571, 1, @PHASE, 4841.354, 1482.227, 209.5805, 1.850049, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+40,193257, 571, 1, @PHASE, 4841.196, 1489.903, 209.5813, 5.725396, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+41,193258, 571, 1, @PHASE, 4840.608, 1484.361, 209.5813, 2.016231, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+42,193259, 571, 1, @PHASE, 4839.124, 1486.542, 209.2619, 1.978337, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+43,193260, 571, 1, @PHASE, 4843.821, 1489.113, 209.283, 5.184155, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+44,193261, 571, 1, @PHASE, 4842.286, 1483.191, 209.5809, 0.3759405, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+45,193262, 571, 1, @PHASE, 4845.386, 1486.806, 209.4725, 1.254085, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+46,193263, 571, 1, @PHASE, 4835.046, 1490.908, 209.2909, 1.831047, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+47,193264, 571, 1, @PHASE, 4838.369, 1493.165, 209.3897, 2.568887, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+48,193265, 571, 1, @PHASE, 4842.897, 1491.009, 209.5809, 5.959332, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+49,193266, 571, 1, @PHASE, 4844.97, 1489.892, 209.3359, 3.932379, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+50,193267, 571, 1, @PHASE, 4847.749, 1488.823, 209.301, 5.789437, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+51,193268, 571, 1, @PHASE, 4841.975, 1486.234, 209.4944, 5.791942, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+52,193269, 571, 1, @PHASE, 4844.339, 1484.116, 209.4908, 3.889533, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+53,193270, 571, 1, @PHASE, 4840.96, 1481.422, 209.4966, 4.98909, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+54,193271, 571, 1, @PHASE, 4844.502, 1486.135, 209.3802, 1.443149, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+55,193272, 571, 1, @PHASE, 4836.853, 1488.425, 209.4966, 3.060501, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+56,193273, 571, 1, @PHASE, 4844.616, 1493.514, 209.3608, 3.11481, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+57,193274, 571, 1, @PHASE, 4847.851, 1486.434, 209.3608, 1.151302, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+58,193275, 571, 1, @PHASE, 4841.349, 1488.082, 208.3138, 3.749274, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+59,193276, 571, 1, @PHASE, 4842.697, 1487.741, 209.3854, 3.587177, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+60,193277, 571, 1, @PHASE, 4847.485, 1488.835, 207.9903, 0.485505, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+61,193278, 571, 1, @PHASE, 4856.974, 1498.668, 210.0112, 5.593781, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+62,193279, 571, 1, @PHASE, 4860.162, 1499.833, 209.4969, 5.515764, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+63,193280, 571, 1, @PHASE, 4862.285, 1462.604, 209.3651, 4.037887, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+64,193281, 571, 1, @PHASE, 4862.758, 1457.965, 209.9445, 0.4537852, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+65,193282, 571, 1, @PHASE, 4859.121, 1463.345, 209.3854, 5.777565, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+66,193283, 571, 1, @PHASE, 4861.292, 1455.554, 209.3854, 5.742657, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+67,193284, 571, 1, @PHASE, 4865.374, 1460.495, 209.1164, 0.3146807, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+68,193285, 571, 1, @PHASE, 4865.479, 1453.684, 209.7114, 5.969027, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+69,193286, 571, 1, @PHASE, 4840.913, 1402.094, 192.9591, 5.131985, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+70,193287, 571, 1, @PHASE, 4837.317, 1400.465, 192.6397, 1.384923, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+71,193288, 571, 1, @PHASE, 4842.942, 1402.059, 192.9587, 5.365919, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+72,193289, 571, 1, @PHASE, 4836.487, 1403.299, 192.8744, 2.467085, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+73,193290, 571, 1, @PHASE, 4840.022, 1400.498, 191.6916, 3.15663, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+74,193291, 571, 1, @PHASE, 4854.309, 1417.488, 193.4538, 2.059487, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+75,193292, 571, 1, @PHASE, 4848.659, 1414.785, 191.6916, 3.749274, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+76,193293, 571, 1, @PHASE, 4852.316, 1415.811, 192.7632, 2.889032, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+77,193394, 571, 1, @PHASE, 4822.109, 1385.169, 190.8455, 0.5934095, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+78,193294, 571, 1, @PHASE, 4856.42, 1416.295, 192.7632, 1.702218, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+79,193395, 571, 1, @PHASE, 4770.155, 1370.927, 176.3797, 2.809977, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+80,193295, 571, 1, @PHASE, 4838.964, 1398.37, 192.9591, 1.928963, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+81,193296, 571, 1, @PHASE, 4842.648, 1399.972, 192.6608, 4.590742, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+82,193297, 571, 1, @PHASE, 4842.655, 1397.182, 192.8535, 0.6606718, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+83,193298, 571, 1, @PHASE, 4844.037, 1399.976, 192.7137, 3.338978, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+84,193299, 571, 1, @PHASE, 4844.027, 1397.335, 192.6788, 4.733513, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+85,193300, 571, 1, @PHASE, 4839.507, 1398.616, 192.8744, 5.198529, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+86,193301, 571, 1, @PHASE, 4840.949, 1399.462, 192.7632, 2.993751, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+87,193302, 571, 1, @PHASE, 4844.576, 1399.304, 191.3681, 5.878576, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+88,193303, 571, 1, @PHASE, 4819.022, 1437.061, 195.9568, 0.7853968, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+89,193304, 571, 1, @PHASE, 4814.786, 1441.675, 193.9325, 2.475178, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+90,193305, 571, 1, @PHASE, 4816.835, 1438.477, 195.4229, 1.614948, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+91,193306, 571, 1, @PHASE, 4818.494, 1434.955, 194.9861, 6.227641, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+92,193307, 571, 1, @PHASE, 4804.619, 1464.389, 193.2142, 0.8726636, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+93,193308, 571, 1, @PHASE, 4802.317, 1465.608, 192.5236, 1.702218, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+94,193309, 571, 1, @PHASE, 4838.382, 1400.665, 192.9736, 0.165805, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+95,193310, 571, 1, @PHASE, 4804.275, 1462.243, 192.1949, 0.03171997, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+96,193311, 571, 1, @PHASE, 4818.627, 1432.585, 195.6188, 0.7931821, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+97,193312, 571, 1, @PHASE, 4818.935, 1434.288, 194.9375, 6.100451, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+98,193313, 571, 1, @PHASE, 4802.595, 1414.417, 193.2174, 5.02655, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+99,193314, 571, 1, @PHASE, 4808.629, 1416.099, 191.6722, 0.4331469, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+100,193315, 571, 1, @PHASE, 4805.602, 1422.391, 192.5222, 3.915716, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+101,193316, 571, 1, @PHASE, 4806.971, 1413.819, 192.5371, 0.8470061, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+102,193317, 571, 1, @PHASE, 4800.958, 1415.844, 192.1961, 4.185608, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+103,193318, 571, 1, @PHASE, 4814.53, 1421.677, 193.837, 4.031712, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+104,193319, 571, 1, @PHASE, 4818.464, 1416.958, 192.3035, 0.1713461, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+105,193320, 571, 1, @PHASE, 4816.804, 1417.587, 192.5431, 2.827954, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+106,193321, 571, 1, @PHASE, 4813.185, 1424.823, 193.4423, 2.793048, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+107,193322, 571, 1, @PHASE, 4810.121, 1419.193, 193.3252, 3.648265, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+108,193323, 571, 1, @PHASE, 4807.363, 1428.156, 193.9222, 3.0194, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+109,193324, 571, 1, @PHASE, 4806.887, 1426.839, 192.9712, 0.3234065, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+110,193325, 571, 1, @PHASE, 4822.01, 1384.936, 193.2164, 4.05789, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+111,193326, 571, 1, @PHASE, 4821.838, 1389.484, 192.8276, 1.342961, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+112,193327, 571, 1, @PHASE, 4826.813, 1380.915, 191.5601, 5.747677, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+113,193328, 571, 1, @PHASE, 4824.364, 1383.818, 192.6317, 4.887444, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+114,193329, 571, 1, @PHASE, 4822.135, 1389.366, 192.6317, 3.831524, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+115,193330, 571, 1, @PHASE, 4823.995, 1380.991, 192.6317, 6.161535, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+116,193331, 571, 1, @PHASE, 4822.26, 1387.094, 192.1949, 3.21697, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+117,193332, 571, 1, @PHASE, 4799.996, 1468.615, 191.452, 2.562449, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+118,193333, 571, 1, @PHASE, 4792.137, 1470.661, 193.0653, 6.161014, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+119,193334, 571, 1, @PHASE, 4794.401, 1474.757, 192.7633, 4.957259, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+120,193335, 571, 1, @PHASE, 4790.183, 1467.854, 192.762, 4.922352, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+121,193336, 571, 1, @PHASE, 4796.58, 1468.24, 192.1685, 5.777565, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+122,193337, 571, 1, @PHASE, 4784.452, 1470.938, 192.9553, 4.127707, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+123,193338, 571, 1, @PHASE, 4784.479, 1470.891, 192.5763, 0.9255483, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+124,193339, 571, 1, @PHASE, 4772.658, 1434.781, 193.2318, 3.691376, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+125,193340, 571, 1, @PHASE, 4774.897, 1439.738, 192.737, 3.725339, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+126,193341, 571, 1, @PHASE, 4775.096, 1434.278, 192.5412, 4.040963, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+127,193342, 571, 1, @PHASE, 4796.264, 1462.712, 192.9666, 6.045015, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+128,193343, 571, 1, @PHASE, 4790.44, 1461.151, 192.981, 5.148722, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+129,193344, 571, 1, @PHASE, 4791.811, 1461.446, 192.6317, 2.452708, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+130,193345, 571, 1, @PHASE, 4796.167, 1458.012, 192.8273, 4.96452, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+131,193346, 571, 1, @PHASE, 4778.761, 1431.167, 191.4696, 5.21535, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+132,193347, 571, 1, @PHASE, 4772.64, 1435.917, 192.8096, 5.940294, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+133,193348, 571, 1, @PHASE, 4774.135, 1431.061, 192.5412, 5.821197, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+134,193349, 571, 1, @PHASE, 4772.312, 1368.96, 179.3861, 0.8115751, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+135,193350, 571, 1, @PHASE, 4768.762, 1368.182, 178.913, 1.444671, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+136,193351, 571, 1, @PHASE, 4768.806, 1368.814, 178.492, 0.1401508, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+137,193352, 571, 1, @PHASE, 4773.032, 1368.717, 178.4498, 6.18401, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+138,193353, 571, 1, @PHASE, 4769.212, 1371.894, 177.5704, 3.96744, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+139,193354, 571, 1, @PHASE, 4753.28, 1340.752, 168.824, 5.942847, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+140,193355, 571, 1, @PHASE, 4755.793, 1348.842, 171.9237, 2.460914, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+141,193356, 571, 1, @PHASE, 4748.543, 1338.941, 166.3824, 5.994266, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+142,193357, 571, 1, @PHASE, 4755.62, 1346.563, 169.7958, 1.349443, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+143,193358, 571, 1, @PHASE, 4753.616, 1343.335, 168.9523, 0.4892147, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+144,193359, 571, 1, @PHASE, 4756.417, 1343.859, 170.2456, 1.763303, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+145,193360, 571, 1, @PHASE, 4751.151, 1340.321, 166.6075, 5.101904, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+146,193361, 571, 1, @PHASE, 4734.48, 1318.531, 157.1364, 1.850571, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+147,193362, 571, 1, @PHASE, 4729.611, 1321.644, 157.5598, 3.769916, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+148,193363, 571, 1, @PHASE, 4730.31, 1318.991, 155.5435, 4.299054, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+149,193364, 571, 1, @PHASE, 4730.522, 1317.274, 156.2261, 2.566151, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+150,193365, 571, 1, @PHASE, 4845.421, 1487.394, 209.5798, 3.621566, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+151,193366, 571, 1, @PHASE, 4873.986, 1482.95, 209.5806, 2.321287, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+152,193367, 571, 1, @PHASE, 4877.768, 1484.813, 209.6253, 0.9861118, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+153,193368, 571, 1, @PHASE, 4843.112, 1399.606, 192.9736, 4.04044, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+154,193369, 571, 1, @PHASE, 4733.987, 1316.142, 156.3821, 4.214973, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+155,193370, 571, 1, @PHASE, 4771.53, 1370.231, 177.6764, 3.473215, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+156,193371, 571, 1, @PHASE, 4747.052, 1371.73, 174.6061, 3.272515, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+157,193372, 571, 1, @PHASE, 4745.647, 1372.851, 180.6194, 0.2879769, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+158,193373, 571, 1, @PHASE, 4748.801, 1370.48, 177.2103, 1.125736, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+159,193374, 571, 1, @PHASE, 4739.766, 1375.458, 175.0408, 5.899213, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+160,193375, 571, 1, @PHASE, 4747.372, 1376.691, 177.1419, 4.241152, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+161,193376, 571, 1, @PHASE, 4729.662, 1338.746, 165.7118, 1.483528, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+162,193377, 571, 1, @PHASE, 4724.683, 1339.089, 165.6361, 0.9512024, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+163,193378, 571, 1, @PHASE, 4722.371, 1315.175, 153.0163, 4.712391, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+164,193379, 571, 1, @PHASE, 4722.186, 1312.745, 151.8177, 2.207837, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+165,193380, 571, 1, @PHASE, 4721.955, 1313.016, 155.3777, 4.267334, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+166,193381, 571, 1, @PHASE, 4828.909, 1364.957, 187.7651, 3.141593, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+167,193382, 571, 1, @PHASE, 4767.654, 1414.143, 182.9588, 3.141593, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+168,193383, 571, 1, @PHASE, 4885.875, 1446.399, 197.2411, 3.141593, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+169,193384, 571, 1, @PHASE, 4967.423, 1382.576, 280.6783, 3.141593, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+170,193385, 571, 1, @PHASE, 4819.641, 1494.38, 197.8983, 3.141593, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+171,193386, 571, 1, @PHASE, 4760.751, 1331.356, 166.7298, 1.483529, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+172,193388, 571, 1, @PHASE, 4841.913, 1491.074, 209.5806, 5.026549, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+173,193389, 571, 1, @PHASE, 4854.66, 1501.157, 209.4814, 2.347464, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+174,193390, 571, 1, @PHASE, 4867.81, 1503.073, 209.8845, 4.398232, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+175,193391, 571, 1, @PHASE, 4806.318, 1418.541, 192.7293, 3.996809, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+176,193392, 571, 1, @PHASE, 4809.103, 1418.015, 192.8921, 1.754055, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+177,193393, 571, 1, @PHASE, 4866.126, 1504.92, 209.6104, 3.586657, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+178,193396, 571, 1, @PHASE, 4794.685, 1457.065, 192.5883, 2.644167, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+179,193397, 571, 1, @PHASE, 4733.944, 1315.556, 156.3676, 5.009097, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+180,193398, 571, 1, @PHASE, 4848.95, 1412.977, 192.9511, 4.468044, 0, 0, 0, 1, 120, 255, 1),
(@GGUID+181,193399, 571, 1, @PHASE, 4859.428, 1457.759, 209.3438, 3.168109, 0, 0, 0, 1, 120, 255, 1);

-- Corpses
SET @DGUID := 132088;
DELETE FROM `creature` WHERE `id` IN (31285,31291,31292,31293,31294,31295,31296,31297,31298,31299,31308,31309,31333,31334) OR `guid` BETWEEN @DGUID+0 AND @DGUID+106;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `MovementType`) VALUES
(@DGUID+0, 31285, 571, 1, @PHASE, 4810.068, 1433.69, 195.6479, 5.305801, 120, 0, 0),
(@DGUID+1, 31285, 571, 1, @PHASE, 4806.54, 1410.767, 193.0403, 2.216568, 120, 0, 0),
(@DGUID+2, 31285, 571, 1, @PHASE, 4777.13, 1381.836, 183.996, 4.852015, 120, 0, 0),
(@DGUID+3, 31285, 571, 1, @PHASE, 4789.429, 1353.953, 179.1624, 0.3490658, 120, 0, 0),
(@DGUID+4, 31285, 571, 1, @PHASE, 4763.894, 1359.176, 177.5973, 0.1570796, 120, 0, 0),
(@DGUID+5, 31285, 571, 1, @PHASE, 4774.729, 1312.329, 165.0715, 5.5676, 120, 0, 0),
(@DGUID+6, 31285, 571, 1, @PHASE, 4756.614, 1313.47, 163.9544, 2.949606, 120, 0, 0),
(@DGUID+7, 31291, 571, 1, @PHASE, 4978.657, 1384.775, 284.3949, 2.076942, 120, 0, 0),
(@DGUID+8, 31291, 571, 1, @PHASE, 4984.935, 1394.382, 284.4201, 2.548181, 120, 0, 0),
(@DGUID+9, 31291, 571, 1, @PHASE, 5000.523, 1401.637, 284.4431, 2.094395, 120, 0, 0),
(@DGUID+10, 31291, 571, 1, @PHASE, 4990.958, 1400.277, 284.4431, 2.216568, 120, 0, 0),
(@DGUID+11, 31292, 571, 1, @PHASE, 4877.27, 1396.353, 196.93, 0.3316126, 120, 0, 0),
(@DGUID+12, 31292, 571, 1, @PHASE, 4891.048, 1415.103, 203.7862, 3.403392, 120, 0, 0),
(@DGUID+13, 31292, 571, 1, @PHASE, 4854.961, 1403.068, 193.1462, 2.792527, 120, 0, 0),
(@DGUID+14, 31292, 571, 1, @PHASE, 4806.509, 1352.567, 177.8115, 4.520403, 120, 0, 0),
(@DGUID+15, 31292, 571, 1, @PHASE, 4903.382, 1452.207, 211.9405, 4.223697, 120, 0, 0),
(@DGUID+16, 31292, 571, 1, @PHASE, 4869.447, 1468.438, 209.6567, 4.660029, 120, 0, 0),
(@DGUID+17, 31292, 571, 1, @PHASE, 4865.569, 1475.438, 209.6567, 3.438299, 120, 0, 0),
(@DGUID+18, 31292, 571, 1, @PHASE, 4850.112, 1476.327, 209.6567, 0.08726646, 120, 0, 0),
(@DGUID+19, 31292, 571, 1, @PHASE, 4908.861, 1484.187, 216.1365, 5.707227, 120, 0, 0),
(@DGUID+20, 31292, 571, 1, @PHASE, 4814.862, 1428.201, 195.6479, 4.363323, 120, 0, 0),
(@DGUID+21, 31292, 571, 1, @PHASE, 4881.099, 1509.474, 212.8491, 3.595378, 120, 0, 0),
(@DGUID+22, 31292, 571, 1, @PHASE, 4804.274, 1418.215, 193.1435, 2.932153, 120, 0, 0),
(@DGUID+23, 31292, 571, 1, @PHASE, 4806.403, 1468.882, 193.0345, 3.263766, 120, 0, 0),
(@DGUID+24, 31292, 571, 1, @PHASE, 4907.143, 1523.7, 219.6291, 0.08726646, 120, 0, 0),
(@DGUID+25, 31292, 571, 1, @PHASE, 4786.057, 1420.029, 193.0345, 5.288348, 120, 0, 0),
(@DGUID+26, 31292, 571, 1, @PHASE, 4833.672, 1526.136, 214.1294, 0.06981317, 120, 0, 0),
(@DGUID+27, 31292, 571, 1, @PHASE, 4917.417, 1531.887, 222.61, 6.178465, 120, 0, 0),
(@DGUID+28, 31292, 571, 1, @PHASE, 4761.258, 1368.303, 178.9943, 1.466077, 120, 0, 0),
(@DGUID+29, 31292, 571, 1, @PHASE, 4783.711, 1333.142, 172.5176, 0.8377581, 120, 0, 0),
(@DGUID+30, 31293, 571, 1, @PHASE, 4806.841, 1393.394, 193.0345, 3.735005, 120, 0, 0),
(@DGUID+31, 31293, 571, 1, @PHASE, 4841.265, 1541.912, 219.3147, 1.064651, 120, 0, 0),
(@DGUID+32, 31293, 571, 1, @PHASE, 4837.178, 1389.151, 193.0345, 4.590216, 120, 0, 0),
(@DGUID+33, 31293, 571, 1, @PHASE, 4859.151, 1419.09, 193.0345, 2.670354, 120, 0, 0),
(@DGUID+34, 31293, 571, 1, @PHASE, 4823.465, 1391.159, 193.0345, 5.201081, 120, 0, 0),
(@DGUID+35, 31293, 571, 1, @PHASE, 4856.67, 1389.393, 193.8499, 4.502949, 120, 0, 0),
(@DGUID+36, 31293, 571, 1, @PHASE, 4876.147, 1402.939, 196.7943, 2.775074, 120, 0, 0),
(@DGUID+37, 31293, 571, 1, @PHASE, 4873.234, 1453.22, 209.6567, 4.764749, 120, 0, 0),
(@DGUID+38, 31293, 571, 1, @PHASE, 4824.768, 1425.156, 195.6479, 4.939282, 120, 0, 0),
(@DGUID+39, 31293, 571, 1, @PHASE, 4846.874, 1446.988, 207.1275, 0.6981317, 120, 0, 0),
(@DGUID+40, 31293, 571, 1, @PHASE, 4830.034, 1436.004, 197.6899, 0.5235988, 120, 0, 0),
(@DGUID+41, 31293, 571, 1, @PHASE, 4857.192, 1462.829, 209.6567, 2.75762, 120, 0, 0),
(@DGUID+42, 31293, 571, 1, @PHASE, 4782.909, 1344.619, 174.218, 5.044002, 120, 0, 0),
(@DGUID+43, 31293, 571, 1, @PHASE, 4828.281, 1450.926, 202.2973, 1.012291, 120, 0, 0),
(@DGUID+44, 31293, 571, 1, @PHASE, 4786.116, 1405.732, 193.179, 5.794493, 120, 0, 0),
(@DGUID+45, 31293, 571, 1, @PHASE, 4779.775, 1390.742, 187.9587, 4.886922, 120, 0, 0),
(@DGUID+46, 31293, 571, 1, @PHASE, 4792.564, 1435.472, 193.046, 1.658063, 120, 0, 0),
(@DGUID+47, 31293, 571, 1, @PHASE, 4916.556, 1487.116, 220.1032, 5.305801, 120, 0, 0),
(@DGUID+48, 31293, 571, 1, @PHASE, 4922.137, 1497.21, 221.5407, 4.380776, 120, 0, 0),
(@DGUID+49, 31293, 571, 1, @PHASE, 4748.541, 1397.654, 180.7619, 5.550147, 120, 0, 0),
(@DGUID+50, 31293, 571, 1, @PHASE, 4828.431, 1497.15, 209.6567, 5.375614, 120, 0, 0),
(@DGUID+51, 31293, 571, 1, @PHASE, 4749.81, 1411.689, 182.592, 3.298672, 120, 0, 0),
(@DGUID+52, 31293, 571, 1, @PHASE, 4738.797, 1371.466, 175.4915, 2.373648, 120, 0, 0),
(@DGUID+53, 31293, 571, 1, @PHASE, 4886.754, 1523.797, 215.9392, 5.358161, 120, 0, 0),
(@DGUID+54, 31293, 571, 1, @PHASE, 4837.775, 1520.019, 212.4781, 0.6806784, 120, 0, 0),
(@DGUID+55, 31293, 571, 1, @PHASE, 4824.301, 1523.997, 213.3131, 2.827433, 120, 0, 0),
(@DGUID+56, 31294, 571, 1, @PHASE, 4830.872, 1392.478, 193.0345, 2.687807, 120, 0, 0),
(@DGUID+57, 31294, 571, 1, @PHASE, 4828.948, 1409.091, 193.2837, 1.064651, 120, 0, 0),
(@DGUID+58, 31294, 571, 1, @PHASE, 4815.367, 1395.433, 193.0345, 5.532694, 120, 0, 0),
(@DGUID+59, 31294, 571, 1, @PHASE, 4794.247, 1394.424, 193.1791, 6.038839, 120, 0, 0),
(@DGUID+60, 31294, 571, 1, @PHASE, 4802.3, 1399.704, 193.0345, 3.351032, 120, 0, 0),
(@DGUID+61, 31294, 571, 1, @PHASE, 4830.452, 1444.031, 200.6221, 5.410521, 120, 0, 0),
(@DGUID+62, 31294, 571, 1, @PHASE, 4768.52, 1380.417, 180.6092, 3.717551, 120, 0, 0),
(@DGUID+63, 31294, 571, 1, @PHASE, 4768.484, 1329.129, 170.6705, 0.2443461, 120, 0, 0),
(@DGUID+64, 31294, 571, 1, @PHASE, 4793.612, 1318.202, 166.5614, 0.8901179, 120, 0, 0),
(@DGUID+65, 31294, 571, 1, @PHASE, 4744.752, 1339.035, 165.5099, 5.218534, 120, 0, 0),
(@DGUID+66, 31295, 571, 1, @PHASE, 4849.039, 1415.038, 193.0345, 4.468043, 120, 0, 0),
(@DGUID+67, 31295, 571, 1, @PHASE, 4817.007, 1407.061, 193.0441, 3.036873, 120, 0, 0),
(@DGUID+68, 31295, 571, 1, @PHASE, 4865.909, 1465.047, 209.6567, 3.752458, 120, 0, 0),
(@DGUID+69, 31295, 571, 1, @PHASE, 4851.484, 1458.09, 209.8327, 2.775074, 120, 0, 0),
(@DGUID+70, 31295, 571, 1, @PHASE, 4795.949, 1342.791, 173.9115, 1.867502, 120, 0, 0),
(@DGUID+71, 31295, 571, 1, @PHASE, 4737.459, 1326.971, 160.5632, 3.001966, 120, 0, 0),
(@DGUID+72, 31296, 571, 1, @PHASE, 4852.959, 1470.127, 209.6567, 0.08726646, 120, 0, 0),
(@DGUID+73, 31296, 571, 1, @PHASE, 4817.938, 1436.592, 195.6479, 4.555309, 120, 0, 0),
(@DGUID+74, 31296, 571, 1, @PHASE, 4728.732, 1359.011, 170.9604, 3.403392, 120, 0, 0),
(@DGUID+75, 31297, 571, 1, @PHASE, 4797.594, 1448.583, 193.0345, 3.525565, 120, 0, 0),
(@DGUID+76, 31297, 571, 1, @PHASE, 4795.805, 1415.629, 193.0345, 1.134464, 120, 0, 0),
(@DGUID+77, 31297, 571, 1, @PHASE, 4769.275, 1367.561, 178.9943, 5.934119, 120, 0, 0),
(@DGUID+78, 31297, 571, 1, @PHASE, 4759.774, 1375.651, 178.9943, 5.044002, 120, 0, 0),
(@DGUID+79, 31297, 571, 1, @PHASE, 4741.744, 1377.741, 176.0065, 4.729842, 120, 0, 0),
(@DGUID+80, 31297, 571, 1, @PHASE, 4747.381, 1362.794, 174.5987, 0.8028514, 120, 0, 0),
(@DGUID+81, 31297, 571, 1, @PHASE, 4713.244, 1322.761, 157.8859, 0.3665192, 120, 0, 0),
(@DGUID+82, 31298, 571, 1, @PHASE, 4843.441, 1461.766, 209.8327, 0.3665192, 120, 0, 0),
(@DGUID+83, 31298, 571, 1, @PHASE, 4834.151, 1451.847, 204.5755, 3.054326, 120, 0, 0),
(@DGUID+84, 31298, 571, 1, @PHASE, 4842.909, 1472.404, 209.6567, 2.129302, 120, 0, 0),
(@DGUID+85, 31298, 571, 1, @PHASE, 4786.143, 1428.748, 193.0345, 3.490659, 120, 0, 0),
(@DGUID+86, 31298, 571, 1, @PHASE, 4776.408, 1372.417, 180.5029, 5.72468, 120, 0, 0),
(@DGUID+87, 31298, 571, 1, @PHASE, 4738.453, 1334.156, 163.0611, 1.43117, 120, 0, 0),
(@DGUID+88, 31298, 571, 1, @PHASE, 4718.738, 1328.104, 159.9639, 5.410521, 120, 0, 0),
(@DGUID+89, 31328, 571, 1, @PHASE, 4740.34, 1311.947, 157.4052, 3.352981, 120, 0, 0),
(@DGUID+90, 31299, 571, 1, @PHASE, 4809.043, 1403.146, 193.0345, 1.780236, 120, 0, 0),
(@DGUID+91, 31299, 571, 1, @PHASE, 4794.851, 1401.514, 193.1791, 4.223697, 120, 0, 0),
(@DGUID+92, 31299, 571, 1, @PHASE, 4787.426, 1445.673, 193.0345, 2.9147, 120, 0, 0),
(@DGUID+93, 31299, 571, 1, @PHASE, 4768.885, 1388.273, 183.4424, 1.466077, 120, 0, 0),
(@DGUID+94, 31299, 571, 1, @PHASE, 4752.259, 1347.163, 170.3656, 4.677482, 120, 0, 0),
(@DGUID+95, 31308, 571, 1, @PHASE, 4869.767, 1529.764, 217.0381, 1.727876, 120, 0, 0),
(@DGUID+96, 31308, 571, 1, @PHASE, 4792.602, 1459.009, 193.0345, 4.904375, 120, 0, 0),
(@DGUID+97, 31308, 571, 1, @PHASE, 4781.22, 1443.945, 193.0345, 3.996804, 120, 0, 0),
(@DGUID+98, 31308, 571, 1, @PHASE, 4862.371, 1561.015, 224.5057, 0.1047198, 120, 0, 0),
(@DGUID+99, 31308, 571, 1, @PHASE, 4883.59, 1474.877, 209.6595, 1.117011, 120, 0, 0),
(@DGUID+100, 31309, 571, 1, @PHASE, 4836.271, 1413.927, 193.3568, 0.6108652, 120, 0, 0),
(@DGUID+101, 31309, 571, 1, @PHASE, 4901.72, 1508.318, 216.3484, 5.934119, 120, 0, 0),
(@DGUID+102, 31309, 571, 1, @PHASE, 4936.82, 1491.539, 226.006, 0.715585, 120, 0, 0),
(@DGUID+103, 31309, 571, 1, @PHASE, 4862.213, 1552.967, 223.6236, 4.764749, 120, 0, 0),
(@DGUID+104, 31309, 571, 1, @PHASE, 4894.372, 1462.795, 209.8621, 5.689773, 120, 0, 0),
(@DGUID+105, 31333, 571, 1, @PHASE, 4855.18, 1472.166, 209.6567, 0.9075712, 120, 0, 0),
(@DGUID+106, 31334, 571, 1, @PHASE, 4885.178, 1456.164, 209.715, 1.832596, 120, 0, 0);

-- Apply "permanent feign death" to the corpses
SET @DEAD := 29266;
DELETE FROM `creature_template_addon` WHERE `entry` IN (31285,31291,31292,31293,31294,31295,31296,31297,31298,31299,31308,31309);
INSERT INTO `creature_template_addon` (`entry`, `auras`) VALUES
(31285, @DEAD),(31291, @DEAD),(31292, @DEAD),(31293, @DEAD),
(31294, @DEAD),(31295, @DEAD),(31296, @DEAD),(31297, @DEAD),
(31298, @DEAD),(31299, @DEAD),(31308, @DEAD),(31309, @DEAD);

-- spawn Dark Ranger Marrah author vincent-michael Closes #7681
SET @CGUID:= 42568;
SET @ENTRY:= 24137; -- Dark Ranger Marrah

DELETE FROM `creature` WHERE `id` = @ENTRY;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `MovementType`) VALUES
(@CGUID, @ENTRY, 574, 3, 1, 183.8515, -76.50119, 15.84287, 3.455082, 7200, 0, 0);

DELETE FROM `creature_template_addon` WHERE `entry` = @ENTRY;
INSERT INTO `creature_template_addon` (`entry`, `mount`, `bytes1`, `bytes2`, `auras`) VALUES
(@ENTRY, 0, 0x20000, 0x1, '34189');

-- fix spawn for A dip in the moonwell Closes #7292
UPDATE `gameobject` SET `id` =  181825 WHERE `guid` = 16880;

-- Add Loose Soil spawn for quest 299 "Uncovering the Past" author warriotpoetex Closes #6742
SET @GUID := 344;
DELETE FROM `gameobject` WHERE `guid`=@GUID;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(@GUID,331,0,1,1,-3563.83,-1767.35,79.1001,4.26498,0,0,0.846355,-0.53262,300,0,1);
 
 
/* 
* updates\world\2012_09_26_01_world_spell_bonus_data.sql 
*/ 
DELETE FROM `spell_bonus_data` WHERE `entry` IN (6489,6789);
INSERT INTO `spell_bonus_data` (`entry`,`direct_bonus`,`dot_bonus`,`ap_bonus`,`ap_dot_bonus`,`comments`) VALUES
(6789,0.2143,0,0,0,'Spell Power Coeff for Death Coil'); 
 
/* 
* updates\world\2012_09_27_01_world_custodian_of_time.sql 
*/ 
-- Custodian of Time's Whispers for quest 10277
DELETE FROM `script_texts` WHERE `entry` IN (-1000217,-1000218,-1000219,-1000220,-1000221,-1000222,-1000223,-1000224,-1000225,-1000226,-1000227,-1000228,-1000229,-1000230);
DELETE FROM `creature_text` WHERE `entry`=20129; 
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES 
(20129,0,0, 'Greetings, $N. I will guide you through the cavern. Please try and keep up.',15,0,100,0,0,0, 'WHISPER_CUSTODIAN_1'),
(20129,1,0, 'We do not know if the Caverns of Time have always been accessible to mortals. Truly, it is impossible to tell as the Timeless One is in perpetual motion, changing our timeways as he sees fit. What you see now may very well not exist tomorrow. You may wake up and have no memory of this place.',15,0,100,0,0,0, 'WHISPER_CUSTODIAN_2'),
(20129,2,0, 'It is strange, I know... Most mortals cannot actually comprehend what they see here, as often, what they see is not anchored within their own perception of reality.',15,0,100,0,0,0, 'WHISPER_CUSTODIAN_3'),
(20129,3,0, 'Follow me, please.',15,0,100,0,0,0, 'WHISPER_CUSTODIAN_4'),
(20129,4,0, 'There are only two truths to be found here: First, that time is chaotic, always in flux, and completely malleable and second, perception does not dictate reality.',15,0,100,0,0,0, 'WHISPER_CUSTODIAN_5'),
(20129,5,0, 'As custodians of time, we watch over and care for Nozdormu''s realm. The master is away at the moment, which means that attempts are being made to dramatically alter time. The master never meddles in the affairs of mortals but instead corrects the alterations made to time by others. He is reactionary in this regard.',15,0,100,0,0,0, 'WHISPER_CUSTODIAN_6'),
(20129,6,0, 'For normal maintenance of time, the Keepers of Time are sufficient caretakers. We are able to deal with most ordinary disturbances. I speak of little things, such as rogue mages changing something in the past to elevate their status or wealth in the present.',15,0,100,0,0,0, 'WHISPER_CUSTODIAN_7'),
(20129,7,0, 'These tunnels that you see are called timeways. They are infinite in number. The ones that currently exist in your reality are what the master has deemed as ''trouble spots.'' These trouble spots may differ completely in theme but they always share a cause. That is, their existence is a result of the same temporal disturbance. Remember that should you venture inside one...',15,0,100,0,0,0, 'WHISPER_CUSTODIAN_8'),
(20129,8,0, 'This timeway is in great disarray! We have agents inside right now attempting to restore order. What information I have indicates that Thrall''s freedom is in jeopardy. A malevolent organization known as the Infinite Dragonflight is trying to prevent his escape. I fear without outside assistance, all will be lost.',15,0,100,0,0,0, 'WHISPER_CUSTODIAN_9'),
(20129,9,0, 'We have very little information on this timeway. Sa''at has been dispatched and is currently inside. The data we have gathered from his correspondence is that the Infinite Dragonflight are once again attempting to alter time. Could it be that the opening of the Dark Portal is being targeted for sabotage? Let us hope not...',15,0,100,0,0,0, 'WHISPER_CUSTODIAN_10'),
(20129,10,0, 'This timeway collapsed and reformed. The result was Stratholme of yore. What could possibly be happening inside?',15,0,100,0,0,0, 'WHISPER_CUSTODIAN_11'),
(20129,11,0, 'The timeways are currently ranked in order from least catastrophic to most catastrophic. Note that they are all classified as catastrophic, meaning that any single one of these timeways collapsing would mean that your world would end. We only classify them in such a way so that the heroes and adventurers that are sent here know which timeway best suits their abilities.',15,0,100,0,0,0, 'WHISPER_CUSTODIAN_12'),
(20129,12,0, 'All we know of this timeway is that it leads to Mount Hyjal. The Infinite Dragonflight have gone to great lengths to prevent our involvement. We know next to nothing, mortal. Soridormi is currently attempting to break through the timeway''s defenses but has thus far been unsuccessful. You might be our only hope of breaking through and resolving the conflict.',15,0,100,0,0,0, 'WHISPER_CUSTODIAN_13'),
(20129,13,0, 'Our time is at an end $N. I would wish you luck, if such a thing existed.',15,0,100,0,0,0, 'WHISPER_CUSTODIAN_14');
 
 
/* 
* updates\world\2012_09_28_00_world_creature_model_info.sql 
*/ 
UPDATE `creature_model_info` SET `combat_reach`=10 WHERE `modelid`=28787;
 
 
/* 
* updates\world\2012_09_29_00_world_creature_model_info.sql 
*/ 
-- VoA
UPDATE `creature_model_info` SET `bounding_radius`=0.3875,`combat_reach`=7.5 WHERE `modelid`=29524; -- Koralon
UPDATE `creature_model_info` SET `bounding_radius`=0.465,`combat_reach`=7.5 WHERE `modelid`=27108; -- Emalon
UPDATE `creature_model_info` SET `bounding_radius`=0.465,`combat_reach`=9 WHERE `modelid`=31089; -- Toravon
UPDATE `creature_model_info` SET `bounding_radius`=0.465,`combat_reach`=7.5 WHERE `modelid`=26967; -- Archavon

-- ToCr
UPDATE `creature_model_info` SET `bounding_radius`=1.085,`combat_reach`=10.5 WHERE `modelid`=29614; -- Gormok
UPDATE `creature_model_info` SET `bounding_radius`=1.55,`combat_reach`=5 WHERE `modelid`=29815; -- Acidmaw
UPDATE `creature_model_info` SET `bounding_radius`=1.24,`combat_reach`=12 WHERE `modelid`=24564; -- Dreadscale
UPDATE `creature_model_info` SET `bounding_radius`=4,`combat_reach`=14 WHERE `modelid`=21601; -- Icehowl
UPDATE `creature_model_info` SET `bounding_radius`=1.52778,`combat_reach`=5 WHERE `modelid`=29615; -- Jaraxxus
UPDATE `creature_model_info` SET `bounding_radius`=1.5,`combat_reach`=9 WHERE `modelid`=29267; -- Eydis Darkbane
UPDATE `creature_model_info` SET `bounding_radius`=1.5,`combat_reach`=9 WHERE `modelid`=29240; -- Fjola Lightbane
UPDATE `creature_model_info` SET `bounding_radius`=1.5,`combat_reach`=2.25 WHERE `modelid`=29773; -- Saamul
UPDATE `creature_model_info` SET `bounding_radius`=0.459,`combat_reach`=2.25 WHERE `modelid`=29774; -- Baelnor Lightbearer
UPDATE `creature_model_info` SET `bounding_radius`=0.312,`combat_reach`=2.25 WHERE `modelid`=29776; -- Irieth Shadowstep
UPDATE `creature_model_info` SET `bounding_radius`=0.52785,`combat_reach`=2.5875 WHERE `modelid`=29777; -- Serissa Grimdabbler
UPDATE `creature_model_info` SET `bounding_radius`=0.312,`combat_reach`=2.25 WHERE `modelid`=29778; -- Brienna Nightfell
UPDATE `creature_model_info` SET `bounding_radius`=1.5,`combat_reach`=2.25 WHERE `modelid`=29779; -- Shocuul
UPDATE `creature_model_info` SET `bounding_radius`=0.4511,`combat_reach`=2.6 WHERE `modelid`=29780; -- Melador Valestrider / Erin Misthoof
 
 
/* 
* updates\world\2012_09_29_01_world_creature_text.sql 
*/ 
-- Mimiron
DELETE FROM `script_texts` WHERE `entry` BETWEEN -1603259 AND -1603240;
DELETE FROM `creature_text` WHERE `entry`=33350;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(33350,0,0, 'Oh, my! I wasn''t expecting company! The workshop is such a mess! How embarrassing!',14,0,100,0,0,15611, 'Mimiron SAY_AGGRO'),
(33350,1,0, 'Now why would you go and do something like that? Didn''t you see the sign that said ''DO NOT PUSH THIS BUTTON!''? How will we finish testing with the self-destruct mechanism active?',14,0,100,0,0,15629, 'Mimiron SAY_HARDMODE_ON'),
(33350,2,0, 'We haven''t much time, friends! You''re going to help me test out my latest and greatest creation. Now, before you change your minds, remember, that you kind of owe it to me after the mess you made with the XT-002.',14,0,100,0,0,15612, 'Mimiron SAY_MKII_ACTIVATE'),
(33350,3,0, 'MEDIC!',14,0,100,0,0,15613, 'Mimiron SAY_MKII_SLAY_1'),
(33350,3,1, 'I can fix that... or, maybe not! Sheesh, what a mess...',14,0,100,0,0,15614, 'Mimiron SAY_MKII_SLAY_2'),
(33350,4,0, 'WONDERFUL! Positively marvelous results! Hull integrity at 98.9 percent! Barely a dent! Moving right along.',14,0,100,0,0,15615, 'Mimiron SAY_MKII_DEATH'),
(33350,5,0, 'Behold the VX-001 Anti-personnel Assault Cannon! You might want to take cover.',14,0,100,0,0,15616, 'Mimiron SAY_VX001_ACTIVATE'),
(33350,6,0, 'Fascinating. I think they call that a "clean kill".',14,0,100,0,0,15617, 'Mimiron SAY_VX001_SLAY_1'),
(33350,6,1, 'Note to self: Cannon highly effective against flesh.',14,0,100,0,0,15618, 'Mimiron SAY_VX001_SLAY_2'),
(33350,7,0, 'Thank you, friends! Your efforts have yielded some fantastic data! Now, where did I put- oh, there it is!',14,0,100,0,0,15619, 'Mimiron SAY_VX001_DEATH'),
(33350,8,0, 'Isn''t it beautiful? I call it the magnificent aerial command unit!',14,0,100,0,0,15620, 'Mimiron SAY_AERIAL_ACTIVATE'),
(33350,9,0, 'Outplayed!',14,0,100,0,0,15621, 'Mimiron SAY_AERIAL_SLAY_1'),
(33350,9,1, 'You can do better than that!',14,0,100,0,0,15622, 'Mimiron SAY_AERIAL_SLAY_2'),
(33350,10,0, 'Preliminary testing phase complete. Now comes the true test!!',14,0,100,0,0,15623, 'Mimiron SAY_AERIAL_DEATH'),
(33350,11,0, 'Gaze upon its magnificence! Bask in its glorious, um, glory! I present you... V-07-TR-0N!',14,0,100,0,0,15624, 'Mimiron SAY_V07TRON_ACTIVATE'),
(33350,12,0, 'Prognosis: Negative!',14,0,100,0,0,15625, 'Mimiron SAY_V07TRON_SLAY_1'),
(33350,12,1, 'You''re not going to get up from that one, friend.',14,0,100,0,0,15626, 'Mimiron SAY_V07TRON_SLAY_2'),
(33350,13,0, 'It would appear that I''ve made a slight miscalculation. I allowed my mind to be corrupted by the fiend in the prison, overriding my primary directive. All systems seem to be functional now. Clear.',14,0,100,0,0,15627, 'Mimiron SAY_V07TRON_DEATH'),
(33350,14,0, 'Oh, my! It would seem that we are out of time, my friends!',14,0,100,0,0,15628, 'Mimiron SAY_BERSERK'),
(33350,15,0, 'Combat matrix enhanced. Behold wonderous rapidity!',14,0,100,0,0,15630, 'Mimiron SAY_YS_HELP');
 
 
/* 
* updates\world\2012_09_30_00_world_creature_text.sql 
*/ 
-- AzjolNerub/Ahnkahet/Elder Nadox
DELETE FROM `script_texts` WHERE `entry` BETWEEN -1619020 AND -1619014;
DELETE FROM `creature_text` WHERE `entry`=29309;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(29309,0,0, 'The secrets of the deep shall remain hidden.',14,0,100,0,0,14033, 'SAY_AGGRO'),
(29309,1,0, 'Sleep now, in the cold dark.',14,0,100,0,0,14036, 'SAY_SLAY_1'),
(29309,1,1, 'For the Lich King!',14,0,100,0,0,14037, 'SAY_SLAY_2'),
(29309,1,2, 'Perhaps we will be allies soon.',14,0,100,0,0,14038, 'SAY_SLAY_3'),
(29309,2,0, 'Master, is my service complete?',14,0,100,0,0,14039, 'SAY_DEATH'),
(29309,3,0, 'The young must not grow hungry...',14,0,100,0,0,14034, 'SAY_EGG_SAC_1'),
(29309,3,1, 'Shhhad ak kereeesshh chak-k-k!',14,0,100,0,0,14035, 'SAY_EGG_SAC_2'),
(29309,4,0, 'An Ahn''kahar Guardian hatches!',16,0,100,0,0,14035, 'EMOTE_HATCHES');
 
 
/* 
* updates\world\2012_09_30_01_world_player_factionchange_titles.sql 
*/ 
-- Title converter
DROP TABLE IF EXISTS `player_factionchange_titles`;
CREATE TABLE `player_factionchange_titles` (
 `alliance_id` int(8) NOT NULL,
 `horde_id` int(8) NOT NULL,
 PRIMARY KEY (`alliance_id`,`horde_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DELETE FROM `player_factionchange_titles` WHERE `alliance_id` IN (1,2,3,4,5,6,7,8,9,10,11,12,13,14,48,75,113,126,146,147,148,149);
INSERT INTO `player_factionchange_titles` (`alliance_id`,`horde_id`) VALUES
(1, 15),
(2, 16),
(3, 17),
(4, 18),
(5, 19),
(6, 20),
(7, 21),
(8, 22),
(9, 23),
(10, 24),
(11, 25),
(12, 26),
(13, 27),
(14, 28),
(48, 47),
(75, 76),
(113, 153),
(126, 127),
(146, 152),
(147, 154),
(148, 151),
(149, 150);
 
 
/* 
* updates\world\2012_09_30_02_world_creature_text.sql 
*/ 
-- AzjolNerub/Ahnkahet/Herald Volazj
DELETE FROM `script_texts` WHERE `entry` BETWEEN -1619036 AND -1619030;
DELETE FROM `creature_text` WHERE `entry`=29311;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(29311,0,0, 'Shgla''yos plahf mh''naus.', 14,0,100,0,0,14043, 'SAY_AGGRO_1'),
(29311,0,1, 'They who dine on lost souls know only hunger.', 15, 0, 100, 0, 0, 14043, 'SAY_AGGRO_2'),
(29311,1,0, 'Ywaq puul skshgn: on''ma yeh''glu zuq.', 14,0,100,0,0,14045, 'SAY_SLAY_1'),
(29311,1,1, 'Ywaq ma phgwa''cul hnakf.',14,0,100,0,0,14046, 'SAY_SLAY_2'),
(29311,1,2, 'Ywaq maq oou; ywaq maq ssaggh. Ywaq ma shg''fhn.',14,0,100,0,0,14047, 'SAY_SLAY_3'),
(29311,2,0, 'Iilth vwah, uhn''agth fhssh za.', 14, 0, 100, 0, 0, 14048, 'SAY_DEATH_1'),
(29311,2,1, 'Where one falls, many shall take its place.', 15, 0, 100, 0, 0, 14048, 'SAY_DEATH_2'),
(29311,3,0, 'Gul''kafh an''shel. Yoq''al shn ky ywaq nuul.', 14, 0, 100, 0, 0, 14044, 'SAY_PHASE'); 
 
/* 
* updates\world\2012_09_30_03_world_creature_text.sql 
*/ 
-- AzjolNerub/Ahnkahet/Jedoga Shadowseeker
DELETE FROM `script_texts` WHERE `entry` BETWEEN -1619013 AND -1619000;
DELETE FROM `creature_text` WHERE `entry`=29310;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(29310, 0, 0, 'These are sacred halls! Your intrusion will be met with death!', 14, 0, 100, 0, 0, 14343, 'SAY_AGGRO'),
(29310, 1, 0, 'Who among you is devoted?', 14, 0, 100, 0, 0, 14343, 'SAY_SACRIFICE_1_1'),
(29310, 1, 1, 'You there! Step forward!', 14, 0, 100, 0, 0, 14343, 'SAY_SACRIFICE_1_2'),
(29310, 2, 0, 'Yogg-Saron, grant me your power!', 14, 0, 100, 0, 0, 14343, 'SAY_SACRIFICE_2_1'),
(29310, 2, 1, 'Master, a gift for you!', 14, 0, 100, 0, 0, 14343, 'SAY_SACRIFICE_2_2'),
(29310, 3, 0, 'Glory to Yogg-Saron!', 14, 0, 100, 0, 0, 0, 'SAY_SLAY_1'),
(29310, 3, 1, 'You are unworthy!', 14, 0, 100, 0, 0, 0, 'SAY_SLAY_2'),
(29310, 3, 2, 'Get up! You haven''t suffered enough.', 14, 0, 100, 0, 0, 14350, 'SAY_SLAY_3'),
(29310, 4, 0, 'Do not expect your sacrilege... to go unpunished.', 14, 0, 100, 0, 0, 0, 'SAY_DEATH'),
(29310, 5, 0, 'The elements themselves will rise up against the civilized world! Only the faithful will be spared!', 14, 0, 100, 0, 0, 14352, 'SAY_PREACHING_1'),
(29310, 5, 1, 'Immortality can be yours, but only if you pledge yourself fully to Yogg-Saron!', 14, 0, 100, 0, 0, 14353, 'SAY_PREACHING_2'),
(29310, 5, 2, 'Here, on the very borders of his domain, you will experience power you could have never imagined!', 14, 0, 100, 0, 0, 0, 'SAY_PREACHING_3'),
(29310, 5, 3, 'You have traveled long and risked much to be here! Your devotion shall be rewarded.', 14, 0, 100, 0, 0, 0, 'SAY_PREACHING_4'),
(29310, 5, 4, 'The faithful shall be exalted! But there is more work to be done. We will press on until all of Azeroth lies beneath his shadow!', 14, 0, 100, 0, 0, 0, 'SAY_PREACHING_5');
 
 
/* 
* updates\world\2012_10_02_00_world_oculus.sql 
*/ 
-- Addon data based on sniff fixed by Vincent-Michael
DELETE FROM `creature_template_addon` WHERE `entry` IN (27692,27755,27756);
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES 
(27692,0,0,0x3000000,0x1,0,'50296 50325'), -- Emerald Drake
(27755,0,0,0x3000000,0x1,0,'50296 50325'), -- Amber Drake
(27756,0,0,0x3000000,0x1,0,'50296 50248 50325'); -- Ruby Drake // Evasive aura should be here from the start
-- Change InhabitType to prevent drakes falling on summon
UPDATE `creature_template` SET `InhabitType`=4 WHERE `entry` IN (27692,27755,27756);
-- Change script name for gossip npcs and drakes and set npc_flag to 0, since only after Ist boss is dead, they should acquire gossip flag
UPDATE `creature_template` SET `npcflag`=2,`ScriptName`='npc_verdisa_beglaristrasz_eternos' WHERE `entry` IN (27657,27658,27659);
UPDATE `creature_template` SET `spell2`=50240,`spell3`=50253,`spell4`=0  WHERE `entry`=27756; -- Remove Evasive Aura and set Evasive Manouvres since it is an aura always applied, also set Martyr as 3rd
UPDATE `creature_template` SET `spell6`=53389,`ScriptName`='npc_ruby_emerald_amber_drake' WHERE `entry` IN (27692,27755,27756); -- Add GPS spell for all drakes and script names for drakes
-- Add spell_script name for Call Ruby/Emerald/Amber Drake spells
DELETE FROM `spell_script_names` WHERE `spell_id` IN (49462,49345,49461);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(49462,'spell_call_ruby_emerald_amber_drake'), -- Ruby
(49345,'spell_call_ruby_emerald_amber_drake'), -- Emerald
(49461,'spell_call_ruby_emerald_amber_drake'); -- Amber
-- Remove wrong use of npc_spellclick_spell, the drake should auto do all on summon
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` IN (27692,27755,27756);
-- Add conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (49464,49346,49460,66667,49838);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry` IN (49840,49592,50328,50341,50232);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1|4,49464,0,0,33,0,1,5,0,0,0,'','Ruby Drake Saddle control vehicle aura can hit only created unit'),
(13,1|4,49346,0,0,33,0,1,5,0,0,0,'','Emerald Drake Saddle control vehicle aura can hit only created unit'),
(13,1|4,49460,0,0,33,0,1,5,0,0,0,'','Amber Drake Saddle control vehicle aura can hit only created unit'),
(13,1|2|4,66667,0,0,33,1,0,0,0,0,0,'','Gear scaling for Oculus drakes can only be casted on self'),
(17,0,49840,0,1,31,1,3,28236,0,0,0,'','Shock Lance target can be Azure Ring Captain'),
(17,0,49840,0,2,31,1,3,27638,0,0,0,'','Shock Lance target can be Azure Ring Guardian'),
(17,0,49840,0,3,31,1,3,28276,0,0,0,'','Shock Lance target can be Greater Lay Whelp'),
(17,0,49840,0,4,31,1,3,27656,0,0,0,'','Shock Lance target can be Eregos'),
(13,1,49838,0,1,31,0,3,28236,0,0,0,'','Stop Time can hit Azure Ring Captain'),
(13,1,49838,0,2,31,0,3,27638,0,0,0,'','Stop Time can hit Azure Ring Guardian'),
(13,1,49838,0,3,31,0,3,28276,0,0,0,'','Stop Time can hit Greater Lay Whelp'),
(13,1,49838,0,4,31,0,3,27656,0,0,0,'','Stop Time can hit Eregos'),
(17,0,49592,0,1,31,1,3,28236,0,0,0,'','Temporal Rift target can be Azure Ring Captain'),
(17,0,49592,0,2,31,1,3,27638,0,0,0,'','Temporal Rift target can be Azure Ring Guardian'),
(17,0,49592,0,3,31,1,3,28276,0,0,0,'','Temporal Rift target can be Greater Lay Whelp'),
(17,0,49592,0,4,31,1,3,27656,0,0,0,'','Temporal Rift target can be Eregos'),
(17,0,50328,0,1,31,1,3,28236,0,0,0,'','Leeching Poison target can be Azure Ring Captain'),
(17,0,50328,0,2,31,1,3,27638,0,0,0,'','Leeching Poison target can be Azure Ring Guardian'),
(17,0,50328,0,3,31,1,3,28276,0,0,0,'','Leeching Poison target can be Greater Lay Whelp'),
(17,0,50328,0,4,31,1,3,27656,0,0,0,'','Leeching Poison target can be Eregos'),
(17,0,50341,0,1,31,1,3,28236,0,0,0,'','Touch the Nightmare target can be Azure Ring Captain'),
(17,0,50341,0,2,31,1,3,27638,0,0,0,'','Touch the Nightmare target can be Azure Ring Guardian'),
(17,0,50341,0,3,31,1,3,28276,0,0,0,'','Touch the Nightmare target can be Greater Lay Whelp'),
(17,0,50341,0,4,31,1,3,27656,0,0,0,'','Touch the Nightmare target can be Eregos'),
(17,0,50232,0,1,31,1,3,28236,0,0,0,'','Searing Wrath target can be Azure Ring Captain'),
(17,0,50232,0,2,31,1,3,27638,0,0,0,'','Searing Wrath target can be Azure Ring Guardian'),
(17,0,50232,0,3,31,1,3,28276,0,0,0,'','Searing Wrath target can be Greater Lay Whelp'),
(17,0,50232,0,4,31,1,3,27656,0,0,0,'','Searing Wrath target can be Eregos');
-- Add text for Belgaristrasz
SET @Belgaristrasz := 27658;
DELETE FROM `creature_text` WHERE `entry`=@Belgaristrasz;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@Belgaristrasz,0,0,'Thank you for freeing us, mortals. Beware, the blue flight is alerted to your presence. Even now, Malygos sends Varos Cloudstrider and his ring guardians to defend the Oculus. You will need our help to stand a chance.',12,0,100,1,3500,0,'Belgaristrasz - On freed');
-- Add text for Ruby, Amber and Emerald drakes
SET @Ruby :=    27756;
SET @Emerald := 27692;
SET @Amber :=   27755;
DELETE FROM `creature_text` WHERE `entry` IN (@Ruby,@Emerald,@Amber);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@Ruby,0,0,'Ruby Drake flies away.',16,0,100,1,0,2858,'Ruby - On take off'),
(@Ruby,1,0,'Welcome Friend. Keep your head down and hold on tight!',15,0,100,1,0,0,'Ruby - On welcome'),
(@Ruby,2,0,'Use Searing Wrath to damage enemies and Evasive Maneuvers if I start taking damage. Remember I need to build up Evasive Charges by taking damage to perform Evasive Maneuvers!',15,0,100,1,0,0,'Ruby - On explaining abilities'),
(@Ruby,3,0,'Now that I am at my full power I can perform Martyr. You can use it to protect other drakes, but I will take lots of damage, so make sure you''re using Evasive Maneuvers too!',15,0,100,1,0,0,'Ruby - On ultimate ability unlocked'),
(@Ruby,4,0,'I''m badly injured! I can''t take much more of this!',15,0,100,1,0,0,'Ruby - On below 40%'),
(@Emerald,0,0,'Emerald Drake flies away.',16,0,100,1,0,2858,'Emerald - On take off'),
(@Emerald,1,0,'Welcome Friend. Keep your head down and hold on tight!',15,0,100,1,0,0,'Emerald - On welcome'),
(@Emerald,2,0,'Use Leeching Poison to damage enemies and keep me healed. Touch the Nightmare is very powerful, but it hurts me, so only use it when I have a lot of health!',15,0,100,1,0,0,'Emerald - On explaining abilities'),
(@Emerald,3,0,'Now that I am at my full power I can perform Dream Funnel. You can use it to heal other drakes, but it drains my health, so make sure you''re using Leeching Poison too!',15,0,100,1,0,0,'Emerald - On ultimate ability unlocked'),
(@Emerald,4,0,'I''m badly injured! I can''t take much more of this!',15,0,100,1,0,0,'Emerald - On below 40%'),
(@Amber,0,0,'Amber Drake flies away.',16,0,100,1,0,2858,'Amber - On take off'),
(@Amber,1,0,'Welcome Friend. Keep your head down and hold on tight!',15,0,100,1,0,0,'Amber - On welcome'),
(@Amber,2,0,'Use Shock Lance to damage enemies. If we get in trouble, Stop Time to freeze all enemies in place, then hit them with Shock Lance for massive damage!',15,0,100,1,0,0,'Amber - On explaining abilities'),
(@Amber,3,0,'Now that I am at my full power I can perform Temporal Rift. You can use it to make enemies take extra damage and to get Shock Charges. Save up Shock Charges and then Shock Lance for huge damage!',15,0,100,1,0,0,'Amber - On ultimate ability unlocked'),
(@Amber,4,0,'I''m badly injured! I can''t take much more of this!',15,0,100,1,0,0,'Amber - On below 40%');
-- Fix Oculus phasing db side, all listed get changed only on specific isntance data
UPDATE `creature` SET `phaseMask`=2 WHERE `id` IN (27447,27655,28276,27656);
 
 
/* 
* updates\world\2012_10_04_00_world_spelldifficulty_dbc.sql 
*/ 
-- Boss Anubarak Move Heroic Spell in spelldifficulty
DELETE FROM `spelldifficulty_dbc` WHERE `id` IN (53472,53454);
INSERT INTO `spelldifficulty_dbc`(`id`,`spellid0`,`spellid1`) VALUES
(53472,53472,59433), -- Spell Pound 
(53454,53454,59446); -- Spell Impale Damage
 
 
/* 
* updates\world\2012_10_04_01_world_script_texts.sql 
*/ 
DELETE FROM `script_texts` WHERE `entry` BETWEEN -1000649 AND -1000641;
INSERT INTO `script_texts` (`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(4979,-1000641,'Hey, thanks.','NULL','NULL','NULL','NULL','NULL','NULL','NULL','NULL',0,0,0,0, 'Theramore Guard - SAY_QUEST1'),
(4979,-1000642,'...receive 50 percent off deserter undergarments? What is this garbage?','NULL','NULL','NULL','NULL','NULL','NULL','NULL','NULL',0,0,0,0,'Theramore Guard - SAY_QUEST2'),
(4979,-1000643,'...to establish a fund for the purchase of hair gel? I like my hair the way it is, thanks!','NULL','NULL','NULL','NULL','NULL','NULL','NULL','NULL',0,0,0,0,'Theramore Guard - SAY_QUEST3'),
(4979,-1000644,'...the deserters seek a Theramore where citizens will be free to juggle at all hours of the day? What is this nonsense?','NULL','NULL','NULL','NULL','NULL','NULL','NULL','NULL',0,0,0,0,'Theramore Guard - SAY_QUEST4'),
(4979,-1000645,'...to establish the chicken as the official symbol of Theramore?! These guys are nuts!','NULL','NULL','NULL','NULL','NULL','NULL','NULL','NULL',0,0,0,0,'Theramore Guard - SAY_QUEST5'),
(4979,-1000646,"...as a deserter, you'll enjoy activities like tethered swimming and dog grooming? How ridiculous!",'NULL','NULL','NULL','NULL','NULL','NULL','NULL','NULL',0,0,0,0,'Theramore Guard - SAY_QUEST6'),
(4979,-1000647,'This... this is a joke, right?','NULL','NULL','NULL','NULL','NULL','NULL','NULL','NULL',0,0,0,0,'Theramore Guard - SAY_QUEST7'),
(4979,-1000648,"I'd never join anything like this. Better keep this, though. It'll come in handy in the privy...",'NULL','NULL','NULL','NULL','NULL','NULL','NULL','NULL',0,0,0,0,'Theramore Guard - SAY_QUEST8'),
(4979,-1000649,'What a bunch of lunatics! You actually believe this stuff?','NULL','NULL','NULL','NULL','NULL','NULL','NULL','NULL',0,0,0,0,'Theramore Guard - SAY_QUEST9');
 
 
/* 
* updates\world\2012_10_05_00_world_misc.sql 
*/ 
/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/* Table structure for table `lfg_entrance` */

DROP TABLE IF EXISTS `lfg_entrances`;

CREATE TABLE `lfg_entrances` (
  `dungeonId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Unique id from LFGDungeons.dbc',
  `name` varchar(255) DEFAULT NULL,
  `position_x` float NOT NULL DEFAULT '0',
  `position_y` float NOT NULL DEFAULT '0',
  `position_z` float NOT NULL DEFAULT '0',
  `orientation` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`dungeonId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;


-- only The Frost Lord Ahune and The Crown Chemical Co. were taken from sniffs, others from areatrigger_teleport or guessed
-- TODO: replace them by sniffed positions and probably use this table for all dungeons instead of areatrigger_teleport
-- note: this table should be used more in Cataclysm and Mists of Pandaria (there will be all events like Zalazane's Fall and scenarios)
DELETE FROM `lfg_entrances`;
INSERT INTO `lfg_entrances` (`dungeonId`,`name`,`position_x`,`position_y`,`position_z`,`orientation`) VALUES
(18,'Scarlet Monastery - Graveyard',1688.99,1053.48,18.6775,0.00117),
(26,'Maraudon - Orange Crystals',1019.69,-458.31,-43.43,0.31),
(34,'Dire Maul - East',44.4499,-154.822,-2.71201,0),
(36,'Dire Maul - West',-62.9658,159.867,-3.46206,3.14788),
(38,'Dire Maul - North',255.249,-16.0561,-2.58737,4.7),
(40,'Stratholme - Main Gate',3395.09,-3380.25,142.702,0.1),
(163,'Scarlet Monastery - Armory',1610.83,-323.433,18.6738,6.28022),
(164,'Scarlet Monastery - Cathedral',855.683,1321.5,18.6709,0.001747),
(165,'Scarlet Monastery - Library',255.346,-209.09,18.6773,6.26656),
(272,'Maraudon - Purple Crystals',752.91,-616.53,-33.11,1.37),
(273,'Maraudon - Pristine Waters',495.701904,17.337202,-96.31284,3.118538), -- guessed
(274,'Stratholme - Service Entrance',3593.15,-3646.56,138.5,5.33),
(285,'The Headless Horseman',1797.517212,1347.381104,18.8876,3.142), -- guessed
(286,'The Frost Lord Ahune',-100.396,-95.9996,-4.28423,4.712389),
(287,'Coren Direbrew',897.494995,-141.976349,-49.7563,2.125502), -- guessed
(288,'The Crown Chemical Co.',-238.075,2166.43,88.853,1.134464);

DELETE FROM `lfg_dungeon_rewards` WHERE `dungeonId` BETWEEN 285 AND 288;
INSERT INTO `lfg_dungeon_rewards` (`dungeonId`,`maxLevel`,`firstQuestId`,`firstMoneyVar`,`firstXPVar`,`otherQuestId`,`otherMoneyVar`,`otherXPVar`) VALUES
(285,80,25482,0,0,0,0,0),
(286,80,25484,0,0,0,0,0),
(287,80,25483,0,0,0,0,0),
(288,80,25485,0,0,0,0,0);

UPDATE `quest_template` SET `SpecialFlags`=`SpecialFlags`|8|1 WHERE `Id` IN (25482,25483,25484,25485);
 
 
/* 
* updates\world\2012_10_05_01_world_spell_script_names.sql 
*/ 
DELETE FROM `spell_script_names` WHERE `spell_id` = 54643;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(54643, 'spell_wintergrasp_defender_teleport_trigger');
 
 
/* 
* updates\world\2012_10_06_00_world_spell_difficulty.sql 
*/ 
-- Boss Elder Nadox Move Heroic Spell in spelldifficulty
DELETE FROM `spelldifficulty_dbc` WHERE `id` =56130;
INSERT INTO `spelldifficulty_dbc`(`id`,`spellid0`,`spellid1`) VALUES
(56130,56130,59467); -- Brood Plague
 
 
/* 
* updates\world\2012_10_06_00_world_spell_script_names.sql 
*/ 
DELETE FROM `spell_script_names` WHERE `spell_id` IN (74562,74567,74610,74641,74792,74795,74800,74805,74807,74808,74812,75396,74769,77844,77845,77846);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(74562, 'spell_halion_fiery_combustion'),
(74567, 'spell_halion_mark_of_combustion'),
(74610, 'spell_halion_damage_aoe_summon'),
(74641, 'spell_halion_meteor_strike_marker'),
(74792, 'spell_halion_soul_consumption'),
(74795, 'spell_halion_mark_of_consumption'),
(74800, 'spell_halion_damage_aoe_summon'),
(74805, 'spell_halion_summon_exit_portals'),
(74807, 'spell_halion_enter_twilight_realm'),
(74808, 'spell_halion_twilight_phasing'),
(74812, 'spell_halion_leave_twilight_realm'),
(75396, 'spell_halion_clear_debuffs'),
(74769, 'spell_halion_twilight_cutter'),
(77844, 'spell_halion_twilight_cutter'),
(77845, 'spell_halion_twilight_cutter'),
(77846, 'spell_halion_twilight_cutter');
 
 
/* 
* updates\world\2012_10_06_01_world_spell_dbc.sql 
*/ 
DELETE FROM `spell_dbc` WHERE  `Id` IN (70507, 74810, 74805);
INSERT INTO `spell_dbc` (`Id`, `Dispel`, `Mechanic`, `Attributes`, `AttributesEx`, `AttributesEx2`, `AttributesEx3`, `AttributesEx4`, `AttributesEx5`, `AttributesEx6`, `AttributesEx7`, `Stances`, `StancesNot`, `Targets`, `CastingTimeIndex`, `AuraInterruptFlags`, `ProcFlags`, `ProcChance`, `ProcCharges`, `MaxLevel`, `BaseLevel`, `SpellLevel`, `DurationIndex`, `RangeIndex`, `StackAmount`, `EquippedItemClass`, `EquippedItemSubClassMask`, `EquippedItemInventoryTypeMask`, `Effect1`, `Effect2`, `Effect3`, `EffectDieSides1`, `EffectDieSides2`, `EffectDieSides3`, `EffectRealPointsPerLevel1`, `EffectRealPointsPerLevel2`, `EffectRealPointsPerLevel3`, `EffectBasePoints1`, `EffectBasePoints2`, `EffectBasePoints3`, `EffectMechanic1`, `EffectMechanic2`, `EffectMechanic3`, `EffectImplicitTargetA1`, `EffectImplicitTargetA2`, `EffectImplicitTargetA3`, `EffectImplicitTargetB1`, `EffectImplicitTargetB2`, `EffectImplicitTargetB3`, `EffectRadiusIndex1`, `EffectRadiusIndex2`, `EffectRadiusIndex3`, `EffectApplyAuraName1`, `EffectApplyAuraName2`, `EffectApplyAuraName3`, `EffectAmplitude1`, `EffectAmplitude2`, `EffectAmplitude3`, `EffectMultipleValue1`, `EffectMultipleValue2`, `EffectMultipleValue3`, `EffectMiscValue1`, `EffectMiscValue2`, `EffectMiscValue3`, `EffectMiscValueB1`, `EffectMiscValueB2`, `EffectMiscValueB3`, `EffectTriggerSpell1`, `EffectTriggerSpell2`, `EffectTriggerSpell3`, `EffectSpellClassMaskA1`, `EffectSpellClassMaskA2`, `EffectSpellClassMaskA3`, `EffectSpellClassMaskB1`, `EffectSpellClassMaskB2`, `EffectSpellClassMaskB3`, `EffectSpellClassMaskC1`, `EffectSpellClassMaskC2`, `EffectSpellClassMaskC3`, `MaxTargetLevel`, `SpellFamilyName`, `SpellFamilyFlags1`, `SpellFamilyFlags2`, `SpellFamilyFlags3`, `MaxAffectedTargets`, `DmgClass`, `PreventionType`, `DmgMultiplier1`, `DmgMultiplier2`, `DmgMultiplier3`, `AreaGroupId`, `SchoolMask`, `Comment`) VALUES
(70507, 0, 0, 256, 1024, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 101, 0, 0, 0, 0, 21, 1, 99, -1, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 61, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, "Halion - Combustion & Consumption Scale Aura"),
(74805, 0, 0, 0, 0, 0, 262144, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, -1, 0, 0, 76, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 202796, 202796, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "Halion - Summon Twilight Portals"),
(74810, 0, 0, 256, 268435456, 4, 0, 0, 0, 16785408, 0, 0, 0, 0, 1, 0, 0, 101, 0, 0, 0, 0, 21, 13, 0, -1, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 25, 0, 0, 0, 0, 0, 22, 0, 0, 300, 0, 0, 0, 0, 0, 1, 0, 0, 127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,'Halion - Copy Damage');
 
 
/* 
* updates\world\2012_10_06_02_world_misc_templates.sql 
*/ 
-- Twilight Portals
UPDATE `gameobject_template` SET `flags`=32, `faction`=35, `ScriptName`="go_twilight_portal" WHERE `entry` IN (202794, 202796);

UPDATE `creature_template` SET `mindmg`=509,`maxdmg`=683,`attackpower`=805,`dmg_multiplier`=35,`faction_A`=14,`faction_H`=14,`exp`=2 WHERE `entry` IN (39863, 39864, 39944, 39945, 40142); -- Halion
UPDATE `creature_template` SET `ScriptName`= 'boss_halion',`flags_extra`=`flags_extra`|0x1 WHERE `entry`=39863; -- Halion
UPDATE `creature_template` SET `mindmg`=422,`maxdmg`=586,`attackpower`=642,`dmg_multiplier`=7.5 WHERE `entry` IN (40417, 40418, 40419, 40420, 40421, 40422, 40423, 40424); -- Trashs

-- Trahs respawn time
UPDATE `creature` SET `spawntimesecs`=604800 WHERE `id` IN (39751, 39746, 39747);
UPDATE `creature` SET `spawntimesecs`=1209600 WHERE `map`=724 AND `id` NOT IN (39751,39746,39747);

UPDATE `creature_template` SET `flags_extra`=130 WHERE `entry` IN (40041, 40042, 40043, 40044); -- 40041, 40042, 40043 & 40044 - Meteor Strike
UPDATE `creature_template` SET `flags_extra`=130 WHERE `entry`=40029; -- 40029 - Meteor Strike (Initial)
UPDATE `creature_template` SET `flags_extra`=130 WHERE `entry`=40055; -- 40055 - Meteor Strike

UPDATE `creature_template` SET `faction_A`=14,`faction_H`=14,`exp`=2,`mindmg`=509,`maxdmg`=683,`attackpower`=805,`dmg_multiplier`=35 WHERE `entry`=40143; -- 40143 - Halion (1) - The Twilight Destroyer
UPDATE `creature_template` SET `faction_A`=14,`faction_H`=14,`exp`=2,`mindmg`=509,`maxdmg`=683,`attackpower`=805,`dmg_multiplier`=50 WHERE `entry`=40144; -- 40144 - Halion (2) - The Twilight Destroyer
UPDATE `creature_template` SET `faction_A`=14,`faction_H`=14,`exp`=2,`mindmg`=509,`maxdmg`=683,`attackpower`=805,`dmg_multiplier`=85 WHERE `entry`=40145; -- 40145 - Halion (3) - The Twilight Destroyer

-- Orb rotation focus
UPDATE `creature_template` SET `modelid1`=11686, `modelid2`=169, `scale`=1, `unit_flags`=0x2000100 WHERE `entry`=40091;

UPDATE `creature_template` SET `InhabitType`=7,`modelid1`=11686,`modelid2`=169,`VehicleId`=718,`unit_flags`=0x2000100 WHERE `entry`=40081; -- 40081 - Orb Carrier
UPDATE `creature_template` SET `InhabitType`=7,`modelid1`=11686,`modelid2`=169,`VehicleId`=718,`unit_flags`=0x2000100 WHERE `entry`=40470; -- 40470 - Orb Carrier (1)
UPDATE `creature_template` SET `InhabitType`=7,`modelid1`=11686,`modelid2`=169,`VehicleId`=746,`unit_flags`=0x2000100 WHERE `entry`=40471; -- 40471 - Orb Carrier (2)
UPDATE `creature_template` SET `InhabitType`=7,`modelid1`=11686,`modelid2`=169,`VehicleId`=746,`unit_flags`=0x2000100 WHERE `entry`=40472; -- 40472 - Orb Carrier (3)
UPDATE `creature_template` SET `scale`=1,`flags_extra`=130,`exp`=2,`baseattacktime`=2000,`unit_flags`=33554432 WHERE `entry` IN(40001, 40135); -- 40001 & 40135 - Combustion & Consumption

-- Shadow orbs
UPDATE `creature_template` SET `InhabitType`=7,`flags_extra`=2,`unit_flags`=33554432,`baseattacktime`=2000,`speed_walk`=2.4,`speed_run`=0.85714,`faction_A`=14,`faction_H`=14,`exp`=2,`maxlevel`=80,`minlevel`=80,`HoverHeight`=6.25, `ScriptName`= '' WHERE `entry` IN (40469, 40468, 40083, 40100);

UPDATE `creature_template` SET `speed_walk`=3.2,`speed_run`=1.71428573131561, `unit_flags`=0x40 WHERE `entry` IN (40683, 40681); -- Living Inferno & Living Ember

UPDATE `creature_template` SET `ScriptName`= 'boss_twilight_halion' WHERE `entry`=40142; -- Twilight Halion
UPDATE `creature_template` SET `ScriptName`= 'npc_orb_carrier' WHERE `entry`=40081; -- Orb carrier
UPDATE `creature_template` SET `ScriptName`= 'npc_combustion_consumption' WHERE `entry` IN(40001, 40135); -- Combustion & consumption
UPDATE `creature_template` SET `ScriptName`= 'npc_meteor_strike_initial' WHERE `entry`=40029;
UPDATE `creature_template` SET `ScriptName`= 'npc_meteor_strike' WHERE `entry` IN (40041, 40042, 40043, 40044);

UPDATE `creature_template` SET `speed_walk`=1.6,`speed_run`=1.42857146263123,`minlevel`=83,`maxlevel`=83,`faction_H`=14,`faction_A`=14,`unit_flags`=0x88840,`BaseAttackTime`=1800,`DynamicFlags`=0xC WHERE `entry`=40142; -- Twilight Halion
UPDATE `creature_template` SET `speed_walk`=1.6,`speed_run`=1.42857146263123,`minlevel`=83,`maxlevel`=83,`faction_H`=14,`faction_A`=14,`unit_flags`=0x8040,`BaseAttackTime`=1500 WHERE `entry`=39863; -- Material Halion
UPDATE `creature_template` SET `faction_H`=14,`faction_A`=14,`unit_flags`=0x2000000,`unit_class`=2 WHERE `entry`=40029; -- Meteor Strike
UPDATE `creature_template` SET `faction_H`=14,`faction_A`=14,`unit_flags`=0x2000000 WHERE `entry`=40001; -- Combustion
UPDATE `creature_template` SET `InhabitType`=0x4,`speed_walk`=1.2,`speed_run`=0.428571432828903,`VehicleId`=718,`minlevel`=80,`maxlevel`=80,`faction_H`=14,`faction_A`=14,`unit_flags`=0x2000100 WHERE `entry`=40081; -- Orb Carrier
UPDATE `creature_template` SET `speed_walk`=2.2,`speed_run`=0.785714268684387,`minlevel`=80,`maxlevel`=80,`faction_H`=14,`faction_A`=14,`unit_flags`=0x2000100 WHERE `entry`=40091; -- Orb Rotation Focus
UPDATE `creature_template` SET `flags_extra`=130,`ScriptName`= 'npc_halion_controller',`exp`=2,`speed_walk`=2.8,`speed_run`=1,`minlevel`=80,`maxlevel`=80,`faction_A`=14,`faction_H`=14,`unit_flags`=0x2000100 WHERE `entry`=40146; -- 40146 - Halion Controller

UPDATE `creature_template` SET `ScriptName`="npc_living_ember" WHERE `entry`=40683;
UPDATE `creature_template` SET `ScriptName`="npc_living_inferno" WHERE `entry`=40681;

UPDATE `creature_model_info` SET `bounding_radius`=1, `combat_reach`=2 WHERE `modelid`=16946;
UPDATE `creature_model_info` SET `combat_reach`=18 WHERE `modelid`=31952; -- Halion
UPDATE `creature_model_info` SET `combat_reach`=12.25 WHERE `modelid`=32179; -- General Zarithrian

-- Halion, Combustion, Consumption, Shadow Orb, Rotation Focus, Controller
DELETE FROM `creature_template_addon` WHERE `entry` IN (40142, 40146, 40001, 40135, 40100, 40469, 40468, 40083, 39863, 40091);
INSERT INTO `creature_template_addon` (`entry`, `mount`, `bytes1`, `bytes2`, `auras`) VALUES
(40142, 0, 0x0, 0x1, '75476'),
(40146, 0, 0x0, 0x1, ''),
(40001, 0, 0x0, 0x1, '74629'),
(40135, 0, 0x0, 0x1, '74803'),
(40469, 0, 0x2000000, 0x1, ''),
(40468, 0, 0x2000000, 0x1, ''),
(40083, 0, 0x2000000, 0x1, ''),
(40100, 0, 0x2000000, 0x1, ''),
(39863, 0, 0x0, 0x1, '78243'),
(40091, 0, 0x0, 0x1, '');

-- Vehicle accessory for Orb Carrier
DELETE FROM `vehicle_template_accessory` WHERE `entry` IN (40081,40470,40471,40472);
INSERT INTO `vehicle_template_accessory` (`entry`,`accessory_entry`,`seat_id`,`minion`,`description`,`summontype`,`summontimer`) VALUES
(40081,40083,0,1, 'Orb Carrier',6,30000),
(40081,40100,1,1, 'Orb Carrier',6,30000),

(40470,40083,0,1, 'Orb Carrier',6,30000),
(40470,40100,1,1, 'Orb Carrier',6,30000),

(40471,40083,0,1, 'Orb Carrier',6,30000),
(40471,40100,1,1, 'Orb Carrier',6,30000),
(40471,40468,2,1, 'Orb Carrier',6,30000),
(40471,40469,3,1, 'Orb Carrier',6,30000),

(40472,40083,0,1, 'Orb Carrier',6,30000),
(40472,40100,1,1, 'Orb Carrier',6,30000),
(40472,40468,2,1, 'Orb Carrier',6,30000),
(40472,40469,3,1, 'Orb Carrier',6,30000);

-- Vehicle spellclicks
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` IN (40081,40470,40471,40472);
INSERT INTO `npc_spellclick_spells` (`npc_entry`,`spell_id`,`cast_flags`,`user_type`) VALUES
(40081, 46598, 0, 1), -- Ride Vehicle Hardcoded
(40470, 46598, 0, 1),
(40471, 46598, 0, 1),
(40472, 46598, 0, 1);

-- Conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=74758;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=75509;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=75886;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13,1,75886,0,0,31,0,3,40683,0,0,0, "", "Blazing Aura can only target Living Embers"),
(13,1,75886,0,0,31,0,3,40684,0,0,0, "", "Blazing Aura can only target Living Embers"),
(13,1,75509,0,0,31,0,3,40142,0,0,0, "", "Twilight Mending can only target Halion"),
(13,2,75509,0,0,31,0,3,39863,0,0,0, "", "Twilight Mending can only target Halion"),
(13,1,74758,0,0,31,0,3,40091,0,0,0, "", "Track Rotation can only target Orb Rotation Focus");
 
 
/* 
* updates\world\2012_10_06_03_world_creature_text.sql 
*/ 
DELETE FROM `creature_text` WHERE `entry`=39863;
DELETE FROM `creature_text` WHERE `entry`=40142;
DELETE FROM `creature_text` WHERE `entry`=40146;
DELETE FROM `creature_text` WHERE `entry`=40083;
DELETE FROM `creature_text` WHERE `entry`=40146;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(39863,0,0, 'Without pressure in both realms, %s begins to regenerate.',41,0,100,0,0,0, 'Halion'),
(39863,1,0, 'Meddlesome insects! You are too late. The Ruby Sanctum is lost!',14,0,100,1,0,17499, 'Halion'),
(39863,2,0, 'Your world teeters on the brink of annihilation. You will ALL bear witness to the coming of a new age of DESTRUCTION!',14,0,100,0,0,17500, 'Halion'),
(39863,3,0, 'The heavens burn!',14,0,100,0,0,17505, 'Halion'),
(39863,4,0, 'You will find only suffering within the realm of twilight! Enter if you dare!',14,0,100,0,0,17507, 'Halion'),
(39863,5,0, 'Relish this victory, mortals, for it will be your last! This world will burn with the master''s return!',14,0,100,0,0,17503, 'Halion'),
(39863,6,0, 'Another "hero" falls.',14,0,100,0,0,17501, 'Halion'),
(39863,7,0, 'Not good enough.',14,0,100,0,0,17504, 'Halion'),
(39863,8,0, 'Your efforts force %s further out of the physical realm!',41,0,100,0,0,0, 'Halion'),
(39863,9,0, 'Your companions'' efforts force %s further into the physical realm!',41,0,100,0,0,0, 'Halion'),
(40142,0,0, 'Without pressure in both realms, %s begins to regenerate.',41,0,100,0,0,0, 'Halion'),
(40142,1,0, 'Beware the shadow!',14,0,100,0,0,17506, 'Halion'),
(40142,2,0, 'I am the light and the darkness! Cower, mortals, before the herald of Deathwing!',14,0,100,0,0,17508, 'Halion'),
(40142,3,0, 'Your companions'' efforts force %s further into the twilight realm!',41,0,100,0,0,0, 'Halion'),
(40142,4,0, 'Your efforts force %s further out of the twilight realm!',41,0,100,0,0,0, 'Halion'),
(40083,0,0, 'The orbiting spheres pulse with dark energy!',41,0,100,0,0,0, 'Shadow Orb');
 
 
/* 
* updates\world\2012_10_06_04_world_misc_spawns.sql 
*/ 
SET @GUID = 42639;  -- Requires one   (creature)
SET @GUID2 = 42651;
SET @OGUID = 5286; -- Requires three (gameobject)

DELETE FROM `gameobject` WHERE `id`=203624;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(@OGUID,203624,724,15,0x20,3157.372,533.9948,72.8887,1.034892,0,0,0.4946623,0.8690853,120,0,0);

DELETE FROM `creature` WHERE `id` IN (40081,40091); -- ,40151);
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(@GUID,40091,724,1,0x20,0,0,3113.711,533.5382,72.96869,1.936719,300,0,0,1,0,0,0,0,0),
(@GUID2,40081,724,1,0x20,0,0,3153.75,533.1875,72.97205,0,300,0,0,1,0,0,0,0,0);

SET @PATH = @GUID * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@GUID,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3117.59,547.7952,72.96869,0,0,0,0,100,0),
(@PATH,2,3127.461,558.7396,72.96869,0,0,0,0,100,0),
(@PATH,3,3138.042,567.9514,72.98305,0,0,0,0,100,0),
(@PATH,4,3154.09,574.9636,72.98305,0,0,0,0,100,0),
(@PATH,5,3172.565,567.493,72.86058,0,0,0,0,100,0),
(@PATH,6,3181.981,555.8889,72.9127,0,0,0,0,100,0),
(@PATH,7,3189.923,533.3542,73.0377,0,0,0,0,100,0),
(@PATH,8,3182.315,513.4202,72.9771,0,0,0,0,100,0),
(@PATH,9,3177.168,504.3802,72.7271,0,0,0,0,100,0),
(@PATH,10,3167.878,496.8368,72.50312,0,0,0,0,100,0),
(@PATH,11,3152.238,490.4705,72.62009,0,0,0,0,100,0),
(@PATH,12,3138.174,499.3056,72.87009,0,0,0,0,100,0),
(@PATH,13,3126.83,506.0799,72.95515,0,0,0,0,100,0),
(@PATH,14,3120.68,515.3524,72.95515,0,0,0,0,100,0),
(@PATH,15,3113.711,533.5382,72.96869,0,0,0,0,100,0);

 
 
/* 
* updates\world\2012_10_06_05_world_spell_script_names.sql 
*/ 
-- Boss Elder Nadox Move Heroic Spell Script
DELETE FROM `spell_script_names` WHERE `spell_id`=56153;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(56153, 'spell_elder_nadox_guardian');
 
 
/* 
* updates\world\2012_10_07_00_world_creature_loot_template.sql 
*/ 
-- increase droprate for Plump Buzzard Wing
UPDATE `creature_loot_template` SET `chanceOrQuestChance`=-50 WHERE `item`=23239;
 
 
/* 
* updates\world\2012_10_07_01_world_spell_proc_event.sql 
*/ 
UPDATE `spell_proc_event` SET `procflags`=0x15510 WHERE `entry`=53386;
 
 
/* 
* updates\world\2012_10_09_00_world_spell_groups.sql 
*/ 
-- Improved Scorch, Improved Shadow Bolt and Winter's Chill effect should not stack
DELETE FROM `spell_group` WHERE `id`=1037;
INSERT INTO `spell_group`(`id`,`spell_id`) VALUES
(1037,22959),
(1037,17800),
(1037,12579);

DELETE FROM `spell_group_stack_rules` WHERE `group_id`=1037;
INSERT INTO `spell_group_stack_rules`(`group_id`,`stack_rule`) VALUES (1037,3);
 
 
/* 
* updates\world\2012_10_09_01_world_spell_groups.sql 
*/ 
-- Blood Frenzy (Warrior) and Savage Combat effect should not stack
DELETE FROM `spell_group` WHERE `id`=1119;
INSERT INTO `spell_group`(`id`,`spell_id`) VALUES
(1119,30069),
(1119,58684);

DELETE FROM `spell_group_stack_rules` WHERE `group_id`=1119;
INSERT INTO `spell_group_stack_rules`(`group_id`,`stack_rule`) VALUES (1119,3);

-- Remove invalid spell_groups
DELETE FROM `spell_group` WHERE `id` IN (1038,1039);
 
 
/* 
* updates\world\2012_10_09_02_world_spell_groups.sql 
*/ 
SET @GROUP := 1120;
-- Totem of Wrath and Heart of the Crusader effect should not stack
DELETE FROM `spell_group` WHERE `id`=@GROUP;
INSERT INTO `spell_group`(`id`,`spell_id`) VALUES
(@GROUP,21183),
(@GROUP,30708);

DELETE FROM `spell_group_stack_rules` WHERE `group_id`=@GROUP;
INSERT INTO `spell_group_stack_rules`(`group_id`,`stack_rule`) VALUES (@GROUP,3);
 
 
/* 
* updates\world\2012_10_10_00_world_battleground_template.sql 
*/ 
-- Remove all bgs from e1bee86ee6f5c3ab7b1da6d1b54c98c2851f11ec
DELETE FROM `battleground_template` WHERE `id` = 6; -- all Bgs
 
 
/* 
* updates\world\2012_10_11_00_world_gameobject.sql 
*/ 
SET @GUID = 74685;
SET @MAP = 571;
DELETE FROM `gameobject` WHERE (`id` IN (192254,192255,192269,192284,192285,192336,192338,192339,192349,192350,192351,192352,192353,192354,192355,192356,192357,192358,192359,192360,192361,192362,192363,192364,192366,192367,192368,192369,192370,192371,192372,192373,192374,192375,192378,192379,192416,192488,192501) AND `guid` != 67250) OR `guid` BETWEEN @GUID AND @GUID+87;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`) VALUES
(@GUID+0, 192488, @MAP, 64, 5262.540039, 3047.949951, 432.054993, 3.106650),   -- Flag on tower 
(@GUID+1, 192501, @MAP, 128, 5262.540039, 3047.949951, 432.054993, 3.106650),   -- Flag on tower
(@GUID+2, 192374, @MAP, 64, 5272.939941, 2976.550049, 444.492004, 3.124120),   -- Flag on Wall Intersect 
(@GUID+3, 192416, @MAP, 128, 5272.939941, 2976.550049, 444.492004, 3.124120),   -- Flag on Wall Intersect
(@GUID+4, 192375, @MAP, 64, 5235.189941, 2941.899902, 444.278015, 1.588250),   -- Flag on Wall Intersect 
(@GUID+5, 192416, @MAP, 128, 5235.189941, 2941.899902, 444.278015, 1.588250),   -- Flag on Wall Intersect
(@GUID+6, 192488, @MAP, 64, 5163.129883, 2952.590088, 433.502991, 1.535890),   -- Flag on tower 
(@GUID+7, 192501, @MAP, 128, 5163.129883, 2952.590088, 433.502991, 1.535890),   -- Flag on tower
(@GUID+8, 192488, @MAP, 64, 5145.109863, 2935.000000, 433.385986, 3.141590),   -- Flag on tower 
(@GUID+9, 192501, @MAP, 128, 5145.109863, 2935.000000, 433.385986, 3.141590),   -- Flag on tower
(@GUID+10, 192488, @MAP, 64, 5158.810059, 2883.129883, 431.618011, 3.141590),   -- Flag on wall 
(@GUID+11, 192416, @MAP, 128, 5158.810059, 2883.129883, 431.618011, 3.141590),   -- Flag on wall
(@GUID+12, 192336, @MAP, 64, 5154.490234, 2862.149902, 445.011993, 3.141590),   -- Flag on Wall Intersect 
(@GUID+13, 192416, @MAP, 128, 5154.490234, 2862.149902, 445.011993, 3.141590),   -- Flag on Wall Intersect
(@GUID+14, 192255, @MAP, 64, 5154.520020, 2853.310059, 409.183014, 3.141590),   -- Flag on the floor 
(@GUID+15, 192269, @MAP, 128, 5154.520020, 2853.310059, 409.183014, 3.141590),   -- Flag on the floor
(@GUID+16, 192254, @MAP, 64, 5154.459961, 2828.939941, 409.188995, 3.141590),   -- Flag on the floor 
(@GUID+17, 192269, @MAP, 128, 5154.459961, 2828.939941, 409.188995, 3.141590),   -- Flag on the floor
(@GUID+18, 192349, @MAP, 64, 5155.310059, 2820.739990, 444.979004, -3.13286),   -- Flag on wall intersect 
(@GUID+19, 192416, @MAP, 128, 5155.310059, 2820.739990, 444.979004, -3.13286),   -- Flag on wall intersect
(@GUID+20, 192488, @MAP, 64, 5160.339844, 2798.610107, 430.769012, 3.141590),   -- Flag on wall 
(@GUID+21, 192416, @MAP, 128, 5160.339844, 2798.610107, 430.769012, 3.141590),   -- Flag on wall
(@GUID+22, 192488, @MAP, 64, 5146.040039, 2747.209961, 433.584015, 3.071770),   -- Flag on tower 
(@GUID+23, 192501, @MAP, 128, 5146.040039, 2747.209961, 433.584015, 3.071770),   -- Flag on tower
(@GUID+24, 192488, @MAP, 64, 5163.779785, 2729.679932, 433.394012, -1.58825),   -- Flag on tower 
(@GUID+25, 192501, @MAP, 128, 5163.779785, 2729.679932, 433.394012, -1.58825),   -- Flag on tower
(@GUID+26, 192366, @MAP, 64, 5236.270020, 2739.459961, 444.992004, -1.59698),   -- Flag on wall intersect 
(@GUID+27, 192416, @MAP, 128, 5236.270020, 2739.459961, 444.992004, -1.59698),   -- Flag on wall intersect
(@GUID+28, 192367, @MAP, 64, 5271.799805, 2704.870117, 445.183014, -3.13286),   -- Flag on wall intersect 
(@GUID+29, 192416, @MAP, 128, 5271.799805, 2704.870117, 445.183014, -3.13286),   -- Flag on wall intersect
(@GUID+30, 192488, @MAP, 64, 5260.819824, 2631.800049, 433.324005, 3.054330),   -- Flag on tower 
(@GUID+31, 192501, @MAP, 128, 5260.819824, 2631.800049, 433.324005, 3.054330),   -- Flag on tower
(@GUID+32, 192488, @MAP, 64, 5278.379883, 2613.830078, 433.408997, -1.58825),   -- Flag on tower 
(@GUID+33, 192501, @MAP, 128, 5278.379883, 2613.830078, 433.408997, -1.58825),   -- Flag on tower
(@GUID+34, 192364, @MAP, 64, 5350.879883, 2622.719971, 444.686005, -1.57080),   -- Flag on wall intersect 
(@GUID+35, 192416, @MAP, 128, 5350.879883, 2622.719971, 444.686005, -1.57080),   -- Flag on wall intersect
(@GUID+36, 192370, @MAP, 64, 5392.270020, 2639.739990, 435.330994, 1.509710),   -- Flag on wall intersect 
(@GUID+37, 192416, @MAP, 128, 5392.270020, 2639.739990, 435.330994, 1.509710),   -- Flag on wall intersect
(@GUID+38, 192369, @MAP, 64, 5350.950195, 2640.360107, 435.407990, 1.570800),   -- Flag on wall intersect 
(@GUID+39, 192416, @MAP, 128, 5350.950195, 2640.360107, 435.407990, 1.570800),   -- Flag on wall intersect
(@GUID+40, 192368, @MAP, 64, 5289.459961, 2704.679932, 435.875000, -0.01745),   -- Flag on wall intersect 
(@GUID+41, 192416, @MAP, 128, 5289.459961, 2704.679932, 435.875000, -0.01745),   -- Flag on wall intersect
(@GUID+42, 192362, @MAP, 64, 5322.120117, 2763.610107, 444.973999, -1.55334),   -- Flag on wall intersect 
(@GUID+43, 192416, @MAP, 128, 5322.120117, 2763.610107, 444.973999, -1.55334),   -- Flag on wall intersect
(@GUID+44, 192363, @MAP, 64, 5363.609863, 2763.389893, 445.023987, -1.54462),   -- Flag on wall intersect 
(@GUID+45, 192416, @MAP, 128, 5363.609863, 2763.389893, 445.023987, -1.54462),   -- Flag on wall intersect
(@GUID+46, 192379, @MAP, 64, 5363.419922, 2781.030029, 435.763000, 1.570800),   -- Flag on wall intersect 
(@GUID+47, 192416, @MAP, 128, 5363.419922, 2781.030029, 435.763000, 1.570800),   -- Flag on wall intersect
(@GUID+48, 192378, @MAP, 64, 5322.020020, 2781.129883, 435.811005, 1.570800),   -- Flag on wall intersect 
(@GUID+49, 192416, @MAP, 128, 5322.020020, 2781.129883, 435.811005, 1.570800),   -- Flag on wall intersect
(@GUID+50, 192355, @MAP, 64, 5288.919922, 2820.219971, 435.721008, 0.017452),   -- Flag on wall intersect 
(@GUID+51, 192416, @MAP, 128, 5288.919922, 2820.219971, 435.721008, 0.017452),   -- Flag on wall intersect
(@GUID+52, 192354, @MAP, 64, 5288.410156, 2861.790039, 435.721008, 0.017452),   -- Flag on wall intersect 
(@GUID+53, 192416, @MAP, 128, 5288.410156, 2861.790039, 435.721008, 0.017452),   -- Flag on wall intersect
(@GUID+54, 192358, @MAP, 64, 5322.229980, 2899.429932, 435.808014, -1.58825),   -- Flag on wall intersect 
(@GUID+55, 192416, @MAP, 128, 5322.229980, 2899.429932, 435.808014, -1.58825),   -- Flag on wall intersect
(@GUID+56, 192359, @MAP, 64, 5364.350098, 2899.399902, 435.838989, -1.57080),   -- Flag on wall intersect 
(@GUID+57, 192416, @MAP, 128, 5364.350098, 2899.399902, 435.838989, -1.57080),   -- Flag on wall intersect
(@GUID+58, 192338, @MAP, 64, 5397.759766, 2873.080078, 455.460999, 3.106650),   -- Flag on keep 
(@GUID+59, 192416, @MAP, 128, 5397.759766, 2873.080078, 455.460999, 3.106650),   -- Flag on keep
(@GUID+60, 192339, @MAP, 64, 5397.390137, 2809.330078, 455.343994, 3.106650),   -- Flag on keep 
(@GUID+61, 192416, @MAP, 128, 5397.390137, 2809.330078, 455.343994, 3.106650),   -- Flag on keep
(@GUID+62, 192284, @MAP, 64, 5372.479980, 2862.500000, 409.049011, 3.141590),   -- Flag on floor 
(@GUID+63, 192269, @MAP, 128, 5372.479980, 2862.500000, 409.049011, 3.141590),   -- Flag on floor
(@GUID+64, 192285, @MAP, 64, 5371.490234, 2820.800049, 409.177002, 3.141590),   -- Flag on floor 
(@GUID+65, 192269, @MAP, 128, 5371.490234, 2820.800049, 409.177002, 3.141590),   -- Flag on floor
(@GUID+66, 192371, @MAP, 64, 5364.290039, 2916.939941, 445.330994, 1.579520),   -- Flag on wall intersect 
(@GUID+67, 192416, @MAP, 128, 5364.290039, 2916.939941, 445.330994, 1.579520),   -- Flag on wall intersect
(@GUID+68, 192372, @MAP, 64, 5322.859863, 2916.949951, 445.153992, 1.562070),   -- Flag on wall intersect 
(@GUID+69, 192416, @MAP, 128, 5322.859863, 2916.949951, 445.153992, 1.562070),   -- Flag on wall intersect
(@GUID+70, 192373, @MAP, 64, 5290.350098, 2976.560059, 435.221008, 0.017452),   -- Flag on wall intersect 
(@GUID+71, 192416, @MAP, 128, 5290.350098, 2976.560059, 435.221008, 0.017452),   -- Flag on wall intersect
(@GUID+72, 192360, @MAP, 64, 5352.370117, 3037.090088, 435.252014, -1.57080),   -- Flag on wall intersect 
(@GUID+73, 192416, @MAP, 128, 5352.370117, 3037.090088, 435.252014, -1.57080),   -- Flag on wall intersect
(@GUID+74, 192361, @MAP, 64, 5392.649902, 3037.110107, 433.713013, -1.52716),   -- Flag on wall intersect 
(@GUID+75, 192416, @MAP, 128, 5392.649902, 3037.110107, 433.713013, -1.52716),   -- Flag on wall intersect
(@GUID+76, 192356, @MAP, 64, 5237.069824, 2757.030029, 435.795990, 1.518440),   -- Flag on wall intersect 
(@GUID+77, 192416, @MAP, 128, 5237.069824, 2757.030029, 435.795990, 1.518440),   -- Flag on wall intersect
(@GUID+78, 192352, @MAP, 64, 5173.020020, 2820.929932, 435.720001, 0.017452),   -- Flag on wall intersect 
(@GUID+79, 192416, @MAP, 128, 5173.020020, 2820.929932, 435.720001, 0.017452),   -- Flag on wall intersect
(@GUID+80, 192353, @MAP, 64, 5172.109863, 2862.570068, 435.721008, 0.017452),   -- Flag on wall intersect 
(@GUID+81, 192416, @MAP, 128, 5172.109863, 2862.570068, 435.721008, 0.017452),   -- Flag on wall intersect
(@GUID+82, 192357, @MAP, 64, 5235.339844, 2924.340088, 435.040009, -1.57080),   -- Flag on wall intersect 
(@GUID+83, 192416, @MAP, 128, 5235.339844, 2924.340088, 435.040009, -1.57080),   -- Flag on wall intersect
(@GUID+84, 192350, @MAP, 64, 5270.689941, 2861.780029, 445.058014, -3.11539),   -- Flag on wall intersect 
(@GUID+85, 192416, @MAP, 128, 5270.689941, 2861.780029, 445.058014, -3.11539),   -- Flag on wall intersect
(@GUID+86, 192351, @MAP, 64, 5271.279785, 2820.159912, 445.200989, -3.13286),   -- Flag on wall intersect 
(@GUID+87, 192416, @MAP, 128, 5271.279785, 2820.159912, 445.200989, -3.13286);   -- Flag on wall intersect
 
 
/* 
* updates\world\2012_10_13_00_world_creature_template.sql 
*/ 
-- Orb rotation focus
UPDATE `creature_template` SET `modelid1`=11868,`modelid2`=169,`minlevel`=80,`maxlevel`=80,`faction_A`=14,`faction_H`=14,`speed_walk`=2.2,`speed_run`=0.785714,`baseattacktime`=2000,`unit_flags`=33554688 WHERE `entry` IN(43280,43281,43282);
UPDATE `creature_template` SET `difficulty_entry_1`=43280, `difficulty_entry_2`=43281,`difficulty_entry_3`=43282 WHERE `entry`=40091;

-- Orb carrier
UPDATE `creature_template` SET `minlevel`=80,`maxlevel`=80,`exp`=2,`faction_A`=14,`faction_H`=14,`speed_walk`=1.2,`speed_run`=1.14286,`baseattacktime`=2000 WHERE `entry` IN(40470,40471,40472);
UPDATE `creature_template` SET `difficulty_entry_1`=40470, `difficulty_entry_2`=40471,`difficulty_entry_3`=40472 WHERE `entry`=40081;

-- Saviana Ragefire
UPDATE `creature_template` SET `exp`=2 WHERE `entry`=39823;

-- General Zarithrian
UPDATE `creature_template` SET `exp`=2 WHERE `entry`=39805;

-- Twilight Halion
UPDATE `creature_template` SET `difficulty_entry_1`=40143, `difficulty_entry_2`=40144,`difficulty_entry_3`=40145 WHERE `entry`=40142;
UPDATE `creature_template` SET `minlevel`=83,`maxlevel`=83,`speed_walk`=1.6,`speed_run`=1.42857,`baseattacktime`=1800,`unit_flags`=559168,`dynamicflags`=12 WHERE `entry` IN(40143,40144,40145);

-- Halion
UPDATE `creature_template` SET `speed_walk`=1.6,`speed_run`=1.42857,`baseattacktime`=1500,`unit_flags`=32832,`dynamicflags`=12,`flags_extra`=1 WHERE `entry` IN(39864,39944,39945);
UPDATE `creature_template` SET `dmg_multiplier`=50 WHERE `entry`=39944;
UPDATE `creature_template` SET `dmg_multiplier`=85 WHERE `entry`=39945;

-- Onyx Flamecaller
UPDATE `creature_template` SET `minlevel`=82,`maxlevel`=82,`faction_A`=103,`faction_H`=103,`exp`=2,`speed_walk`=0.88888,`speed_run`=1.42857,`baseattacktime`=2000,`unit_flags`=32768,`equipment_id`=2468 WHERE `entry`=39815;
 
 
/* 
* updates\world\2012_10_14_00_world_creature.sql 
*/ 
-- Spawnmask updates
UPDATE `creature` SET `spawnMask`=15 WHERE `id` IN(40091, 40081);

-- Auras updates (Now in script, can't be used in creature_addon because dynamically spawned)
DELETE FROM `creature_template_addon` WHERE `entry` IN(39863, 40142);

-- Blazing Aura
-- NOTE: This still does not work, no clue why. Probably a core-side bug ?
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13,2,75886,0,0,31,0,3,40683,0,0,0, '', 'Blazing Aura can only target Living Embers');
 
 
/* 
* updates\world\2012_10_16_00_world_spell_area.sql 
*/ 
ALTER TABLE `spell_area` ADD COLUMN `quest_start_status` INT(11) NOT NULL DEFAULT 64; -- default is QUEST_STATUS_REWARDED
ALTER TABLE `spell_area` ADD COLUMN `quest_end_status` INT(11) NOT NULL DEFAULT 11; -- default is QUEST_STATUS_COMPLETE | QUEST_STATUS_NONE | QUEST_STATUS_INCOMPLETE
UPDATE spell_area SET `quest_start_status` = (1 << 6) | (1 << 3) | (1 << 1) WHERE `quest_start_active` = 1;
ALTER TABLE spell_area DROP COLUMN `quest_start_active`; 
 
/* 
* updates\world\2012_10_20_00_world_transports.sql 
*/ 
-- Update position for Koltira Deathweaver
UPDATE `creature_transport` SET `TransOffsetX`=45.50927,`TransOffsetY`=6.679555,`TransOffsetZ`=30.17881,`TransOffsetO`=5.445427 WHERE `guid`=36;

-- Set proper name and period timers for icecrown ships
UPDATE `transports` SET `name`= 'Alliance gunship patrolling above Icecrown (\"The Skybreaker\")',`period`=1051388 WHERE `entry`=192242;
UPDATE `transports` SET `name`= 'Horde gunship patrolling above Icecrown (\"Orgrim''s Hammer\")',`period`=1431158 WHERE `entry`=192241;
 
 
/* 
* updates\world\2012_10_20_01_world_spell_script_names.sql 
*/ 
-- Spellscript and conditions for spells of quest Gordunni Cobalt
DELETE FROM `spell_script_names` WHERE `spell_id`=19395;
INSERT INTO `spell_script_names`(`spell_id`,`ScriptName`) VALUES
(19395,'spell_gordunni_trap');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=11757;
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`Comment`) VALUES
(13,1,11757,31,5,144050,'Digging for Cobalt targets Gordunni Trap');
 
 
/* 
* updates\world\2012_10_20_02_world_creature_text.sql 
*/ 
-- Gnomeregan/Blastmaster Emi Shortfuse's event
DELETE FROM `script_texts` WHERE `entry` BETWEEN -1090028 AND -1090000;
DELETE FROM `creature_text` WHERE `entry` IN (7361,7998);
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
-- Emi Shortfuse
(7998,0,0, 'With your help, I can evaluate these tunnels.',12,0,100,0,0,0, 'SAY_BLASTMASTER_0'),
(7998,1,0, 'Let''s see if we can find out where these Troggs are coming from... and put a stop to the invasion!',12,0,100,0,0,0, 'SAY_BLASTMASTER_1'),
(7998,2,0, 'Such devastation... what horrible mess...',12,0,100,0,0,0, 'SAY_BLASTMASTER_2'),
(7998,3,0, 'It''s quiet here...',12,0,100,0,0,0, 'SAY_BLASTMASTER_3'),
(7998,4,0, '...too quiet.',12,0,100,0,0,0, 'SAY_BLASTMASTER_4'),
(7998,5,0, 'Look! Over there at the tunnel wall!',12,0,100,0,0,0, 'SAY_BLASTMASTER_5'),
(7998,6,0, 'Trogg incrusion! Defend me while I blast the hole closed!',12,0,100,0,0,0, 'SAY_BLASTMASTER_6'),
(7998,7,0, 'I don''t think one charge is going to cut it. Keep fending them off!',12,0,100,0,0,0, 'SAY_BLASTMASTER_7'),
(7998,8,0, 'The charges are set. Get back before they blow!',12,0,100,0,0,0, 'SAY_BLASTMASTER_8'),
(7998,9,0, 'Incoming blast in 10 seconds!',14,0,100,0,0,0, 'SAY_BLASTMASTER_9'),
(7998,10,0, 'Incoming blast in 5 seconds. Clear the tunnel!',14,0,100,0,0,0, 'SAY_BLASTMASTER_10'),
(7998,11,0, 'FIRE IN THE HOLE!',14,0,100,0,0,0, 'SAY_BLASTMASTER_11'),
(7998,12,0, 'Well done! Without your help I would have never been able to thwart that wave of troggs.',12,0,100,0,0,0, 'SAY_BLASTMASTER_12'),
(7998,13,0, 'Did you hear something?',12,0,100,0,0,0, 'SAY_BLASTMASTER_13'),
(7998,14,0, 'I heard something over there.',12,0,100,0,0,0, 'SAY_BLASTMASTER_14'),
(7998,15,0, 'More troggs! Ward them off as I prepare the explosives!',12,0,100,0,0,0, 'SAY_BLASTMASTER_15'),
(7998,16,0, 'The final charge is set. Stand back!',12,0,100,0,0,0, 'SAY_BLASTMASTER_16'),
(7998,17,0, '10 seconds to blast! Stand back!!!',14,0,100,0,0,0, 'SAY_BLASTMASTER_17'),
(7998,18,0, '5 seconds until detonation!!',14,0,100,0,0,0, 'SAY_BLASTMASTER_18'),
(7998,19,0, 'Superb! Because of your help, my people stand a chance of re-taking our belowed city. Three cheers to you!',12,0,100,0,0,0, 'SAY_BLASTMASTER_19'),
-- Grubbis
(7361,0,0, 'We come from below! You can never stop us!',14,0,100,0,0,0, 'SAY_GRUBBIS');
 
 
/* 
* updates\world\2012_10_21_00_world_conditions.sql 
*/ 
ALTER TABLE `conditions` CHANGE COLUMN `SourceEntry` `SourceEntry` MEDIUMINT(8) NOT NULL DEFAULT 0;
 
 
/* 
* updates\world\2012_10_21_01_world_misc.sql 
*/ 
-- Area conditions for Plant Chieftains Totem
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=56765;
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ErrorTextId`,`Comment`) VALUES
(17,56765,29,30446,15,64,'Plant Chieftains Totem only useable next to Rift');

-- Apply Close Rift to The Chieftain's Totem
DELETE FROM `creature_template_addon` WHERE `entry`=30444;
INSERT INTO `creature_template_addon`(`entry`,`auras`) VALUES
(30444,'56763');

-- Assign aura script to Close Rift
DELETE FROM `spell_script_names` WHERE `spell_id`=56763;
INSERT INTO `spell_script_names`(`spell_id`,`ScriptName`) VALUES
(56763,'spell_close_rift');

-- Target conditions for spell triggered by Close Rift Periodic
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (56764,61665);
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`Comment`) VALUES
(13,1,56764,31,3,30446,'Close Rift Periodic targets Frostfloe Rift'),
(13,1,61665,31,3,30446,'Despawn Rift targets Frostfloe Rift');

-- Assign SmartAI to Frostfloe Rift
UPDATE `creature_template` SET `AIName`='SmartAI',`ScriptName`='' WHERE `entry`=30446;

-- Create SAI for Frostfloe Rift
DELETE FROM `smart_scripts` WHERE `entryorguid`=30446 AND `source_type`=0;
INSERT INTO `smart_scripts`(`entryorguid`,`id`,`link`,`event_type`,`event_param1`,`action_type`,`action_param1`,`action_param2`,`target_type`,`comment`) VALUES
(30446,1,2,8,61665,45,1,1,7,'Frostfloe Rift - On spell hit - Set data of invoker'),
(30446,2,0,61,0,41,0,0,1,'Frostfloe Rift - On spell hit - Despawn');

-- Assign SmartAI to Chieftain's Totem
UPDATE `creature_template` SET `AIName`='SmartAI',`ScriptName`='' WHERE `entry`=30444;

-- Create SAI for Chieftain's Totem
DELETE FROM `smart_scripts` WHERE `entryorguid`=30444 AND `source_type`=0;
INSERT INTO `smart_scripts`(`entryorguid`,`event_type`,`event_param1`,`event_param2`,`action_type`,`action_param1`,`target_type`,`comment`) VALUES
(30444,38,1,1,33,30444,23,'Chieftains Totem - On data set - Give quest credit');
 
 
/* 
* updates\world\2012_10_23_00_world_trinity_string.sql 
*/ 
DELETE FROM `trinity_string` WHERE `entry` IN (9980, 9981, 9982, 9983, 9984, 9985, 9986, 9987, 9988, 9989, 9990, 9991, 9992, 9993, 9994, 9995, 9996, 9997, 9998, 9999);
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
  (9980, 'Player name: %s, State: %s, Dungeons: %u (%s), Roles: %s, Comment: %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (9981, 'LfgGroup?: %u, State: %s, Dungeon: %u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (9982, 'Not in group', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (9983, 'Queues cleared', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (9984, 'Lfg options: %u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (9985, 'Lfg options changed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (9986, 'None', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (9987, 'Role check', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (9988, 'Queued', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (9989, 'Proposal', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (9990, 'Vote kick', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (9991, 'In dungeon', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (9992, 'Finished dungeon', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (9993, 'Raid browser', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (9994, 'Tank', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (9995, 'Healer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (9996, 'Dps', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (9997, 'Leader', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (9998, 'None', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (9999, 'Error', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
 
 
/* 
* updates\world\2012_10_23_01_world_command.sql 
*/ 
DELETE FROM `command` WHERE `name` LIKE 'lfg%';

INSERT INTO `command` (`name`, `security`, `help`) VALUES
('lfg player', 2, 'Syntax: .lfg player\n Shows information about player (state, roles, comment, dungeons selected).'),
('lfg group', 2, 'Syntax: .lfg group\n Shows information about all players in the group  (state, roles, comment, dungeons selected).'),
('lfg queue', 2, 'Syntax: .lfg queue\n Shows info about current lfg queues.'),
('lfg clean', 3, 'Syntax: .flg clean\n Cleans current queue, only for debugging purposes.'),
('lfg options', 3, 'Syntax: .lfg options [new value]\n Shows current lfg options. New value is set if extra param is present.');
 
 
/* 
* updates\world\2012_10_25_00_world_childrens_week.sql 
*/ 
-- Orphan Matron Aria
UPDATE `creature_template` SET `AIName`='SmartAI',`ScriptName`='' WHERE `entry`=34365;

DELETE FROM `smart_scripts` WHERE `entryorguid`=34365 AND `source_type`=0;
INSERT INTO `smart_scripts`(`entryorguid`,`id`,`link`,`event_type`,`event_param1`,`event_param2`,`action_type`,`action_param1`,`target_type`,`comment`) VALUES
(34365,1,4,62,10502,1,33,34365,7,'Orphan Matron Aria - On gossip select - Give quest credit'),
(34365,2,4,62,10502,2,11,65359,7,'Orphan Matron Aria - On gossip select - Create oracle orphan whistle'),
(34365,3,4,62,10502,3,11,65360,7,'Orphan Matron Aria - On gossip select - Create wolvar orphan whistle'),
(34365,4,0,61,0,0,72,0,7,'Orphan Matron Aria - On gossip select - Close gossip');

DELETE FROM `gossip_menu_option` WHERE `menu_id`=10502;
INSERT INTO `gossip_menu_option`(`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`) VALUES
(10502,1,0,'Tell me about the orphans.',1,1),
(10502,2,0,'I need a new Oracle Orphan Whistle.',1,1),
(10502,3,0,'I need a new Wolvar Orphan Whistle.',1,1);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=10502;
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`NegativeCondition`,`Comment`) VALUES
(15,10502,1,1,12,10,0,0,'Childrens Week must be active'),
(15,10502,1,1,1,58818,0,0,'Needs aura 58818'),
(15,10502,1,1,9,13927,0,0,'Quest 13927 must be active'),
(15,10502,1,2,12,10,0,0,'Childrens Week must be active'),
(15,10502,1,2,1,58818,0,0,'Needs aura 58818'),
(15,10502,1,2,9,13926,0,0,'Quest 13926 must be active'),
(15,10502,2,0,12,10,0,0,'Childrens Week must be active'),
(15,10502,2,0,8,13926,0,0,'Quest 13926 must be rewarded'),
(15,10502,2,0,2,46397,1,1,'Must not have item 46397'),
(15,10502,3,0,12,10,0,0,'Childrens Week must be active'),
(15,10502,3,0,8,13927,0,0,'Quest 13926 must be rewarded'),
(15,10502,3,0,2,46396,1,1,'Must not have item 46397');

-- Orphan Matron Battlewail
UPDATE `creature_template` SET `AIName`='SmartAI',`ScriptName`='' WHERE `entry`=14451;

DELETE FROM `smart_scripts` WHERE `entryorguid`=14451 AND `source_type`=0;
INSERT INTO `smart_scripts`(`entryorguid`,`id`,`link`,`event_type`,`event_param1`,`event_param2`,`action_type`,`action_param1`,`target_type`,`comment`) VALUES
(14451,1,2,62,5848,1,11,23125,7,'Orphan Matron Battlewail - On gossip select - Create orc orphan whistle'),
(14451,2,0,61,0,0,72,0,7,'Orphan Matron Battlewail - On gossip select - Close gossip');

DELETE FROM `gossip_menu_option` WHERE `menu_id`=5848;
INSERT INTO `gossip_menu_option`(`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`) VALUES
(5848,1,0,'I need a new Orc Orphan Whistle.',1,1);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=5848;
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`NegativeCondition`,`Comment`) VALUES
(15,5848,1,0,12,10,0,0,'Childrens Week must be active'),
(15,5848,1,0,8,172,0,0,'Quest 172 must be rewarded'),
(15,5848,1,0,2,18597,1,1,'Must not have item 18597');

-- Orphan Matron Mercy
UPDATE `creature_template` SET `AIName`='SmartAI',`ScriptName`='' WHERE `entry`=22819;

DELETE FROM `smart_scripts` WHERE `entryorguid`=22819 AND `source_type`=0;
INSERT INTO `smart_scripts`(`entryorguid`,`id`,`link`,`event_type`,`event_param1`,`event_param2`,`action_type`,`action_param1`,`target_type`,`comment`) VALUES
(22819,1,3,62,8568,1,11,39512,7,'Orphan Matron Mercy - On gossip select - Create blood elf orphan whistle'),
(22819,2,3,62,8568,2,11,39513,7,'Orphan Matron Mercy - On gossip select - Create draenei orphan whistle'),
(22819,3,0,61,0,0,72,0,7,'Orphan Matron Mercy - On gossip select - Close gossip');

DELETE FROM `gossip_menu_option` WHERE `menu_id`=8568;
INSERT INTO `gossip_menu_option`(`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`) VALUES
(8568,1,0,'I need a new Blood Elf Orphan Whistle.',1,1),
(8568,2,0,'I need a new Draenei Orphan Whistle.',1,1);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=8568;
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`NegativeCondition`,`Comment`) VALUES
(15,8568,1,0,12,10,0,0,'Childrens Week must be active'),
(15,8568,1,0,8,10942,0,0,'Quest 10942 must be rewarded'),
(15,8568,1,0,2,31880,1,1,'Must not have item 31880'),
(15,8568,2,0,12,10,0,0,'Childrens Week must be active'),
(15,8568,2,0,8,10943,0,0,'Quest 10943 must be rewarded'),
(15,8568,2,0,2,31881,1,1,'Must not have item 31881');

-- Orphan Matron Nightingale
UPDATE `creature_template` SET `AIName`='SmartAI',`ScriptName`='' WHERE `entry`=14450;

DELETE FROM `smart_scripts` WHERE `entryorguid`=14450 AND `source_type`=0;
INSERT INTO `smart_scripts`(`entryorguid`,`id`,`link`,`event_type`,`event_param1`,`event_param2`,`action_type`,`action_param1`,`target_type`,`comment`) VALUES
(14450,1,2,62,5849,1,11,23124,7,'Orphan Matron Nightingale - On gossip select - Create human orphan whistle'),
(14450,2,0,61,0,0,72,0,7,'Orphan Matron Nightingale - On gossip select - Close gossip');

DELETE FROM `gossip_menu_option` WHERE `menu_id`=5849;
INSERT INTO `gossip_menu_option`(`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`) VALUES
(5849,1,0,'I need a new Human Orphan Whistle.',1,1);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=5849;
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`NegativeCondition`,`Comment`) VALUES
(15,5849,1,0,12,10,0,0,'Childrens Week must be active'),
(15,5849,1,0,8,1468,0,0,'Quest 1468 must be rewarded'),
(15,5849,1,0,2,18598,1,1,'Must not have item 18598');

-- Oracle Orphan
SET @TEXT_ORACLE_ORPHAN_1 = 1;
SET @TEXT_ORACLE_ORPHAN_2 = 2;
SET @TEXT_ORACLE_ORPHAN_3 = 3;
SET @TEXT_ORACLE_ORPHAN_4 = 4;
SET @TEXT_ORACLE_ORPHAN_5 = 5;
SET @TEXT_ORACLE_ORPHAN_6 = 6;
SET @TEXT_ORACLE_ORPHAN_7 = 7;
SET @TEXT_ORACLE_ORPHAN_8 = 8;
SET @TEXT_ORACLE_ORPHAN_9 = 9;
SET @TEXT_ORACLE_ORPHAN_10 = 10;
SET @TEXT_ORACLE_ORPHAN_11 = 11;
SET @TEXT_ORACLE_ORPHAN_12 = 12;
SET @TEXT_ORACLE_ORPHAN_13 = 13;
SET @TEXT_ORACLE_ORPHAN_14 = 14;

UPDATE `creature_template` SET `AIName`='SmartAI',`ScriptName`='' WHERE `entry`=33533;

DELETE FROM `smart_scripts` WHERE `entryorguid`=33533 AND `source_type`=0;
INSERT INTO `smart_scripts`(`entryorguid`,`event_type`,`event_param1`,`action_type`,`action_param1`,`target_type`,`comment`) VALUES
(33533,8,65357,33,36209,7,'Oracle Orphan - On spellhit - Give quest credit');

DELETE FROM `creature_text` WHERE `entry`=33533;
INSERT INTO `creature_text`(`entry`,`groupid`,`text`,`type`,`emote`) VALUE
(33533,@TEXT_ORACLE_ORPHAN_1,"Look!",12,0),
(33533,@TEXT_ORACLE_ORPHAN_2,"We can dance too!",12,0),
(33533,@TEXT_ORACLE_ORPHAN_3,"We made a new friend!",12,0),
(33533,@TEXT_ORACLE_ORPHAN_4,"We here! Only, if this is world tree, how come it broke when they tried to put whole world in?",12,0),
(33533,@TEXT_ORACLE_ORPHAN_5,"Look! Is that us? We think it's us. A bit older, maybe?",12,0),
(33533,@TEXT_ORACLE_ORPHAN_6,"Looks like we blessed by Great Ones! Shrines give magic, make us high-oracle someday? Maybe?",12,0),
(33533,@TEXT_ORACLE_ORPHAN_7,"Wow! A real Great One? We don't even think Soo-say has met a real Great One!",12,0),
(33533,@TEXT_ORACLE_ORPHAN_8,"Um, hello, Mr. Great One. We are honored to meet you.",12,0),
(33533,@TEXT_ORACLE_ORPHAN_9,"Maybe you're asleep, Mr. Great One? We stand. Must be hard working being Great One, collecting all the shinies we leave for you.",12,0),
(33533,@TEXT_ORACLE_ORPHAN_10,"We brought you a gift, Great One. Maybe you see it when you wake up. Maybe you remember we came to see you, oki?",12,0),
(33533,@TEXT_ORACLE_ORPHAN_11,"So that's the queen of the dragons? Hmm... we thought she'd be bigger. Yes, we did.",12,0),
(33533,@TEXT_ORACLE_ORPHAN_12,"How come she doesn't look like the other dragons? could she turn into a big ol' dragon if she wanted to?",12,0),
(33533,@TEXT_ORACLE_ORPHAN_13,"Um... Your Majesty, would you turn into a dragon for us?",12,0),
(33533,@TEXT_ORACLE_ORPHAN_14,"Oki... How about now?",12,0);

DELETE FROM `creature_questrelation` WHERE `id`=33533;

DELETE FROM `game_event_creature_quest` WHERE `id`=33533;
INSERT INTO `game_event_creature_quest`(`eventEntry`,`id`,`quest`) VALUES
(10,33533,13929),
(10,33533,13933),
(10,33533,13950),
(10,33533,13954),
(10,33533,13956),
(10,33533,13937),
(10,33533,13959);

DELETE FROM `creature_involvedrelation` WHERE `id`=33533;
INSERT INTO `creature_involvedrelation`(`id`,`quest`) VALUES
(33533,13929),
(33533,13933),
(33533,13950),
(33533,13954),
(33533,13956),
(33533,13937),
(33533,13926);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (19,20) AND `SourceEntry` IN (13954,13956,13937);
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`comment`) VALUES
(19,13954,8,13929,'Accept quest 13954 - Quest 13929 needs to be rewarded'),
(19,13954,8,13933,'Accept quest 13954 - Quest 13933 needs to be rewarded'),
(19,13954,8,13950,'Accept quest 13954 - Quest 13950 needs to be rewarded'),
(19,13956,8,13929,'Accept quest 13956 - Quest 13929 needs to be rewarded'),
(19,13956,8,13933,'Accept quest 13956 - Quest 13933 needs to be rewarded'),
(19,13956,8,13950,'Accept quest 13956 - Quest 13950 needs to be rewarded'),
(19,13937,8,13956,'Accept quest 13937 - Quest 13956 needs to be rewarded'),
(20,13954,8,13929,'Show quest mark 13954 - Quest 13929 needs to be rewarded'),
(20,13954,8,13933,'Show quest mark 13954 - Quest 13933 needs to be rewarded'),
(20,13954,8,13950,'Show quest mark 13954 - Quest 13950 needs to be rewarded'),
(20,13956,8,13929,'Show quest mark 13956 - Quest 13929 needs to be rewarded'),
(20,13956,8,13933,'Show quest mark 13956 - Quest 13933 needs to be rewarded'),
(20,13956,8,13950,'Show quest mark 13956 - Quest 13950 needs to be rewarded'),
(20,13937,8,13956,'Show quest mark 13937 - Quest 13956 needs to be rewarded');

-- Wolvar Orphan
SET @TEXT_WOLVAR_ORPHAN_1 = 1;
SET @TEXT_WOLVAR_ORPHAN_2 = 2;
SET @TEXT_WOLVAR_ORPHAN_3 = 3;
SET @TEXT_WOLVAR_ORPHAN_4 = 4;
SET @TEXT_WOLVAR_ORPHAN_5 = 5;
SET @TEXT_WOLVAR_ORPHAN_6 = 6;
SET @TEXT_WOLVAR_ORPHAN_7 = 7;
SET @TEXT_WOLVAR_ORPHAN_8 = 8;
SET @TEXT_WOLVAR_ORPHAN_9 = 9;
SET @TEXT_WOLVAR_ORPHAN_10 = 10;
SET @TEXT_WOLVAR_ORPHAN_11 = 11;
SET @TEXT_WOLVAR_ORPHAN_12 = 12;
SET @TEXT_WOLVAR_ORPHAN_13 = 13;

UPDATE `creature_template` SET `AIName`='SmartAI',`ScriptName`='' WHERE `entry`=33532;

DELETE FROM `smart_scripts` WHERE `entryorguid`=33532 AND `source_type`=0;
INSERT INTO `smart_scripts`(`entryorguid`,`event_type`,`event_param1`,`action_type`,`action_param1`,`target_type`,`comment`) VALUES
(33532,8,65357,33,36209,7,'Wolvar Orphan - On spellhit - Give quest credit');

DELETE FROM `creature_text` WHERE `entry`=33532;
INSERT INTO `creature_text`(`entry`,`groupid`,`text`,`type`,`emote`) VALUE
(33532,@TEXT_WOLVAR_ORPHAN_1,"Look!",12,0),
(33532,@TEXT_WOLVAR_ORPHAN_2,"Got you back!",12,0),
(33532,@TEXT_WOLVAR_ORPHAN_3,"Good snowball fight!",12,0),
(33532,@TEXT_WOLVAR_ORPHAN_4,"Look! That must be Kekek as a mighty warrior! See? What Kekek tell you?",12,0),
(33532,@TEXT_WOLVAR_ORPHAN_5,"Hmm... that Kekek very old. Must be elder, leader of Frenzyheart. This good. Kekek have good future as warrior and leader. Kekek very happy you bring him here. Orphan-lady never do that for Kekek.",12,0),
(33532,@TEXT_WOLVAR_ORPHAN_6,"Wow. At last, Kekek get to meet Hemet Nesingwary!",12,0),
(33532,@TEXT_WOLVAR_ORPHAN_7,"Even Frenzyheart know all about you after you come to Sholazar. Maybe you teach Kekek your tricks?",12,0),
(33532,@TEXT_WOLVAR_ORPHAN_8,"Not sure how reading helps. Kekek can't read anyway, but if Hemet Nesingwary say, Kekek try.",12,0),
(33532,@TEXT_WOLVAR_ORPHAN_9,"Maybe give up and throw book at animals, but try.",12,0),
(33532,@TEXT_WOLVAR_ORPHAN_10,"You think maybe one day, Kekek lead Frenzyheart home, like bear-men fight to get tree-city back? Kekek want own home, not city with purple men, not jungle with big-tongues.",12,0),
(33532,@TEXT_WOLVAR_ORPHAN_11,"Kekek thought we go see dragon queen. This just some elf-lady with funny horns.",12,0),
(33532,@TEXT_WOLVAR_ORPHAN_12,"But why? Dragons big and powerful. Elf-lady weak. Kekek want to see dragon queen's real form.",12,0),
(33532,@TEXT_WOLVAR_ORPHAN_13,"Oh! Now Kekek understand. Not want to be crushed by big dragon-lady. Maybe come back sometime when not so crowded. Nice to meet you, dragon-lady.",12,0);

DELETE FROM `game_event_creature_quest` WHERE `id`=33532;
INSERT INTO `game_event_creature_quest`(`eventEntry`,`id`,`quest`) VALUES
(10,33532,13938),
(10,33532,13960),
(10,33532,13930),
(10,33532,13951),
(10,33532,13934),
(10,33532,13955),
(10,33532,13957);

DELETE FROM `creature_involvedrelation` WHERE `id`=33532;
INSERT INTO `creature_involvedrelation`(`id`,`quest`) VALUES
(33532,13938),
(33532,13930),
(33532,13927),
(33532,13951),
(33532,13934),
(33532,13955),
(33532,13957);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (19,20) AND `SourceEntry` IN (13955,13957,13938);
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`comment`) VALUES
(19,13955,8,13930,'Accept quest 13955 - Quest 13930 needs to be rewarded'),
(19,13955,8,13934,'Accept quest 13955 - Quest 13934 needs to be rewarded'),
(19,13955,8,13951,'Accept quest 13955 - Quest 13951 needs to be rewarded'),
(19,13957,8,13930,'Accept quest 13957 - Quest 13930 needs to be rewarded'),
(19,13957,8,13934,'Accept quest 13957 - Quest 13934 needs to be rewarded'),
(19,13957,8,13951,'Accept quest 13957 - Quest 13951 needs to be rewarded'),
(19,13938,8,13957,'Accept quest 13938 - Quest 13957 needs to be rewarded'),
(20,13955,8,13930,'Show quest mark 13955 - Quest 13930 needs to be rewarded'),
(20,13955,8,13934,'Show quest mark 13955 - Quest 13934 needs to be rewarded'),
(20,13955,8,13951,'Show quest mark 13955 - Quest 13951 needs to be rewarded'),
(20,13957,8,13930,'Show quest mark 13957 - Quest 13930 needs to be rewarded'),
(20,13957,8,13934,'Show quest mark 13957 - Quest 13934 needs to be rewarded'),
(20,13957,8,13951,'Show quest mark 13957 - Quest 13951 needs to be rewarded'),
(20,13938,8,13957,'Show quest mark 13938 - Quest 13957 needs to be rewarded');

-- Blood Elf Orphan
UPDATE `quest_template` SET `SpecialFlags`=`SpecialFlags`|2 WHERE `Id` IN (10945,10953,10951,10963);

DELETE FROM `game_event_creature_quest` WHERE `id`=22817;
INSERT INTO `game_event_creature_quest`(`eventEntry`,`id`,`quest`) VALUES
(10,22817,10945),
(10,22817,10953),
(10,22817,10951),
(10,22817,10963),
(10,22817,11975),
(10,22817,10967);

DELETE FROM `creature_involvedrelation` WHERE `id`=22817;
INSERT INTO `creature_involvedrelation`(`id`,`quest`) VALUES
(22817,10942),
(22817,10951),
(22817,11975),
(22817,10963);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (19,20) AND `SourceEntry` IN (11975,10963,10967);
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`comment`) VALUES
(19,11975,8,10945,'Accept quest 11975 - Quest 10945 needs to be rewarded'),
(19,11975,8,10953,'Accept quest 11975 - Quest 10953 needs to be rewarded'),
(19,11975,8,10951,'Accept quest 11975 - Quest 10951 needs to be rewarded'),
(19,10963,8,10945,'Accept quest 10963 - Quest 10945 needs to be rewarded'),
(19,10963,8,10953,'Accept quest 10963 - Quest 10953 needs to be rewarded'),
(19,10963,8,10951,'Accept quest 10963 - Quest 10951 needs to be rewarded'),
(19,10967,8,10963,'Accept quest 10967 - Quest 10963 needs to be rewarded'),
(20,11975,8,10945,'Show quest mark 11975 - Quest 10945 needs to be rewarded'),
(20,11975,8,10953,'Show quest mark 11975 - Quest 10953 needs to be rewarded'),
(20,11975,8,10951,'Show quest mark 11975 - Quest 10951 needs to be rewarded'),
(20,10963,8,10945,'Show quest mark 10963 - Quest 10945 needs to be rewarded'),
(20,10963,8,10953,'Show quest mark 10963 - Quest 10953 needs to be rewarded'),
(20,10963,8,10951,'Show quest mark 10963 - Quest 10951 needs to be rewarded'),
(20,10967,8,10963,'Show quest mark 10967 - Quest 10963 needs to be rewarded');

-- Draenei Orphan
UPDATE `quest_template` SET `SpecialFlags`=`SpecialFlags`|2 WHERE `Id` IN (10956,10968,10950,10952,10954,10962);

DELETE FROM `game_event_creature_quest` WHERE `id`=22818;
INSERT INTO `game_event_creature_quest`(`eventEntry`,`id`,`quest`) VALUES
(10,22818,10952),
(10,22818,10950),
(10,22818,10966),
(10,22818,10954),
(10,22818,10956),
(10,22818,10962);

DELETE FROM `creature_involvedrelation` WHERE `id`=22818;
INSERT INTO `creature_involvedrelation`(`id`,`quest`) VALUES
(22818,10950),
(22818,10952),
(22818,10943),
(22818,10962);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (19,20) AND `SourceEntry` IN (10956,10962,10966);
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`comment`) VALUES
(19,10956,8,10950,'Accept quest 10956 - Quest 10950 needs to be rewarded'),
(19,10956,8,10954,'Accept quest 10956 - Quest 10954 needs to be rewarded'),
(19,10956,8,10952,'Accept quest 10956 - Quest 10952 needs to be rewarded'),
(19,10962,8,10950,'Accept quest 10962 - Quest 10950 needs to be rewarded'),
(19,10962,8,10954,'Accept quest 10962 - Quest 10954 needs to be rewarded'),
(19,10962,8,10952,'Accept quest 10962 - Quest 10952 needs to be rewarded'),
(19,10966,8,10962,'Accept quest 10966 - Quest 10962 needs to be rewarded'),
(20,10956,8,10950,'Show quest mark 10956 - Quest 10950 needs to be rewarded'),
(20,10956,8,10954,'Show quest mark 10956 - Quest 10954 needs to be rewarded'),
(20,10956,8,10952,'Show quest mark 10956 - Quest 10952 needs to be rewarded'),
(20,10962,8,10950,'Show quest mark 10962 - Quest 10950 needs to be rewarded'),
(20,10962,8,10954,'Show quest mark 10962 - Quest 10954 needs to be rewarded'),
(20,10962,8,10952,'Show quest mark 10962 - Quest 10952 needs to be rewarded'),
(20,10966,8,10962,'Show quest mark 10966 - Quest 10962 needs to be rewarded');

-- Human Orphan
DELETE FROM `creature_questrelation` WHERE `id`=14305;

DELETE FROM `game_event_creature_quest` WHERE `id`=14305;
INSERT INTO `game_event_creature_quest`(`eventEntry`,`id`,`quest`) VALUES
(10,14305,171),
(10,14305,558),
(10,14305,1687),
(10,14305,1479),
(10,14305,1558),
(10,14305,4822);

DELETE FROM `creature_involvedrelation` WHERE `id`=14305;
INSERT INTO `creature_involvedrelation`(`id`,`quest`) VALUES
(14305,1468),
(14305,558),
(14305,1687),
(14305,1479),
(14305,1558),
(14305,4822);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (19,20) AND `SourceEntry` IN (558,4822,171);
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`comment`) VALUES
(19,558,8,1687,'Accept quest 558 - Quest 1687 needs to be rewarded'),
(19,558,8,1558,'Accept quest 558 - Quest 1558 needs to be rewarded'),
(19,558,8,1479,'Accept quest 558 - Quest 1479 needs to be rewarded'),
(19,558,16,1101,'Accept quest 558 - Needs to be in race mask 1101'),
(19,4822,8,1687,'Accept quest 4822 - Quest 1687 needs to be rewarded'),
(19,4822,8,1558,'Accept quest 4822 - Quest 1558 needs to be rewarded'),
(19,4822,8,1479,'Accept quest 4822 - Quest 1479 needs to be rewarded'),
(19,171,8,4822,'Accept quest 171 - Quest 4822 needs to be rewarded'),
(20,558,8,1687,'Show quest mark 558 - Quest 1687 needs to be rewarded'),
(20,558,8,1558,'Show quest mark 558 - Quest 1558 needs to be rewarded'),
(20,558,8,1479,'Show quest mark 558 - Quest 1479 needs to be rewarded'),
(20,558,16,1101,'Show quest mark 558 - Needs to be in race mask 1101'),
(20,4822,8,1687,'Show quest mark 4822 - Quest 1687 needs to be rewarded'),
(20,4822,8,1558,'Show quest mark 4822 - Quest 1558 needs to be rewarded'),
(20,4822,8,1479,'Show quest mark 4822 - Quest 1479 needs to be rewarded'),
(20,171,8,4822,'Show quest mark 171 - Quest 4822 needs to be rewarded');

-- Orcish Orphan
DELETE FROM `creature_questrelation` WHERE `id`=14444;

DELETE FROM `game_event_creature_quest` WHERE `id`=14444;
INSERT INTO `game_event_creature_quest`(`eventEntry`,`id`,`quest`) VALUES
(10,14444,910),
(10,14444,911),
(10,14444,1800),
(10,14444,925),
(10,14444,915),
(10,14444,5502);

DELETE FROM `creature_involvedrelation` WHERE `id`=14444;
INSERT INTO `creature_involvedrelation`(`id`,`quest`) VALUES
(14444,925),
(14444,172),
(14444,910),
(14444,911),
(14444,1800),
(14444,915);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (19,20) AND `SourceEntry` IN (915,925,5502);
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`comment`) VALUES
(19,925,8,910,'Accept quest 925 - Quest 910 needs to be rewarded'),
(19,925,8,911,'Accept quest 925 - Quest 911 needs to be rewarded'),
(19,925,8,1800,'Accept quest 925 - Quest 1800 needs to be rewarded'),
(19,915,8,910,'Accept quest 915 - Quest 910 needs to be rewarded'),
(19,915,8,911,'Accept quest 915 - Quest 911 needs to be rewarded'),
(19,915,8,1800,'Accept quest 915 - Quest 1800 needs to be rewarded'),
(19,5502,8,925,'Accept quest 5502 - Quest 925 needs to be rewarded'),
(20,925,8,910,'Show quest mark 925 - Quest 910 needs to be rewarded'),
(20,925,8,911,'Show quest mark 925 - Quest 911 needs to be rewarded'),
(20,925,8,1800,'Show quest mark 925 - Quest 1800 needs to be rewarded'),
(20,915,8,910,'Show quest mark 915 - Quest 910 needs to be rewarded'),
(20,915,8,911,'Show quest mark 915 - Quest 911 needs to be rewarded'),
(20,915,8,1800,'Show quest mark 915 - Quest 1800 needs to be rewarded'),
(20,5502,8,925,'Show quest mark 5502 - Quest 925 needs to be rewarded');

-- Home of the bear-men
SET @GUIDS = 85179;
SET @GUID_GRIZZLEMAW_TRIGGER_1 = @GUIDS + 0;
SET @GUID_GRIZZLEMAW_TRIGGER_2 = @GUIDS + 1;
SET @GUID_GRIZZLEMAW_TRIGGER_3 = @GUIDS + 2;

UPDATE `creature_template` SET `AIName`='',`ScriptName`='npc_grizzlemaw_cw_trigger',`flags_extra`=0 WHERE `entry`=36209;

DELETE FROM `creature` WHERE `guid` IN (@GUID_GRIZZLEMAW_TRIGGER_1,@GUID_GRIZZLEMAW_TRIGGER_2,@GUID_GRIZZLEMAW_TRIGGER_3);
INSERT INTO `creature`(`guid`,`id`,`map`,`position_x`,`position_y`,`position_z`) VALUES
(@GUID_GRIZZLEMAW_TRIGGER_1,36209,571,4068.82,-3811,223.4),
(@GUID_GRIZZLEMAW_TRIGGER_2,36209,571,4073.2,-3734.354,222.6634),
(@GUID_GRIZZLEMAW_TRIGGER_3,36209,571,3923.109,-3763.967,165.362);

-- Elder Kekek
SET @GUID_KEKEK = @GUIDS + 3;
SET @TEXT_ELDER_KEKEK_1 = 1;

UPDATE `creature_template` SET `ScriptName`='npc_elder_kekek' WHERE `entry`=34387;

DELETE FROM `creature` WHERE `guid`=@GUID_KEKEK OR `id`=34387;
INSERT INTO `creature`(`guid`,`id`,`map`,`position_x`,`position_y`,`position_z`,`orientation`) VALUES
(@GUID_KEKEK,34387,571,4181.482,-461.453,120.728,1.398097);

DELETE FROM `creature_text` WHERE `entry`=34387;
INSERT INTO `creature_text`(`entry`,`groupid`,`text`,`type`,`emote`) VALUE
(34387,@TEXT_ELDER_KEKEK_1,"No worry, Kekek. You grow up, be strong for Frenzyheart. You lead people back to old home, where there no big-tongue babies.",12,0);

-- Alexstraza
SET @TEXT_ALEXSTRASZA_2 = 2;
SET @TEXT_KRASUS_8 = 8;

UPDATE `creature_template` SET `AIName`='',`ScriptName`='npc_alexstraza_the_lifebinder' WHERE `entry`=26917;

DELETE FROM `creature_text` WHERE (`entry`=26917 AND `groupid`=@TEXT_ALEXSTRASZA_2) OR (`entry`=27990 AND `groupid`=@TEXT_KRASUS_8);
INSERT INTO `creature_text`(`entry`,`groupid`,`text`,`type`,`emote`) VALUE
(26917,@TEXT_ALEXSTRASZA_2,"If I was in my dragon form, there wouldn't be any room for anyone else, little one.",12,0),
(27990,@TEXT_KRASUS_8,"Rest assured, Kekek, she is the queen of the dragons. We often take the forms of smaller beings when we work with them.",12,0);

-- High Oracle Soo Roo
SET @GUID_SOO_ROO = @GUIDS + 4;
SET @TEXT_SOO_ROO_1 = 1;

UPDATE `creature_template` SET `AIName`='',`ScriptName`='npc_high_oracle_soo_roo' WHERE `entry`=34386;

DELETE FROM `creature_text` WHERE `entry`=34386;
INSERT INTO `creature_text`(`entry`,`groupid`,`text`,`type`,`emote`) VALUE
(34386,@TEXT_SOO_ROO_1,"We remember this visit, yes we do. Never forget what you learn from your new friend, little Roo. You got great future ahead.",12,0);

DELETE FROM `creature` WHERE `guid`=@GUID_SOO_ROO OR `id`=34386;
INSERT INTO `creature`(`guid`,`id`,`map`,`position_x`,`position_y`,`position_z`,`orientation`) VALUES
(@GUID_SOO_ROO,34386,571,4120.996,-329.486,121.443817,0.299253);

-- Nesingwary
SET @TEXT_NESINGWARY_1 = 1;

DELETE FROM `creature_text` WHERE `entry`=27986;
INSERT INTO `creature_text`(`entry`,`groupid`,`text`,`type`,`emote`) VALUE
(27986,@TEXT_NESINGWARY_1,"Well, lad, you can start by readin' The Green Hills of Stranglethorn. Then, maybe you can join me on one of my safaris. What do you say?",12,0);

-- Snowfall Glade Playmate
SET @GUID_SNOWFALL_GLADE_PLAYMATE = @GUIDS + 5;
SET @TEXT_SNOWFALL_GLADE_PLAYMATE_1 = 1;
SET @TEXT_SNOWFALL_GLADE_PLAYMATE_2 = 2;

UPDATE `creature_template` SET `AIName`='',`ScriptName`='npc_snowfall_glade_playmate' WHERE `entry`=34490;

DELETE FROM `creature_text` WHERE `entry`=34490;
INSERT INTO `creature_text`(`entry`,`groupid`,`text`,`type`,`emote`) VALUE
(34490,@TEXT_SNOWFALL_GLADE_PLAYMATE_1,"Better watch out!",12,0),
(34490,@TEXT_SNOWFALL_GLADE_PLAYMATE_2,"Got you good!",12,0);

DELETE FROM `creature` WHERE `guid`=@GUID_SNOWFALL_GLADE_PLAYMATE OR `id`=34490;
INSERT INTO `creature`(`guid`,`id`,`map`,`position_x`,`position_y`,`position_z`,`orientation`) VALUES
(@GUID_SNOWFALL_GLADE_PLAYMATE,34490,571,3325.193,1026.451,138.1712,2.062184);

-- Winterfin Playmate
SET @GUID_WINTERFIN_PLAYMATE = @GUIDS + 6;
SET @TEXT_WINTERFIN_PLAYMATE_1 = 1;
SET @TEXT_WINTERFIN_PLAYMATE_2 = 2;

UPDATE `creature_template` SET `AIName`='',`ScriptName`='npc_winterfin_playmate' WHERE `entry`=34489;

DELETE FROM `creature_text` WHERE `entry`=34489;
INSERT INTO `creature_text`(`entry`,`groupid`,`text`,`type`,`emote`) VALUE
(34489,@TEXT_WINTERFIN_PLAYMATE_1,"Wanna see what I can do?",12,0),
(34489,@TEXT_WINTERFIN_PLAYMATE_2,"Now dance together!",12,0);

DELETE FROM `creature` WHERE `guid`=@GUID_WINTERFIN_PLAYMATE OR `id`=34489;
INSERT INTO `creature`(`guid`,`id`,`map`,`position_x`,`position_y`,`position_z`,`orientation`) VALUES
(@GUID_WINTERFIN_PLAYMATE,34489,571,4382.502,6066.199,0.724562,3.571894);

-- Biggest Tree Ever
SET @GUID_BIGGEST_TREE_TRIGGER = @GUIDS + 7;

UPDATE `creature_template` SET `AIName`='',`ScriptName`='npc_the_biggest_tree',`flags_extra`=0 WHERE `entry`=34381;

DELETE FROM `creature` WHERE `guid`=@GUID_BIGGEST_TREE_TRIGGER OR `id`=34381;
INSERT INTO `creature`(`guid`,`id`,`map`,`position_x`,`position_y`,`position_z`,`orientation`) VALUES
(@GUID_BIGGEST_TREE_TRIGGER,34381,571,4022.666,-3777.682,115.443588,4.857019);

-- Meeting A Great One
UPDATE `creature_template` SET `ScriptName`='npc_the_etymidian' WHERE `entry`=28092;

-- POIs
DELETE FROM `quest_poi` WHERE `questId` IN (13956,13929,13950,13951,13957,13933,13934,13930,13954,13955);
INSERT INTO `quest_poi`(`questId`,`objIndex`,`mapid`,`WorldMapAreaId`,`unk4`) VALUES
(13956,16,1,201,3),
(13929,16,571,490,3),
(13950,16,571,486,3),
(13951,16,571,488,3),
(13957,16,571,493,3),
(13933,16,571,488,3),
(13934,16,571,488,3),
(13930,16,571,490,3),
(13954,16,571,488,3),
(13955,16,571,488,3);

DELETE FROM `quest_poi_points` WHERE `questid` IN (13956,13929,13950,13951,13957,13933,13934,13930,13954,13955);
INSERT INTO `quest_poi_points`(`questId`,`x`,`y`) VALUES
(13956,-6193,-1223),
(13929,4022,-3777),
(13950,4382,6066),
(13951,3325,1026),
(13957,5584,5748),
(13933,4121,-329),
(13934,4181,-461),
(13930,4071,-3773),
(13954,3530,271),
(13955,3530,271);

-- NPC areatriggers
SET @GUID_AERIS_LANDING_TRIGGER = @GUIDS + 8;
SET @GUID_SILVERMOON_TRIGGER_01 = @GUIDS + 9;
SET @GUID_AUCHINDOUN_TRIGGER = @GUIDS + 10;
SET @GUID_SPOREGGAR_TRIGGER = @GUIDS + 11;
SET @GUID_THRONE_OF_ELEMENTS_TRIGGER = @GUIDS + 12;

UPDATE `creature_template` SET `InhabitType`=7,`flags_extra`=0,`unit_flags`=33554432,`ScriptName`='npc_cw_area_trigger',`AIName`='' WHERE `entry` IN (22905,22851,22838,22866,22831,22829,22872,22839);

DELETE FROM `creature` WHERE `guid` IN (@GUID_SILVERMOON_TRIGGER_01,@GUID_AERIS_LANDING_TRIGGER,@GUID_AUCHINDOUN_TRIGGER,@GUID_SPOREGGAR_TRIGGER,@GUID_THRONE_OF_ELEMENTS_TRIGGER);
INSERT INTO `creature`(`guid`,`id`,`map`,`position_x`,`position_y`,`position_z`,`orientation`) VALUES
(@GUID_AERIS_LANDING_TRIGGER,22838,530,-2075.759,8559.336,23.027,4.857019),
(@GUID_SILVERMOON_TRIGGER_01,22866,530,9506.086,-7329.313,14.397272,0),
(@GUID_AUCHINDOUN_TRIGGER,22831,530,-3320.860,4925.095,-101.1,0),
(@GUID_SPOREGGAR_TRIGGER,22829,530,203.587,8550.11,22.3256,0),
(@GUID_THRONE_OF_ELEMENTS_TRIGGER,22839,530,-781.294,6943.52,33.3344,0);

-- Misc
DELETE `game_event_creature` FROM `game_event_creature` INNER JOIN `creature` ON `creature`.`guid`=`game_event_creature`.`guid` 
WHERE `id` IN (22905,22851,22838,22866,22831,22829,22872,22839,14450,22819,14451,34365,34387,34386,34490,34489,34381,36209);
INSERT INTO `game_event_creature`(`eventEntry`,`guid`) SELECT 10,`guid` FROM `creature` 
WHERE `id` IN (22905,22851,22838,22866,22831,22829,22872,22839,14450,22819,14451,34365,34387,34386,34490,34489,34381,36209);

DELETE FROM `game_event_npc_vendor` WHERE `eventEntry`=10 AND `item`=46693;
INSERT INTO `game_event_npc_vendor` (`eventEntry`, `guid`, `item`) VALUES 
(10,99369,46693),
(10,97984,46693);

UPDATE `item_template` SET `minMoneyLoot`=50000,`maxMoneyLoot`=50000 WHERE `entry`=23022;
UPDATE `item_template` SET `HolidayId`=201 WHERE `entry` IN (46396,46397,31880,31881,18598,18597);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry` IN (23012,23013,39478,39479,65352,65353);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ErrorTextId`,`Comment`) VALUES 
(17,0,23012,0,12,10,0,"Orphan Whistle only while children's week"),
(17,0,23013,0,12,10,0,"Orphan Whistle only while children's week"),
(17,0,39478,0,12,10,0,"Orphan Whistle only while children's week"),
(17,0,39479,0,12,10,0,"Orphan Whistle only while children's week"),
(17,0,65352,0,12,10,0,"Orphan Whistle only while children's week"),
(17,0,65353,0,12,10,0,"Orphan Whistle only while children's week");

UPDATE `quest_poi_points` SET `x`=1642,`y`=239 WHERE `questId`=1800 AND `id`=0 AND `idx`=0;
UPDATE `quest_poi_points` SET `x`=-248,`y`=956 WHERE `questId`=10952 AND `id`=0 AND `idx`=0;
UPDATE `quest_poi_points` SET `x`=-11400.211,`y`=1944.599 WHERE `questId`=1687 AND `id`=0 AND `idx`=0;
UPDATE `quest_poi_points` SET `x`=-998.183,`y`=-3822.07 WHERE `questId`=910 AND `id`=0 AND `idx`=0;
UPDATE `quest_poi_points` SET `x`=1260.812,`y`=-2223.765 WHERE `questId`=911 AND `id`=0 AND `idx`=0;
UPDATE `quest_poi_points` SET `x`=9933,`y`=2500 WHERE `questId`=1479 AND `id`=0 AND `idx`=0;
UPDATE `quest_poi_points` SET `x`=-2075.759,`y`=8559.336 WHERE `questId`=10954 AND `id`=0 AND `idx`=0;
UPDATE `quest_poi_points` SET `x`=9506,`y`=-7329 WHERE `questId`=11975 AND `id`=0 AND `idx`=0;
UPDATE `quest_poi_points` SET `x`=-3320.860,`y`=4925.095 WHERE `questId`=10950 AND `id`=0 AND `idx`=0;
UPDATE `quest_poi_points` SET `x`=203.587,`y`=8550.11 WHERE `questId`=10945 AND `id`=0 AND `idx`=0;
UPDATE `quest_poi_points` SET `x`=-781.294,`y`=6943.52 WHERE `questId`=10953 AND `id`=0 AND `idx`=0;
 
 
/* 
* updates\world\2012_10_26_00_world_sai.sql 
*/ 
UPDATE `smart_scripts` SET `action_param3`=3500,`action_param4`=6000 WHERE `entryorguid`=9458 AND `source_type`=0 AND `id`=0;
 
 
/* 
* updates\world\2012_10_27_00_world_creature.sql 
*/ 
-- Dragonbone Condor
UPDATE `creature` SET `spawndist`=0, `MovementType`=0 WHERE `guid` IN (106595,106596,106597,106598,106603,106604,106605,106607,106608,106626,106629,106631,106643,106646,106658,106663,106665,106668,106669,106675,106676,106679,106680,106681,106682,106683,106684,106685,106686,106687,106688,106692,106693,106696,106702,106703,106706,106722,106723,106724,106726,106727,106728,106733,106737,106741,106749,106755,106757,131072);
UPDATE `creature` SET `position_z`=72.130 WHERE `guid`=106631;
UPDATE `creature` SET `position_z`=72.902 WHERE `guid`=106675;
UPDATE `creature` SET `position_z`=69.505 WHERE `guid`=131072;
/* Carrion Condor
 * All these have unitfieldbyte1=1 which means sitting. Obviously that makes no sense when they are moving randomly within their spawndist. They should be sitting on the pillars in Borean Tundra.
 * There are some that are spawned very close to dead Taunka. From retail I know they should be flying directly on top of them not moving so I changed them, too. */
UPDATE `creature` SET `spawndist`=0, `MovementType`=0 WHERE `guid` IN (101804,101805,101806,101807,101808,101809,101810,101814,101815,101818,101819,101820,101823,101824,101825,101832,101834,101836,101837,101838,101839,101842,101845,101849,101850,101856,101859,101860,101862,101866,101872,101876,101877,101890,101921,101923);
-- Courier Lanson: The npc should be sleeping on the bed instead of just standing there.
DELETE FROM `creature_template_addon` WHERE `entry`=27060;
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(27060,0,0,3,0,0,'');
 
 
/* 
* updates\world\2012_10_27_01_world_creature_loot_template.sql 
*/ 
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=1 AND `SourceEntry`=51315;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`Scriptname`,`Comment`) VALUES
-- Lich King 10N
(1,36597,51315,0,1,2,0,51315,1,1,1,0 ,'' , 'Sealed Chest will drop only if the player doesn''t have it already'),
(1,36597,51315,0,1,3,0,49623,1,1,1,0 ,'' , 'Sealed Chest will drop only if the player is wielding Shadowmourne'),
(1,36597,51315,0,1,9,0,24748,0,0,0,0 ,'' , 'Sealed Chest will drop only if the player has "The Lich King''s Last Stand" in their quest log'),
(1,36597,51315,0,1,14,0,24914,0,0,0,0,'' , 'Sealed Chest will drop only if the player has not completed the quest Personal Property'),
-- Lich King 25N
(1,39166,51315,0,1,2,0,51315,1,1,1,0 ,'' , 'Sealed Chest will drop only if the player doesn''t have it already'),
(1,39166,51315,0,1,3,0,49623,1,1,1,0 ,'' , 'Sealed Chest will drop only if the player is wielding Shadowmourne'),
(1,39166,51315,0,1,9,0,24748,0,0,0,0 ,'' , 'Sealed Chest will drop only if the player has "The Lich King''s Last Stand" in their quest log'),
(1,39166,51315,0,1,14,0,24914,0,0,0,0,'' , 'Sealed Chest will drop only if the player has not completed the quest Personal Property'),
-- Lich King 10H
(1,39167,51315,0,1,2,0,51315,1,1,1,0 ,'' , 'Sealed Chest will drop only if the player doesn''t have it already'),
(1,39167,51315,0,1,3,0,49623,1,1,1,0 ,'' , 'Sealed Chest will drop only if the player is wielding Shadowmourne'),
(1,39167,51315,0,1,9,0,24748,0,0,0,0 ,'' , 'Sealed Chest will drop only if the player has "The Lich King''s Last Stand" in their quest log'),
(1,39167,51315,0,1,14,0,24914,0,0,0,0,'' , 'Sealed Chest will drop only if the player has not completed the quest Personal Property'),
-- Lich King 25H
(1,39168,51315,0,1,2,0,51315,1,1,1,0 ,'' , 'Sealed Chest will drop only if the player doesn''t have it already'),
(1,39168,51315,0,1,3,0,49623,1,1,1,0 ,'' , 'Sealed Chest will drop only if the player is wielding Shadowmourne'),
(1,39168,51315,0,1,9,0,24748,0,0,0,0 ,'' , 'Sealed Chest will drop only if the player has "The Lich King''s Last Stand" in their quest log'),
(1,39168,51315,0,1,14,0,24914,0,0,0,0,'' , 'Sealed Chest will drop only if the player has not completed the quest Personal Property');
 
 
/* 
* updates\world\2012_10_29_00_world_conditions.sql 
*/ 
-- fix bad condition2/3 values on ItemEquip Conditions
UPDATE `conditions` SET `ConditionValue2`=0,`ConditionValue3`=0 WHERE `ConditionTypeOrReference`=3;
 
 
/* 
* updates\world\2012_11_03_00_world_creature_loot_template.sql 
*/ 
-- Readd loot to Stinky
DELETE FROM `creature_loot_template` WHERE `entry` IN(37025,38064);
INSERT INTO `creature_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`)
VALUES
(37025,1,100,1,0,-35069,2),
(38064,1,100,1,0,-35069,2);
 
 
/* 
* updates\world\2012_11_07_00_world_misc.sql 
*/ 
SET @GUID   := 43456;

DELETE FROM `creature` WHERE `guid` BETWEEN @GUID+0 AND @GUID+3;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(@GUID+0,30236,571,1,64,0,0,6219.17,59.9983,400.375,1.6057,120,0,0,1,0,0,0,0,0),
(@GUID+1,30236,571,1,64,0,0,6256.11,93.2413,410.92,0.767945,120,0,0,1,0,0,0,0,0),
(@GUID+2,30236,571,1,64,0,0,6297.37,53.5677,410.957,0.802851,120,0,0,1,0,0,0,0,0),
(@GUID+3,30236,571,1,64,0,0,6162.81,60.9792,400.371,1.55334,120,0,0,1,0,0,0,0,0);

DELETE FROM `creature_template_addon` WHERE `entry`=30236;
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`auras`) VALUES
(30236,0,0,0x0,0x1,'');

DELETE FROM `creature_model_info` WHERE `modelid`=27101;
INSERT INTO `creature_model_info` (`modelid`,`bounding_radius`,`combat_reach`,`gender`) VALUES
(27101,0.3055,1,2);

UPDATE `creature_template` SET `VehicleId`=246,`npcflag`=0x1000000,`resistance2`=4394,`resistance4`=1 WHERE `entry`=30236;

DELETE FROM `npc_spellclick_spells` WHERE `npc_entry`=30236;
INSERT INTO `npc_spellclick_spells` (`npc_entry`,`spell_id`,`cast_flags`,`user_type`) VALUES
(30236,57573,1,0);

SET @OGUID  := 7278;
DELETE FROM `gameobject` WHERE `id` IN (192657,192658,192769,192770,192767,192768,192771,192772);
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(@OGUID+0, 192657, 571, 1, 64, 6255.958, 93.05556, 403.0368, 5.454153, 0, 0, 0, 1, 120, 255, 1),
(@OGUID+1, 192658, 571, 1, 64, 6255.961, 93.06424, 408.4696, 5.44543, 0, 0, 0, 1, 120, 255, 1),
(@OGUID+2, 192769, 571, 1, 64, 6219.205, 59.86806, 392.5132, 6.283184, 0, 0, 0, 1, 120, 255, 1),
(@OGUID+3, 192770, 571, 1, 64, 6219.202, 59.875, 397.924, 6.274461, 0, 0, 0, 1, 120, 255, 1),
(@OGUID+4, 192767, 571, 1, 64, 6297.223, 53.39583, 402.9972, 5.532692, 0, 0, 0, 1, 120, 255, 1),
(@OGUID+5, 192768, 571, 1, 64, 6297.226, 53.40451, 408.4129, 5.523969, 0, 0, 0, 1, 120, 255, 1),
(@OGUID+6, 192771, 571, 1, 64, 6162.772, 60.73438, 392.4362, 6.265733, 0, 0, 0, 1, 120, 255, 1),
(@OGUID+7, 192772, 571, 1, 64, 6162.768, 60.74306, 397.8138, 6.257008, 0, 0, 0, 1, 120, 255, 1);

UPDATE `gameobject_template` SET `flags`=32,`faction`=114 WHERE `entry` IN (192657,192658,192769,192770,192767,192768,192771,192772);
 
 
/* 
* updates\world\2012_11_11_00_world_sai.sql 
*/ 
-- Update creature gossip_menu_option from sniff
DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (8803,8808,8894,9045,9621,9879,9895,9987,10117,10218) AND `id`=0;
DELETE FROM `gossip_menu_option` WHERE `menu_id`=9879 AND `id`=1;                 
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES
(8803,0,1, 'I need some booze, Coot.',3,128,0,0,0,0, ''),
(8808,0,1, 'I require some components, Sorely.',3,128,0,0,0,0, ''),
(8894,0,0, 'I need to fly to the Windrunner Official business!',1,1,0,0,0,0, ''),
(9045,0,0, 'I don''t have time for chit-chat, Lou. Take me to Scalawag Point.',1,1,0,0,0,0, ''),
(9621,0,0, 'Harry said I could use his bomber to Bael''gun''s. I''m ready to go!',1,1,0,0,0,0, ''),
(9879,0,3, 'Train me',5,16,0,0,0,0, ''),
(9879,1,1, 'Let me browse your goods.',3,128,0,0,0,0, ''),
(9895,0,3, 'Train me',5,16,0,0,0,0, ''),
(9987,0,3, 'Train me',5,16,0,0,0,0, ''),
(10117,0,3, 'Train me',5,16,0,0,0,0, ''),
(10218,0,0, '<Get in the bomber and return to Scalawag Point.>',1,1,0,0,0,0, '');
-- Insert gossip menu from sniff
DELETE FROM `gossip_menu` WHERE `entry`=8803 AND `text_id`=11287;
DELETE FROM `gossip_menu` WHERE `entry`=8808 AND `text_id`=11297;
DELETE FROM `gossip_menu` WHERE `entry`=8820 AND `text_id`=11352;
DELETE FROM `gossip_menu` WHERE `entry`=8832 AND `text_id`=11418;
DELETE FROM `gossip_menu` WHERE `entry`=8839 AND `text_id`=11436;
DELETE FROM `gossip_menu` WHERE `entry`=8893 AND `text_id`=11655;
DELETE FROM `gossip_menu` WHERE `entry`=8900 AND `text_id`=11691;
DELETE FROM `gossip_menu` WHERE `entry`=8957 AND `text_id`=11746;
DELETE FROM `gossip_menu` WHERE `entry`=8985 AND `text_id`=12130;
DELETE FROM `gossip_menu` WHERE `entry`=9008 AND `text_id`=12170;
DELETE FROM `gossip_menu` WHERE `entry`=9045 AND `text_id`=12222;
DELETE FROM `gossip_menu` WHERE `entry`=9346 AND `text_id`=12646;
DELETE FROM `gossip_menu` WHERE `entry`=9895 AND `text_id`=13738;
DELETE FROM `gossip_menu` WHERE `entry`=9987 AND `text_id`=13841;
DELETE FROM `gossip_menu` WHERE `entry`=10117 AND `text_id`=14043;
DELETE FROM `gossip_menu` WHERE `entry`=10218 AND `text_id`=14205;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES
(8803,11287),
(8808,11297),
(8820,11352),
(8832,11418),
(8839,11436),
(8893,11655),
(8900,11691),
(8957,11746),
(8985,12130),
(9008,12170),
(9045,12222),
(9346,12646),
(9895,13738),
(9987,13841),
(10117,14043),
(10218,14205);
-- Insert creature gossip_menu_id Update from sniff
UPDATE `creature_template` SET `gossip_menu_id`=8803 WHERE `entry`=23737; -- Coot "The Stranger" Albertson
UPDATE `creature_template` SET `gossip_menu_id`=8808 WHERE `entry`=23732; -- Sorely Twitchblade
UPDATE `creature_template` SET `gossip_menu_id`=8820 WHERE `entry`=23862; -- Finlay Fletcher
UPDATE `creature_template` SET `gossip_menu_id`=8832 WHERE `entry`=23770; -- Cannoneer Ely
UPDATE `creature_template` SET `gossip_menu_id`=8839 WHERE `entry`=23906; -- Scout Knowles
UPDATE `creature_template` SET `gossip_menu_id`=8893 WHERE `entry`=24106; -- Scout Valory
UPDATE `creature_template` SET `gossip_menu_id`=8900 WHERE `entry`=24135; -- Greatmother Ankha
UPDATE `creature_template` SET `gossip_menu_id`=8957 WHERE `entry`=23833; -- Explorer Jaren
UPDATE `creature_template` SET `gossip_menu_id`=8985 WHERE `entry`=24544; -- Old Icefin
UPDATE `creature_template` SET `gossip_menu_id`=9008, `npcflag`=`npcflag`|1 WHERE `entry`=24643; -- Grezzix Spindlesnap
UPDATE `creature_template` SET `gossip_menu_id`=9045, `npcflag`=1, `AIName`='SmartAI' WHERE `entry`=24896; -- Lou the Cabin Boy
UPDATE `creature_template` SET `gossip_menu_id`=9346 WHERE `entry`=26540; -- Drenk Spannerspark
UPDATE `creature_template` SET `gossip_menu_id`=9821 WHERE `entry` IN (24067,24154,24350); -- Mahana Frosthoof, Mary Darrow, Robert Clarke
UPDATE `creature_template` SET `gossip_menu_id`=9879 WHERE `entry`=26959; -- Booker Kells
UPDATE `creature_template` SET `gossip_menu_id`=9895 WHERE `entry`=26960; -- Carter Tiffens
UPDATE `creature_template` SET `gossip_menu_id`=9987 WHERE `entry`=26953; -- Thomas Kolichio
UPDATE `creature_template` SET `gossip_menu_id`=10117 WHERE `entry`=26964; -- Alexandra McQueen
UPDATE `creature_template` SET `gossip_menu_id`=10218, `AIName`='SmartAI' WHERE `entry`=28277; -- Harry's Bomber
-- Insert npc_text from sniff
DELETE FROM `npc_text` WHERE `ID` IN (12130,13702);
INSERT INTO `npc_text` (`ID`,`text0_0`,`text0_1`,`lang0`,`prob0`,`em0_0`,`em0_1`,`em0_2`,`em0_3`,`em0_4`,`em0_5`,`text1_0`,`text1_1`,`lang1`,`prob1`,`em1_0`,`em1_1`,`em1_2`,`em1_3`,`em1_4`,`em1_5`,`text2_0`,`text2_1`,`lang2`,`prob2`,`em2_0`,`em2_1`,`em2_2`,`em2_3`,`em2_4`,`em2_5`,`text3_0`,`text3_1`,`lang3`,`prob3`,`em3_0`,`em3_1`,`em3_2`,`em3_3`,`em3_4`,`em3_5`,`text4_0`,`text4_1`,`lang4`,`prob4`,`em4_0`,`em4_1`,`em4_2`,`em4_3`,`em4_4`,`em4_5`,`text5_0`,`text5_1`,`lang5`,`prob5`,`em5_0`,`em5_1`,`em5_2`,`em5_3`,`em5_4`,`em5_5`,`text6_0`,`text6_1`,`lang6`,`prob6`,`em6_0`,`em6_1`,`em6_2`,`em6_3`,`em6_4`,`em6_5`,`text7_0`,`text7_1`,`lang7`,`prob7`,`em7_0`,`em7_1`,`em7_2`,`em7_3`,`em7_4`,`em7_5`,`WDBVerified`) VALUES
(12130,'<Old Icefin eyes you warily, his fishy eye blinking as he bobs his head up and down once in a curt dismissal.>','',0,1,0,396,0,0,0,0,'','',0,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,12340),
(13702,'How may I help you?','',0,1,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,12340);
-- Insert creature_text from sniff
DELETE FROM `creature_text` WHERE `entry` IN (27923,27933);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(27923,0,0,'Hang on to your hat, $N! To Scalawag we go!',12,0,100,0,0,0,'Lou the Cabin Boy'),
(27923,1,0,'YAAARRRRR! Here we be, matey! Scalawag Point!',12,0,100,0,0,0,'Lou the Cabin Boy'),
(27933,0,0,'Enjoy the ride! It''s a one way trip!',12,0,100,3,0,0,'Alanya');
-- Conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup` IN (8894,9045,9621,10218) AND `SourceEntry`=0;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup` IN (8894,9546) AND `SourceEntry`=1;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,8894,0,0,0,9,0,11229,0,0,0,0,'','Bathandler Camille - Show gossip option only if player has taken quest 11229'),
(15,8894,1,0,0,9,0,11170,0,0,0,0,'','Bathandler Camille - Show gossip option only if player has taken quest 11170'),
(15,9045,0,0,0,9,0,11509,0,0,0,0,'','Lou the Cabin Boy - Show gossip option only if player has taken quest 11509'),
(15,9546,1,0,0,9,0,12298,0,0,0,0,'','Greer Orehammer - Show gossip option only if player has taken quest 12298'),
(15,9621,0,0,0,9,0,11567,0,0,0,0,'','Alanya - Show gossip option only if player has taken quest 11567'),
(15,10218,0,0,0,9,0,11567,0,0,0,0,'','Harry''s Bomber - Show gossip option if player has taken quest 11567');
-- SmartAIs
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=27933;
UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=23816;
DELETE FROM `smart_scripts` WHERE `entryorguid`=23859 AND `source_type`=0 AND `id` IN (3,4); -- this npc had already a SmartAI so deleting just the new lines
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (23816,24896,27933,28277) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(23816,0,0,2,62,0,100,0,8894,0,0,0,85,43074,0,0,0,0,0,7,0,0,0,0,0,0,0,'Bathandler Camille - On gossip select - Invoker spellcast'),
(23816,0,1,2,62,0,100,0,8894,1,0,0,85,43136,0,0,0,0,0,7,0,0,0,0,0,0,0,'Bathandler Camille - On gossip select - Invoker spellcast'),
(23816,0,2,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Bathandler Camille - On gossip select - Close gossip'),
(23859,0,3,4,62,0,100,0,9546,1,0,0,11,48862,0,0,0,0,0,7,0,0,0,0,0,0,0,'Greer Orehammer - On gossip select - Invoker spellcast'),
(23859,0,4,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Greer Orehammer - On gossip select - Close gossip'),
(24896,0,0,1,62,0,100,0,9045,0,0,0,11,50004,0,0,0,0,0,7,0,0,0,0,0,0,0,'Lou the Cabin Boy - On gossip select - Spellcast'),
(24896,0,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Lou the Cabin Boy - On gossip select - Close gossip'),
(27933,0,0,1,62,0,100,0,9621,0,0,0,11,50038,0,0,0,0,0,7,0,0,0,0,0,0,0,'Alanya - On gossip select - Spellcast'),
(27933,0,1,2,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Alanya - On gossip select - Close gossip'),
(27933,0,2,0,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Alanya - On gossip select - Say line'),
(28277,0,0,1,62,0,100,0,10218,0,0,0,11,61604,0,0,0,0,0,7,0,0,0,0,0,0,0,'Harry''s Bomber - On gossip select - Spellcast'),
(28277,0,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Harry''s Bomber - On gossip select - Close gossip');
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry`=24896; -- that was absolutely not correct
DELETE FROM `spell_target_position` WHERE `id` IN (50005,50039,61605);
INSERT INTO `spell_target_position` (`id`,`target_map`,`target_position_x`,`target_position_y`,`target_position_z`,`target_orientation`) VALUES
(50005,571,595.208,-2796.47,-0.124098,3.66519), -- Summon Lou the Cabin Boy
(50039,571,-170.469,-3588.19,-0.221146,4.2586), -- Summon Harry's Bomber
(61605,571,89.7416,-6286.08,1.17903,1.58825); -- Summon Harry's Bomber
 
 
/* 
* updates\world\2012_11_11_01_world_quest_template.sql 
*/ 
-- Fix a typo in RewardText table for quest Spooky Lighthouse (1687)
UPDATE `quest_template` SET `OfferRewardText`="WOW, that was a real life ghost! That was so awesome - I can't wait to tell everyone back at the orphanage. Captain Grayson... he even looked like a pirate! When I grow up I wanna be a ghost pirate too!$B$BThanks for taking me to Westfall, $N. I know there are scary things out there in the wilds of Westfall, and I hope I wasn't too much of a pain. You're awesome!" WHERE `Id`=1687;
 
 
/* 
* updates\world\2012_11_11_02_world_gossip_menu.sql 
*/ 
UPDATE `creature_template` SET `gossip_menu_id`=9260 WHERE `entry`=25754;
DELETE FROM `gossip_menu` WHERE `entry`=9260 AND `text_id`=12572;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (9260,12572);

UPDATE `creature_template` SET `gossip_menu_id`=11417 WHERE `entry`=25697;
DELETE FROM `gossip_menu` WHERE `entry`=11417 AND `text_id`=12390;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (11417,12390);

UPDATE `creature_template` SET `gossip_menu_id`=9298 WHERE `entry`=16818;
DELETE FROM `gossip_menu` WHERE `entry`=9298 AND `text_id`=12609;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (9298,12609);

UPDATE `creature_template` SET `gossip_menu_id`=9204 WHERE `entry`=26113;
UPDATE `creature_template` SET `gossip_menu_id`=9204 WHERE `entry`=25994;
DELETE FROM `gossip_menu` WHERE `entry`=9204 AND `text_id`=12506;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (9204,12506);

UPDATE `creature_template` SET `gossip_menu_id`=9148 WHERE `entry`=16781;
DELETE FROM `gossip_menu` WHERE `entry`=9148 AND `text_id`=12376;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (9148,12376);

UPDATE `creature_template` SET `gossip_menu_id`=9157 WHERE `entry`=26221;
DELETE FROM `gossip_menu` WHERE `entry`=9157 AND `text_id`=12390;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (9157,12390);

UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25884;
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25918;
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25919;
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25920;
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25921;
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25922;
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25924;
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25926;
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25928;
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25929;
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25930;
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25932;
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25934;
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25936;
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25937;
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25938;
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25940;
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25943;
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25947;
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=32809;
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=32810;
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=32811;
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=32812;
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=32813;
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=32814;
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=32815;
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=32816;
DELETE FROM `gossip_menu` WHERE `entry`=9278 AND `text_id`=12582;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (9278,12582);

DELETE FROM `gossip_menu` WHERE `entry`=9354 AND `text_id`=12377;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (9354,12377);
DELETE FROM `gossip_menu` WHERE `entry`=9384 AND `text_id`=12377;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (9384,12377);
DELETE FROM `gossip_menu` WHERE `entry`=9385 AND `text_id`=12377;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (9385,12377);
DELETE FROM `gossip_menu` WHERE `entry`=9386 AND `text_id`=12377;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (9386,12377);
DELETE FROM `gossip_menu` WHERE `entry`=9387 AND `text_id`=12377;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (9387,12377);
DELETE FROM `gossip_menu` WHERE `entry`=9389 AND `text_id`=12377;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (9389,12377);
DELETE FROM `gossip_menu` WHERE `entry`=9390 AND `text_id`=12377;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (9390,12377);
DELETE FROM `gossip_menu` WHERE `entry`=9393 AND `text_id`=12377;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (9393,12377);
DELETE FROM `gossip_menu` WHERE `entry`=9395 AND `text_id`=12377;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (9395,12377);
DELETE FROM `gossip_menu` WHERE `entry`=9396 AND `text_id`=12377;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (9396,12377);
DELETE FROM `gossip_menu` WHERE `entry`=9399 AND `text_id`=12377;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (9399,12377);
DELETE FROM `gossip_menu` WHERE `entry`=9401 AND `text_id`=12377;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (9401,12377);
DELETE FROM `gossip_menu` WHERE `entry`=9403 AND `text_id`=12377;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (9403,12377);
DELETE FROM `gossip_menu` WHERE `entry`=9408 AND `text_id`=12377;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (9408,12377);
DELETE FROM `gossip_menu` WHERE `entry`=9409 AND `text_id`=12377;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (9409,12377);
DELETE FROM `gossip_menu` WHERE `entry`=9410 AND `text_id`=12377;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (9410,12377);
DELETE FROM `gossip_menu` WHERE `entry`=9411 AND `text_id`=12377;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (9411,12377);
DELETE FROM `gossip_menu` WHERE `entry`=9412 AND `text_id`=12377;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (9412,12377);
DELETE FROM `gossip_menu` WHERE `entry`=9413 AND `text_id`=12377;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (9413,12377);
DELETE FROM `gossip_menu` WHERE `entry`=10230 AND `text_id`=12377;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (10230,12377);
DELETE FROM `gossip_menu` WHERE `entry`=10232 AND `text_id`=12377;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (10232,12377);
DELETE FROM `gossip_menu` WHERE `entry`=10233 AND `text_id`=12377;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (10233,12377);
DELETE FROM `gossip_menu` WHERE `entry`=10234 AND `text_id`=12377;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (10234,12377);
DELETE FROM `gossip_menu` WHERE `entry`=10237 AND `text_id`=12377;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (10237,12377);
DELETE FROM `gossip_menu` WHERE `entry`=10238 AND `text_id`=12377;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (10238,12377);
DELETE FROM `gossip_menu` WHERE `entry`=10240 AND `text_id`=12377;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (10240,12377);
DELETE FROM `gossip_menu` WHERE `entry`=10243 AND `text_id`=12377;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (10243,12377);
 
 
/* 
* updates\world\2012_11_11_03_world_gossip_menu.sql 
*/ 
-- Creature Gossip Update for midsummer event from sniff
UPDATE `creature_template` SET `gossip_menu_id`=9148 WHERE `entry`=16781; -- Midsummer Celebrant
UPDATE `creature_template` SET `gossip_menu_id`=7326 WHERE `entry`=16817; -- Festival Loremaster
UPDATE `creature_template` SET `gossip_menu_id`=11417 WHERE `entry`=25697; -- Luma Skymother <The Earthen Ring>
UPDATE `creature_template` SET `gossip_menu_id`=9260 WHERE `entry`=25754; -- Earthen Ring Flamecaller <The Earthen Ring>
UPDATE `creature_template` SET `gossip_menu_id`=9203 WHERE `entry`=25883; -- Ashenvale Flame Warden
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25884; -- Ashenvale Flame Keeper
UPDATE `creature_template` SET `gossip_menu_id`=9203 WHERE `entry`=25887; -- Arathi Flame Warden
UPDATE `creature_template` SET `gossip_menu_id`=9203 WHERE `entry`=25888; -- Azuremyst Isle Flame Warden
UPDATE `creature_template` SET `gossip_menu_id`=9203 WHERE `entry`=25889; -- Blade's Edge Flame Warden
UPDATE `creature_template` SET `gossip_menu_id`=9203 WHERE `entry`=25890; -- Blasted Lands Flame Warden
UPDATE `creature_template` SET `gossip_menu_id`=9203 WHERE `entry`=25891; -- Bloodmyst Isle Flame Warden
UPDATE `creature_template` SET `gossip_menu_id`=9203 WHERE `entry`=25892; -- Burning Steppes Flame Warden
UPDATE `creature_template` SET `gossip_menu_id`=9203 WHERE `entry`=25893; -- Darkshore Flame Warden
UPDATE `creature_template` SET `gossip_menu_id`=9203 WHERE `entry`=25894; -- Desolace Flame Warden
UPDATE `creature_template` SET `gossip_menu_id`=9203 WHERE `entry`=25895; -- Dun Morogh Flame Warden
UPDATE `creature_template` SET `gossip_menu_id`=9203 WHERE `entry`=25896; -- Duskwood Flame Warden
UPDATE `creature_template` SET `gossip_menu_id`=9203 WHERE `entry`=25897; -- Dustwallow Marsh Flame Warden
UPDATE `creature_template` SET `gossip_menu_id`=9203 WHERE `entry`=25898; -- Elwynn Forest Flame Warden
UPDATE `creature_template` SET `gossip_menu_id`=9203 WHERE `entry`=25899; -- Feralas Flame Warden
UPDATE `creature_template` SET `gossip_menu_id`=9203 WHERE `entry`=25900; -- Hellfire Peninsula Flame Warden
UPDATE `creature_template` SET `gossip_menu_id`=9203 WHERE `entry`=25901; -- Hillsbrad Flame Warden -> Deleted in cata, taking from 3.x sniff
UPDATE `creature_template` SET `gossip_menu_id`=9203 WHERE `entry`=25902; -- Loch Modan Flame Warden
UPDATE `creature_template` SET `gossip_menu_id`=9203 WHERE `entry`=25903; -- Nagrand Flame Warden
UPDATE `creature_template` SET `gossip_menu_id`=9203 WHERE `entry`=25904; -- Redridge Flame Warden
UPDATE `creature_template` SET `gossip_menu_id`=9203 WHERE `entry`=25905; -- Shadowmoon Valley Flame Warden
UPDATE `creature_template` SET `gossip_menu_id`=9203 WHERE `entry`=25906; -- Teldrassil Flame Warden
UPDATE `creature_template` SET `gossip_menu_id`=9203 WHERE `entry`=25907; -- Terokkar Forest Flame Warden
UPDATE `creature_template` SET `gossip_menu_id`=9203 WHERE `entry`=25908; -- The Hinterlands Flame Warden
UPDATE `creature_template` SET `gossip_menu_id`=9203 WHERE `entry`=25909; -- Western Plaguelands Flame Warden
UPDATE `creature_template` SET `gossip_menu_id`=9203 WHERE `entry`=25910; -- Westfall Flame Warden
UPDATE `creature_template` SET `gossip_menu_id`=9203 WHERE `entry`=25911; -- Wetlands Flame Warden
UPDATE `creature_template` SET `gossip_menu_id`=9203 WHERE `entry`=25912; -- Zangarmarsh Flame Warden
UPDATE `creature_template` SET `gossip_menu_id`=9203 WHERE `entry`=25913; -- Netherstorm Flame Warden
UPDATE `creature_template` SET `gossip_menu_id`=9203 WHERE `entry`=25914; -- Silithus Flame Warden
UPDATE `creature_template` SET `gossip_menu_id`=9203 WHERE `entry`=25915; -- Cape of Stranglethorn Flame Warden
UPDATE `creature_template` SET `gossip_menu_id`=9203 WHERE `entry`=25916; -- Tanaris Flame Warden
UPDATE `creature_template` SET `gossip_menu_id`=9203 WHERE `entry`=25917; -- Winterspring Flame Warden
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25918; -- Netherstorm Flame Keeper
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25919; -- Silithus Flame Keeper
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25920; -- Cape of Stranglethorn Flame Keeper
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25921; -- Tanaris Flame Keeper
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25922; -- Winterspring Flame Keeper
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25923; -- Arathi Flame Keeper
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25925; -- Badlands Flame Keeper
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25926; -- Blade's Edge Flame Keeper
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25927; -- Burning Steppes Flame Keeper
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25928; -- Desolace Flame Keeper
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25929; -- Durotar Flame Keeper
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25930; -- Dustwallow Marsh Flame Keeper
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25931; -- Eversong Woods Flame Keeper
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25932; -- Feralas Flame Keeper
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25933; -- Ghostlands Flame Keeper
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25934; -- Hellfire Peninsula Flame Keeper
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25935; -- Hillsbrad Flame Keeper
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25936; -- Mulgore Flame Keeper
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25937; -- Nagrand Flame Keeper
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25938; -- Shadowmoon Valley Flame Keeper
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25939; -- Silverpine Forest Flame Keeper
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25940; -- Stonetalon Flame Keeper
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25941; -- Swamp of Sorrows Flame Keeper
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25942; -- Terokkar Forest Flame Keeper
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25943; -- The Northern Barrens Flame Keeper
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25944; -- The Hinterlands Flame Keeper
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25945; -- Thousand Needles Flame Keeper -> Deleted in cata, taking from 3.x sniff
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25946; -- Tirisfal Glades Flame Keeper
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=25947; -- Zangarmarsh Flame Keeper
UPDATE `creature_template` SET `gossip_menu_id`=9204 WHERE `entry`=25962; -- Fire Eater
UPDATE `creature_template` SET `gossip_menu_id`=9204 WHERE `entry`=25975; -- Master Fire Eater
UPDATE `creature_template` SET `gossip_menu_id`=9203 WHERE `entry`=32801; -- Borean Tundra Flame Warden
UPDATE `creature_template` SET `gossip_menu_id`=9203 WHERE `entry`=32802; -- Sholazar Basin Flame Warden
UPDATE `creature_template` SET `gossip_menu_id`=9203 WHERE `entry`=32806; -- Storm Peaks Flame Warden
UPDATE `creature_template` SET `gossip_menu_id`=9203 WHERE `entry`=32807; -- Crystalsong Forest Flame Warden
UPDATE `creature_template` SET `gossip_menu_id`=9203 WHERE `entry`=32808; -- Zul'Drak Flame Warden
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=32809; -- Borean Tundra Flame Keeper
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=32810; -- Sholazar Basin Flame Keeper
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=32811; -- Dragonblight Flame Keeper
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=32812; -- Howling Fjord Flame Keeper
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=32813; -- Grizzly Hills Flame Keeper
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=32814; -- Storm Peaks Flame Keeper
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=32815; -- Crystalsong Forest Flame Keeper
UPDATE `creature_template` SET `gossip_menu_id`=9278 WHERE `entry`=32816; -- Zul'Drak Flame Keeper
-- Gossip insert from sniff
DELETE FROM `gossip_menu` WHERE (`entry`=9148 AND `text_id`=12376) OR (`entry`=7326 AND `text_id`=8703) OR (`entry`=11417 AND `text_id`=12390) OR (`entry`=9260 AND `text_id`=12571) OR (`entry`=9260 AND `text_id`=12572) OR (`entry`=9203 AND `text_id`=12504) OR (`entry`=9278 AND `text_id`=12582) OR (`entry`=9204 AND `text_id`=12506) OR (`entry`=9370 AND `text_id`=12374) OR (`entry`=9406 AND `text_id`=12377) OR (`entry`=9352 AND `text_id`=12377) OR (`entry`=9354 AND `text_id`=12377) OR (`entry`=9384 AND `text_id`=12377) OR (`entry`=9385 AND `text_id`=12377) OR (`entry`=9386 AND `text_id`=12377) OR (`entry`=9387 AND `text_id`=12377) OR (`entry`=9388 AND `text_id`=12377) OR (`entry`=9389 AND `text_id`=12377) OR (`entry`=9390 AND `text_id`=12377) OR (`entry`=9391 AND `text_id`=12377) OR (`entry`=9392 AND `text_id`=12377) OR (`entry`=9393 AND `text_id`=12377) OR (`entry`=9394 AND `text_id`=12377) OR (`entry`=9395 AND `text_id`=12377) OR (`entry`=9396 AND `text_id`=12377) OR (`entry`=9397 AND `text_id`=12377) OR (`entry`=9398 AND `text_id`=12377) OR (`entry`=9399 AND `text_id`=12377) OR (`entry`=9400 AND `text_id`=12377) OR (`entry`=9401 AND `text_id`=12377) OR (`entry`=9402 AND `text_id`=12377) OR (`entry`=9403 AND `text_id`=12377) OR (`entry`=9404 AND `text_id`=12377) OR (`entry`=9405 AND `text_id`=12377) OR (`entry`=9407 AND `text_id`=12377) OR (`entry`=9408 AND `text_id`=12377) OR (`entry`=9409 AND `text_id`=12377) OR(`entry`=9410 AND `text_id`=12377) OR (`entry`=9411 AND `text_id`=12377) OR (`entry`=9412 AND `text_id`=12377) OR  (`entry`=9413 AND `text_id`=12377) OR (`entry`=9353 AND `text_id`=12374) OR (`entry`=9355 AND `text_id`=12374) OR (`entry`=9379 AND `text_id`=12374) OR (`entry`=9380 AND `text_id`=12374) OR (`entry`=9381 AND `text_id`=12374) OR (`entry`=9382 AND `text_id`=12374) OR (`entry`=9383 AND `text_id`=12374) OR (`entry`=9356 AND `text_id`=12374) OR (`entry`=9357 AND `text_id`=12374) OR (`entry`=9358 AND `text_id`=12374) OR (`entry`=9359 AND `text_id`=12374) OR (`entry`=9360 AND `text_id`=12374) OR (`entry`=9361 AND `text_id`=12374) OR (`entry`=9362 AND `text_id`=12374) OR (`entry`=9363 AND `text_id`=12374) OR (`entry`=9364 AND `text_id`=12374) OR (`entry`=9365 AND `text_id`=12374) OR (`entry`=9366 AND `text_id`=12374) OR (`entry`=9367 AND `text_id`=12374) OR (`entry`=9368 AND `text_id`=12374) OR (`entry`=9369 AND `text_id`=12374) OR (`entry`=9371 AND `text_id`=12374) OR (`entry`=9372 AND `text_id`=12374) OR (`entry`=9373 AND `text_id`=12374) OR (`entry`=9374 AND `text_id`=12374) OR (`entry`=9375 AND `text_id`=12374) OR (`entry`=9377 AND `text_id`=12374) OR (`entry`=9378 AND `text_id`=12374) OR (`entry`=10227 AND `text_id`=12377) OR (`entry`=10228 AND `text_id`=12374) OR (`entry`=10231 AND `text_id`=12374) OR (`entry`=10230 AND `text_id`=12377) OR (`entry`=10239 AND `text_id`=12374) OR (`entry`=10238 AND `text_id`=12377) OR (`entry`=10240 AND `text_id`=12377) OR (`entry`=10241 AND `text_id`=12374) OR (`entry`=10242 AND `text_id`=12374) OR (`entry`=10243 AND `text_id`=12377);
INSERT INTO `gossip_menu` (`entry`, `text_id`) VALUES
(9148, 12376), -- 16781
(7326, 8703), -- 16817
(11417, 12390), -- 25697
(9260, 12571), -- 25754
(9260, 12572), -- 25754
(9203, 12504), -- 25883, 25887, 25888, 25889, 25890, 25891, 25892, 25893, 25894, 25895, 25896, 25897, 25898, 25899, 25900, 25901, 25902, 25903, 25904, 25905, 25906, 25907, 25908, 25909, 25910, 25911, 25912, 25913, 25914, 25915, 25916, 25917, 32801, 32802, 32806, 32807, 32808
(9278, 12582), -- 25884, 25918, 25919, 25920, 25921, 25922, 25923, 25925, 25926, 25927, 25928, 25929, 25930, 25931, 25932, 25933, 25934, 25935, 25936, 25937, 25938, 25939, 25940, 25941, 25942, 25943, 25944, 25945, 25946, 25947, 32809, 32810, 32811, 32812, 32813, 32814, 32815, 32816
(9204, 12506), -- 25962, 25975
(9370, 12374), -- 187559
(9406, 12377), -- 187564
(9352, 12377), -- 187914
(9354, 12377), -- 187916
(9384, 12377), -- 187917
(9385, 12377), -- 187919
(9386, 12377), -- 187920
(9387, 12377), -- 187921
(9388, 12377), -- 187922
(9389, 12377), -- 187923
(9390, 12377), -- 187924
(9391, 12377), -- 187925
(9392, 12377), -- 187926
(9393, 12377), -- 187927
(9394, 12377), -- 187928
(9395, 12377), -- 187929
(9396, 12377), -- 187930
(9397, 12377), -- 187931 -> Deleted in cata, taking from 3.x sniff
(9398, 12377), -- 187932
(9399, 12377), -- 187933
(9400, 12377), -- 187934
(9401, 12377), -- 187935
(9402, 12377), -- 187936
(9403, 12377), -- 187937
(9404, 12377), -- 187938
(9405, 12377), -- 187939
(9407, 12377), -- 187940
(9408, 12377), -- 187941
(9409, 12377), -- 187942
(9410, 12377), -- 187943
(9411, 12377), -- 187944
(9412, 12377), -- 187945
(9413, 12377), -- 187946
(9353, 12374), -- 187947
(9355, 12374), -- 187948
(9379, 12374), -- 187949
(9380, 12374), -- 187950
(9381, 12374), -- 187951
(9382, 12374), -- 187952
(9383, 12374), -- 187953
(9356, 12374), -- 187954
(9357, 12374), -- 187955
(9358, 12374), -- 187956
(9359, 12374), -- 187957
(9360, 12374), -- 187958
(9361, 12374), -- 187959
(9362, 12374), -- 187960
(9363, 12374), -- 187961
(9364, 12374), -- 187962
(9365, 12374), -- 187963
(9366, 12374), -- 187964
(9367, 12374), -- 187965
(9368, 12374), -- 187966
(9369, 12374), -- 187967
(9371, 12374), -- 187968
(9372, 12374), -- 187969
(9373, 12374), -- 187970
(9374, 12374), -- 187971
(9375, 12374), -- 187972
(9377, 12374), -- 187974
(9378, 12374), -- 187975
(10227, 12377), -- 194032
(10228, 12374), -- 194033
(10231, 12374), -- 194034
(10230, 12377), -- 194035
(10239, 12374), -- 194043
(10238, 12377), -- 194044
(10240, 12377), -- 194045
(10241, 12374), -- 194046
(10242, 12374), -- 194048
(10243, 12377); -- 194049
-- Add quest to creature (warden)
DELETE FROM `game_event_creature_quest` WHERE (`id`=25883 AND `quest`=11805) OR (`id`=25887 AND `quest`=11804) OR (`id`=25888 AND `quest`=11806) OR (`id`=25889 AND `quest`=11807) OR (`id`=25890 AND `quest`=11808) OR (`id`=25891 AND `quest`=11809) OR (`id`=25892 AND `quest`=11810) OR (`id`=25893 AND `quest`=11811) OR (`id`=25894 AND `quest`=11812) OR (`id`=25895 AND `quest`=11813) OR (`id`=25896 AND `quest`=11814) OR (`id`=25897 AND `quest`=11815) OR (`id`=25898 AND `quest`=11816) OR (`id`=25899 AND `quest`=11817) OR (`id`=25900 AND `quest`=11818) OR (`id`=25901 AND `quest`=11819) OR (`id`=25902 AND `quest`=11820) OR (`id`=25903 AND `quest`=11821) OR (`id`=25904 AND `quest`=11822) OR (`id`=25905 AND `quest`=11823) OR (`id`=25906 AND `quest`=11824) OR (`id`=25907 AND `quest`=11825) OR (`id`=25908 AND `quest`=11826) OR (`id`=25909 AND `quest`=11827) OR (`id`=25910 AND `quest`=11583) OR (`id`=25911 AND `quest`=11828) OR (`id`=25912 AND `quest`=11829) OR (`id`=25913 AND `quest`=11830) OR (`id`=25914 AND `quest`=11831) OR (`id`=25915 AND `quest`=11832) OR (`id`=25916 AND `quest`=11833) OR (`id`=25917 AND `quest`=11834) OR (`id`=32801 AND `quest`=13485) OR (`id`=32802 AND `quest`=13486) OR (`id`=32806 AND `quest`=13490) OR (`id`=32807 AND `quest`=13491) OR (`id`=32808 AND `quest`=13492);
INSERT INTO `game_event_creature_quest` (`eventEntry`, `id`, `quest`) VALUES
(1, 25883, 11805),
(1, 25887, 11804),
(1, 25888, 11806),
(1, 25889, 11807),
(1, 25890, 11808),
(1, 25891, 11809),
(1, 25892, 11810),
(1, 25893, 11811),
(1, 25894, 11812),
(1, 25895, 11813),
(1, 25896, 11814),
(1, 25897, 11815),
(1, 25898, 11816),
(1, 25899, 11817),
(1, 25900, 11818),
(1, 25901, 11819), -- Deleted in cata, taking from 3.x sniff
(1, 25902, 11820),
(1, 25903, 11821),
(1, 25904, 11822),
(1, 25905, 11823),
(1, 25906, 11824),
(1, 25907, 11825),
(1, 25908, 11826),
(1, 25909, 11827),
(1, 25910, 11583),
(1, 25911, 11828),
(1, 25912, 11829),
(1, 25913, 11830),
(1, 25914, 11831),
(1, 25915, 11832),
(1, 25916, 11833),
(1, 25917, 11834),
(1, 32801, 13485),
(1, 32802, 13486),
(1, 32806, 13490),
(1, 32807, 13491),
(1, 32808, 13492);
-- Delete double quest
DELETE FROM `creature_questrelation` WHERE `id`=25889 AND `quest` =11807;
-- Add quest relation to Gameobject (fire)
DELETE FROM `game_event_gameobject_quest` WHERE (`id`=187559 AND `quest`=11580) OR (`id`=187564 AND `quest`=11581) OR (`id`=187914 AND `quest`=11732) OR (`id`=187916 AND `quest`=11734) OR (`id`=187917 AND `quest`=11735) OR (`id`=187919 AND `quest`=11736) OR (`id`=187920 AND `quest`=11737) OR (`id`=187921 AND `quest`=11738) OR (`id`=187922 AND `quest`=11739) OR (`id`=187923 AND `quest`=11740) OR (`id`=187924 AND `quest`=11741) OR (`id`=187925 AND `quest`=11742) OR (`id`=187926 AND `quest`=11743) OR (`id`=187927 AND `quest`=11744) OR (`id`=187928 AND `quest`=11745) OR (`id`=187929 AND `quest`=11746) OR (`id`=187930 AND `quest`=11747) OR (`id`=187931 AND `quest`=11748) OR (`id`=187932 AND `quest`=11749) OR (`id`=187933 AND `quest`=11750) OR (`id`=187934 AND `quest`=11751) OR (`id`=187935 AND `quest`=11752) OR (`id`=187936 AND `quest`=11753) OR (`id`=187937 AND `quest`=11754) OR (`id`=187938 AND `quest`=11755) OR (`id`=187939 AND `quest`=11756) OR (`id`=187940 AND `quest`=11757) OR (`id`=187941 AND `quest`=11758) OR (`id`=187942 AND `quest`=11759) OR(`id`=187943 AND `quest`=11760) OR (`id`=187944 AND `quest`=11761) OR (`id`=187945 AND `quest`=11762) OR  (`id`=187946 AND `quest`=11763) OR (`id`=187947 AND `quest`=11764) OR (`id`=187948 AND `quest`=11765) OR (`id`=187949 AND `quest`=11799) OR (`id`=187950 AND `quest`=11800) OR (`id`=187951 AND `quest`=11801) OR (`id`=187952 AND `quest`=11802) OR (`id`=187953 AND `quest`=11803) OR (`id`=187954 AND `quest`=11766) OR (`id`=187955 AND `quest`=11767) OR (`id`=187956 AND `quest`=11768) OR (`id`=187957 AND `quest`=11769) OR (`id`=187958 AND `quest`=11770) OR (`id`=187959 AND `quest`=11771) OR (`id`=187960 AND `quest`=11772) OR (`id`=187961 AND `quest`=11773) OR (`id`=187962 AND `quest`=11774) OR (`id`=187963 AND `quest`=11775) OR (`id`=187964 AND `quest`=11776) OR (`id`=187965 AND `quest`=11777) OR (`id`=187966 AND `quest`=11778) OR (`id`=187967 AND `quest`=11779) OR (`id`=187968 AND `quest`=11780) OR (`id`=187969 AND `quest`=11781) OR (`id`=187970 AND `quest`=11782) OR (`id`=187971 AND `quest`=11783) OR (`id`=187972 AND `quest`=11784) OR (`id`=187974 AND `quest`=11786) OR (`id`=187975 AND `quest`=11787) OR (`id`=194032 AND `quest`=13440) OR (`id`=194033 AND `quest`=13441) OR (`id`=194034 AND `quest`=13450) OR (`id`=194035 AND `quest`=13442) OR (`id`=194043 AND `quest`=13455) OR (`id`=194044 AND `quest`=13446) OR (`id`=194045 AND `quest`=13447) OR (`id`=194046 AND `quest`=13457) OR (`id`=194048 AND `quest`=13458) OR (`id`=194049 AND `quest`=13449);
INSERT INTO `game_event_gameobject_quest` (`eventEntry`, `id`, `quest`) VALUES
(1, 187559, 11580),
(1, 187564, 11581),
(1, 187914, 11732),
(1, 187916, 11734),
(1, 187917, 11735),
(1, 187919, 11736),
(1, 187920, 11737),
(1, 187921, 11738),
(1, 187922, 11739),
(1, 187923, 11740),
(1, 187924, 11741),
(1, 187925, 11742),
(1, 187926, 11743),
(1, 187927, 11744),
(1, 187928, 11745),
(1, 187929, 11746),
(1, 187930, 11747),
(1, 187931, 11748), -- Deleted in cata, taking from 3.x sniff
(1, 187932, 11749),
(1, 187933, 11750),
(1, 187934, 11751),
(1, 187935, 11752),
(1, 187936, 11753),
(1, 187937, 11754),
(1, 187938, 11755),
(1, 187939, 11756),
(1, 187940, 11757),
(1, 187941, 11758),
(1, 187942, 11759),
(1, 187943, 11760),
(1, 187944, 11761),
(1, 187945, 11762),
(1, 187946, 11763),
(1, 187947, 11764),
(1, 187948, 11765),
(1, 187949, 11799),
(1, 187950, 11800),
(1, 187951, 11801),
(1, 187952, 11802),
(1, 187953, 11803),
(1, 187954, 11766),
(1, 187955, 11767),
(1, 187956, 11768),
(1, 187957, 11769),
(1, 187958, 11770),
(1, 187959, 11771),
(1, 187960, 11772),
(1, 187961, 11773),
(1, 187962, 11774),
(1, 187963, 11775),
(1, 187964, 11776),
(1, 187965, 11777),
(1, 187966, 11778),
(1, 187967, 11779),
(1, 187968, 11780),
(1, 187969, 11781),
(1, 187970, 11782),
(1, 187971, 11783),
(1, 187972, 11784),
(1, 187974, 11786),
(1, 187975, 11787),
(1, 194032, 13440),
(1, 194033, 13441),
(1, 194034, 13450),
(1, 194035, 13442),
(1, 194043, 13455),
(1, 194044, 13446),
(1, 194045, 13447),
(1, 194046, 13457),
(1, 194048, 13458),
(1, 194049, 13449);
 
 
/* 
* updates\world\2012_11_12_00_world_quest_template.sql 
*/ 
-- Set chaining for Doomguard minion quests
UPDATE `quest_template` SET `PrevQuestId`=7581 WHERE `Id`=7582; -- Complete The Prison's Bindings before The Prison's Casing
UPDATE `quest_template` SET `PrevQuestId`=7582 WHERE `Id`=7583; -- Complete The Prison's Casing before Suppression
 
 
/* 
* updates\world\2012_11_12_01_world_misc.sql 
*/ 
-- update quest linking for Egg Collection
UPDATE `quest_template` SET `NextQuestId`=5522 WHERE `Id`=4735;
-- --------------------------------------------------------------------------------------------------------------
-- Test of Endurance (Gecko32)
DELETE FROM `event_scripts` WHERE `id`=747 AND `command`=10 AND `datalong`=4100; -- Remove summon of Screeching Harpies
UPDATE `event_scripts` SET `delay`=5 WHERE `id`=747 AND `command`=10 AND `datalong`=4490; -- Lower summon time of Grenka Bloodscreech from 40 sec to 5 sec
-- --------------------------------------------------------------------------------------------------------------
-- Tapper Swindlekeg (24711) fix Alliance faction exploitation (nelgano)
UPDATE `creature_template` SET `unit_flags`=4864 WHERE `entry`=24711;
-- --------------------------------------------------------------------------------------------------------------
DELETE FROM `gameobject` WHERE `guid`=335;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(335,1684,1,1,1,1524.929,-4371.182,17.94367,1.62046,0,0,0,1,300,100,1);
 
 
/* 
* updates\world\2012_11_12_02_world_quest_template.sql 
*/ 
DELETE FROM `gameobject` WHERE `guid`IN (335,347);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(335,324,1,1,1,-6314,507.647,7.651,0.496,0,0,0,0,2700,100,1),
(347,1684,1,1,1,1524.929,-4371.182,17.94367,1.62046,0,0,0,1,300,100,1);
 
 
/* 
* updates\world\2012_11_12_03_world_misc.sql 
*/ 
-- Fix Jormungar Tunneler
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=26467;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=26467;
DELETE FROM `smart_scripts` WHERE `entryorguid`=26467 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(26467,0,0,0,11,0,100,0,0,0,0,0,11,47677,0,0,0,0,0,1,0,0,0,0,0,0,0,'Jormungar Tunneler - On spawn - Spellcast Jormungar Tunnel Passive'),
(26467,0,1,0,21,0,100,0,0,0,0,0,11,47677,0,0,0,0,0,1,0,0,0,0,0,0,0,'Jormungar Tunneler - On reached homeposition - Spellcast Jormungar Tunnel Passive'),
(26467,0,2,0,1,0,100,0,3000,5000,15000,18000,11,51879,0,0,0,0,0,2,0,0,0,0,0,0,0,'Jormungar Tunneler - On update (IC) - Spellcast Corrode Flesh'),
(26467,0,3,0,4,0,100,0,0,0,0,0,28,47677,0,0,0,0,0,1,0,0,0,0,0,0,0,'Jormungar Tunneler - On aggro - Remove Jormungar Tunnel Passive');
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Update Fjord Hawk: Lots of these had incorrect movement.
DELETE FROM `creature_addon` WHERE `guid` IN (112058,112059,112088,112089,112091,112114,112115,112141,112142,112149,112150,112151,112152,112153,112154,112155,112156,112157,112158);
INSERT INTO `creature_addon` (`guid`,`mount`,`bytes1`,`bytes2`,`auras`) VALUES
(112058,0,1,1,''),(112059,0,1,1,''),(112088,0,1,1,''),
(112089,0,1,1,''),(112091,0,1,1,''),(112114,0,1,1,''),
(112115,0,1,1,''),(112141,0,1,1,''),(112142,0,1,1,''),
(112149,0,1,1,''),(112150,0,1,1,''),(112151,0,1,1,''),
(112152,0,1,1,''),(112153,0,1,1,''),(112154,0,1,1,''),
(112155,0,1,1,''),(112156,0,1,1,''),(112157,0,1,1,''),(112158,0,1,1,'');
UPDATE `creature` SET `spawndist`=0, `MovementType`=0 WHERE `guid` IN (112058,112059,112088,112089,112091,112114,112115,112141,112142,112149,112150,112151,112152,112153,112154,112155,112156,112157,112158);
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SAI for Lashers
UPDATE `creature_addon` SET `bytes1`=0 WHERE `guid` BETWEEN 88228 AND 88237;
UPDATE `creature_addon` SET `bytes1`=0 WHERE `guid` BETWEEN 131438 AND 131457;
UPDATE `creature_addon` SET `auras`='' WHERE `guid`=131452;
UPDATE `creature_addon` SET `bytes1`=0 WHERE `guid` IN (106897,106898,106899,106900,106902,106903,106909,106910,106911,106912,106913,106914,106915,106916,106917,106918);
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`IN(27254,30845,34300);
DELETE FROM `creature_ai_scripts` WHERE `creature_id`IN(27254,30845,34300);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (27254,30845,34300) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
-- Emerald Lasher
(27254,0,0,2,11,0,100,0,0,0,0,0,90,9,0,0,0,0,0,1,0,0,0,0,0,0,0,'Emerald Lasher - On spawn - Set unitfield_bytes1 9 (submerged)'),
(27254,0,1,2,21,0,100,0,0,0,0,0,90,9,0,0,0,0,0,1,0,0,0,0,0,0,0,'Emerald Lasher - On reached homeposition - Set unitfield_bytes1 9 (submerged)'),
(27254,0,2,0,61,0,100,0,0,0,0,0,21,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Emerald Lasher - Linked with event 0 or 1 - Disable combat movement'),
(27254,0,3,0,4,0,100,0,0,0,0,0,11,37752,0,0,0,0,0,1,0,0,0,0,0,0,0,'Emerald Lasher - On aggro - Spellcast Stand'),
(27254,0,4,0,0,0,100,0,1500,1500,0,0,21,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Emerald Lasher - On update (IC) - Enable combat movement'),
(27254,0,5,0,0,0,100,0,4000,7000,9000,13000,11,51901,0,0,0,0,0,2,0,0,0,0,0,0,0,'Emerald Lasher - On update (IC) - Spellcast Dream Lash'),
-- Living Lasher
(30845,0,0,2,11,0,100,0,0,0,0,0,90,9,0,0,0,0,0,1,0,0,0,0,0,0,0,'Living Lasher - On spawn - Set unitfield_bytes1 9 (submerged)'),
(30845,0,1,2,21,0,100,0,0,0,0,0,90,9,0,0,0,0,0,1,0,0,0,0,0,0,0,'Living Lasher - On reached homeposition - Set unitfield_bytes1 9 (submerged)'),
(30845,0,2,0,61,0,100,0,0,0,0,0,21,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Living Lasher - Linked with event 0 or 1 - Disable combat movement'),
(30845,0,3,0,4,0,100,0,0,0,0,0,11,37752,0,0,0,0,0,1,0,0,0,0,0,0,0,'Living Lasher - On aggro - Spellcast Stand'),
(30845,0,4,0,0,0,100,0,1500,1500,0,0,21,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Living Lasher - On update (IC) - Enable combat movement'),
(30845,0,5,0,0,0,100,0,4000,7000,9000,13000,11,51901,0,0,0,0,0,2,0,0,0,0,0,0,0,'Living Lasher - On update (IC) - Spellcast Dream Lash'),
-- 34300 Mature Lasher
(34300,0,0,2,11,0,100,0,0,0,0,0,90,9,0,0,0,0,0,1,0,0,0,0,0,0,0,'Mature Lasher - On spawn - Set unitfield_bytes1 9 (submerged)'),
(34300,0,1,2,21,0,100,0,0,0,0,0,90,9,0,0,0,0,0,1,0,0,0,0,0,0,0,'Mature Lasher - On reached homeposition - Set unitfield_bytes1 9 (submerged)'),
(34300,0,2,0,61,0,100,0,0,0,0,0,21,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Mature Lasher - Linked with event 0 or 1 - Disable combat movement'),
(34300,0,3,0,4,0,100,0,0,0,0,0,11,37752,0,0,0,0,0,1,0,0,0,0,0,0,0,'Mature Lasher - On aggro - Spellcast Stand'),
(34300,0,4,0,0,0,100,0,1500,1500,0,0,21,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Mature Lasher - On update (IC) - Enable combat movement'),
(34300,0,5,0,0,0,100,0,4000,7000,9000,13000,11,51901,0,0,0,0,0,2,0,0,0,0,0,0,0,'Mature Lasher - On update (IC) - Spellcast Dream Lash');
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Secrets of the Scourge
UPDATE `quest_template` SET `PrevQuestId`=0 WHERE `Id`=12312;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Icehorn updates from sniffs
UPDATE `creature_template` SET `speed_run`=0.9920629, `rank`=4, `unit_flags`=32832, `family`=43, `type_flags`=65537 WHERE `entry`=32361;
DELETE FROM `creature_template_addon` WHERE `entry`=32361;
INSERT INTO `creature_template_addon` (`entry`, `mount`, `bytes1`, `bytes2`, `auras`) VALUES
(32361,0,0,1,'60915');
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Dragonblight optical improvements
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (27203,30058);
UPDATE `creature_template` SET `inhabitType`=4 WHERE `entry`=30078;
UPDATE `creature_addon` SET `auras`='' WHERE `guid` IN (131075,131077);
UPDATE `creature_addon` SET `auras`='42048' WHERE `guid`=131066;
UPDATE `creature_addon` SET `auras`='42049' WHERE `guid`=106614;
UPDATE `creature_addon` SET `auras`='42050' WHERE `guid`=131068;
UPDATE `creature_addon` SET `auras`='42051' WHERE `guid`=106634;
UPDATE `creature` SET `spawndist`=0, `MovementType`=0 WHERE `id` IN (27222,27223,30078);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (-102199,-105487,-105488,-105489,-105495,-131055,-131056,-131058,-131059) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(-102199,0,0,0,25,0,100,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Onslaught Footman - On reset - Set event phase 1'),
(-102199,0,1,2,1,1,100,0,2000,2000,12000,14000,11,48115,0,0,0,0,0,19,27222,30,0,0,0,0,0,'Onslaught Footman - On OOC update (phase 1) - Spellcast Shoot on Archery Target'),
(-102199,0,2,0,61,1,100,0,0,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Onslaught Footman - On OOC update (phase 1) - Set event phase 2'),
(-102199,0,3,4,1,2,100,0,16000,18000,16000,18000,11,48117,0,0,0,0,0,19,27223,30,0,0,0,0,0,'Onslaught Footman - On OOC update (phase 2) - Spellcast Shoot on Archery Target'),
(-102199,0,4,0,61,2,100,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Onslaught Footman - On OOC update (phase 2) - Set event phase 4'),
(-105487,0,0,0,1,0,100,0,2000,2000,0,0,11,55840,0,0,0,0,0,10,107492,0,0,0,0,0,0,'Warden of the Chamber - On reset - Spellcast Blue Wyrmrest Warden Beam'),
(-105488,0,0,0,1,0,100,0,2000,2000,0,0,11,55841,0,0,0,0,0,10,107491,0,0,0,0,0,0,'Warden of the Chamber - On reset - Spellcast Yellow Wyrmrest Warden Beam'),
(-105489,0,0,0,1,0,100,0,2000,2000,0,0,11,55841,0,0,0,0,0,10,107491,0,0,0,0,0,0,'Warden of the Chamber - On reset - Spellcast Yellow Wyrmrest Warden Beam'),
(-105495,0,0,0,1,0,100,0,2000,2000,0,0,11,55840,0,0,0,0,0,10,107492,0,0,0,0,0,0,'Warden of the Chamber - On reset - Spellcast Blue Wyrmrest Warden Beam'),
(-131055,0,0,0,1,0,100,0,2000,2000,0,0,11,55838,0,0,0,0,0,10,131075,0,0,0,0,0,0,'Warden of the Chamber - On reset - Spellcast Green Wyrmrest Warden Beam'),
(-131056,0,0,0,1,0,100,0,2000,2000,0,0,11,55824,0,0,0,0,0,10,131077,0,0,0,0,0,0,'Warden of the Chamber - On reset - Spellcast Red Wyrmrest Warden Beam'),
(-131058,0,0,0,1,0,100,0,2000,2000,0,0,11,55838,0,0,0,0,0,10,131075,0,0,0,0,0,0,'Warden of the Chamber - On reset - Spellcast Green Wyrmrest Warden Beam'),
(-131059,0,0,0,1,0,100,0,2000,2000,0,0,11,55824,0,0,0,0,0,10,131077,0,0,0,0,0,0,'Warden of the Chamber - On reset - Spellcast Red Wyrmrest Warden Beam');
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Borean Tundra visual improvement and missing spawn
SET @GOGUID :=356; -- need 1 set by TDB
SET @GUID :=43460; -- need 3 set by TDB
DELETE FROM `gameobject` WHERE `guid`=@GOGUID;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(@GOGUID,187879,571,1,1,4207.366,4056.894,91.62077,2.792518,0,0,0.984807,0.1736523,300,100,1);
DELETE FROM `creature` WHERE `guid` in (@GUID+0,@GUID+1,@GUID+2);
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(@GUID+0,24021,571,1,1,21999,0,4207.475,4056.687,93.53715,2.094395,300,0,0,42,0,0,0,0,0),
(@GUID+1,23837,571,1,1,11686,0,4207.471,4056.705,93.66189,3.979351,300,0,0,42,0,0,0,0,0),
(@GUID+2,24957,571,1,1,0,0,4200.877,4056.888,92.28766,6.25263,300,0,0,7185,7196,0,0,0,0);
DELETE FROM `smart_scripts` WHERE `entryorguid`=24957 AND `source_type`=0 AND `id` IN (1,3);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(24957,0,1,0,11,0,100,0,0,0,0,0,11,45820,0,0,0,0,0,9,24021,0,30,0,0,0,0,'Cult Plaguebringer - On spawn - Spellcast Plague Cauldron Beam'),
(24957,0,3,0,21,0,100,0,0,0,0,0,11,45820,0,0,0,0,0,9,24021,0,30,0,0,0,0,'Cult Plaguebringer - On reached homeposition - Spellcast Plague Cauldron Beam');
UPDATE `creature_addon` SET `auras`='45797' WHERE `guid` IN (98730,115941);
DELETE FROM `creature_addon` WHERE `guid` IN (@GUID+0,@GUID+1);
INSERT INTO `creature_addon` (`guid`,`mount`,`bytes1`,`bytes2`,`auras`) VALUES
(@GUID+0,0,0,1,'45797'),
(@GUID+1,0,0,1,'45797');
 
 
/* 
* updates\world\2012_11_13_00_world_waypoints.sql 
*/ 
-- Pathing for Ol' Sooty Entry: 1225
SET @NPC := 8877;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawntimesecs`=1200,`spawndist`=0,`MovementType`=2,`position_x`=-5716.181152,`position_y`=-3110.810791,`position_z`=316.686523 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-5716.181152,-3110.810791,316.686523,0,0,0,100,0), 
(@PATH,2,-5716.187012,-3093.080078,325.600677,0,0,0,100,0), 
(@PATH,3,-5712.214355,-3090.297607,327.738647,0,0,0,100,0), 
(@PATH,4,-5705.484375,-3092.523438,329.362366,0,0,0,100,0), 
(@PATH,5,-5681.826660,-3110.568848,338.121887,0,0,0,100,0), 
(@PATH,6,-5659.498535,-3122.215576,344.336151,0,0,0,100,0), 
(@PATH,7,-5639.585938,-3124.536133,348.404938,0,0,0,100,0), 
(@PATH,8,-5618.112793,-3110.905762,360.618225,0,0,0,100,0), 
(@PATH,9,-5621.486816,-3096.315918,368.247772,0,0,0,100,0), 
(@PATH,10,-5632.212891,-3078.608398,374.990936,0,0,0,100,0), 
(@PATH,11,-5629.793457,-3056.124023,384.465576,0,0,0,100,0), 
(@PATH,12,-5642.278809,-3036.872314,385.471649,0,0,0,100,0), 
(@PATH,13,-5609.369141,-3006.883301,386.288177,0,0,0,100,0), 
(@PATH,14,-5643.634277,-3036.388672,385.531891,0,0,0,100,0), 
(@PATH,15,-5630.174805,-3057.015869,384.385712,0,0,0,100,0), 
(@PATH,16,-5629.840332,-3065.496338,381.129578,0,0,0,100,0), 
(@PATH,17,-5634.866211,-3078.448975,374.489044,0,0,0,100,0), 
(@PATH,18,-5620.416504,-3101.081543,364.819855,0,0,0,100,0), 
(@PATH,19,-5624.629395,-3117.040527,354.493805,0,0,0,100,0), 
(@PATH,20,-5644.949707,-3125.081787,347.271362,0,0,0,100,0), 
(@PATH,21,-5660.741699,-3121.580566,343.975922,0,0,0,100,0), 
(@PATH,22,-5676.210938,-3111.586914,340.021484,0,0,0,100,0), 
(@PATH,23,-5691.895508,-3102.994385,333.646698,0,0,0,100,0), 
(@PATH,24,-5711.662109,-3088.433594,328.761566,0,0,0,100,0), 
(@PATH,25,-5717.663574,-3099.033691,321.686920,0,0,0,100,0), 
(@PATH,26,-5705.214844,-3132.324219,315.837585,0,0,0,100,0), 
(@PATH,27,-5679.014160,-3185.046875,319.508057,0,0,0,100,0);
 
 
/* 
* updates\world\2012_11_13_01_world_misc.sql 
*/ 
-- Various quest fixes in Grizzly Hills

SET @GUID :=43494; -- need 8 set by TDB
SET @OGUID :=5681; -- need 3 set by TDB

-- Creature Gossip_menu_option Update from sniff
DELETE FROM `gossip_menu_option` WHERE `menu_id`=9426 AND `id`=0;
DELETE FROM `gossip_menu_option` WHERE `menu_id`=9615 AND `id`=1;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES
(9426,0,0, 'Remove the Eye of the Prophets from the idol''s face.',1,1,0,0,0,0, ''),
(9615,1,0, 'I need another of your elixirs, Drakuru.',1,1,0,0,0,0, '');

-- Gossip Menu insert from sniff
DELETE FROM `gossip_menu` WHERE `entry`=9426 AND `text_id` IN (12669,12670);
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES
(9426,12669),(9426,12670);

-- Creature Template update from sniff
UPDATE `creature_template` SET `minLevel`=70, `maxLevel`=70, `unit_flags`=33024, `AIName`='SmartAI' WHERE `entry` IN (26500);
UPDATE `creature_template` SET `npcflag`=2, `unit_flags`=33024, `AIName`='SmartAI' WHERE `entry` IN (26543,26701,26787);

UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=61 WHERE `item`=35799 AND `entry`=26447;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=58 WHERE `item`=35799 AND `entry`=26425;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=100 WHERE `item`=35836;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=49 WHERE `item`=36743 AND `entry`=26704;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=50 WHERE `item`=36743 AND `entry`=27554;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=51 WHERE `item`=36758 AND `entry`=26795;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=48 WHERE `item`=36758 AND `entry`=26797;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=66 WHERE `item`=38303 AND `entry`=26620;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=67 WHERE `item`=38303 AND `entry`=26639;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=15 WHERE `item`=38303 AND `entry`=27431;

UPDATE `creature_involvedrelation` SET `id`=26543 WHERE `quest`=12007;
UPDATE `creature_involvedrelation` SET `id`=26701 WHERE `quest`=12802;
UPDATE `creature_involvedrelation` SET `id`=26787 WHERE `quest`=12068;
UPDATE `creature_questrelation` SET `id`=26543 WHERE `quest`=12042;
UPDATE `creature_questrelation` SET `id`=26701 WHERE `quest`=12068;
UPDATE `creature_questrelation` SET `id`=26787 WHERE `quest`=12238;

DELETE FROM `creature_text` WHERE `entry`=26500;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(26500,0,0,'I''ll be waitin'' for ya, mon.',15,0,100,0,0,0,'Image of Drakuru');

-- Conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=47110;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=9426 AND `SourceEntry`=12670;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=9426 AND `SourceEntry`=0;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=9615 AND `SourceEntry`=1;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1,47110,0,0,31,0,3,26498,0,0,0,'','Spell Summon Drakuru''s Image targets Drakuru''s Bunny 01'),
(13,1,47110,0,1,31,0,3,26559,0,0,0,'','Spell Summon Drakuru''s Image targets Drakuru''s Bunny 02'),
(13,1,47110,0,2,31,0,3,26700,0,0,0,'','Spell Summon Drakuru''s Image targets Drakuru''s Bunny 03'),
(13,1,47110,0,3,31,0,3,26789,0,0,0,'','Spell Summon Drakuru''s Image targets Drakuru''s Bunny 04'),
(13,1,47110,0,4,31,0,3,28015,0,0,0,'','Spell Summon Drakuru''s Image targets Drakuru''s Bunny 05'),
(14,9426,12670,0,0,2,0,35806,1,1,0,0,'','Seer of Zeb''Halak - Show different gossip if player has item Eye of the Propehts'),
(15,9426,0,0,0,9,0,12007,0,0,0,0,'','Seer of Zeb''Halak - Show gossip option if player has taken quest 12007'),
(15,9426,0,0,0,2,0,35806,1,1,1,0,'','Seer of Zeb''Halak - Show gossip option if player has not item Eye of the Propehts'),
(15,9615,1,0,0,8,0,11990,0,0,0,0,'','Drakuru - Show gossip option if player has rewarded quest 11990'),
(15,9615,1,0,0,8,0,12238,0,0,1,0,'','Drakuru - Show gossip option if player has not rewarded quest 12238'),
(15,9615,1,0,0,2,0,35797,1,1,1,0,'','Drakuru - Show gossip option if player has not item Drakuru''s Elixir');

UPDATE `gameobject_template` SET `AIName`='SmartGameObjectAI' WHERE `entry`=188458;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (26498,26559,26700,26789);

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (26498,26500,26543,26559,26700,26701,26787,26789) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=26423 AND `source_type`=0 AND `id` IN (2,3);
DELETE FROM `smart_scripts` WHERE `entryorguid`=188458 AND `source_type`=1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(26423,0,2,3,62,0,100,0,9615,1,0,0,85,50021,0,0,0,0,0,7,0,0,0,0,0,0,0,'Drakuru - On gossip option select - Invoker spellcast Replace Drakuru''s Elixir'),
(26423,0,3,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Drakuru - On gossip option select - Close gossip'),
(26498,0,0,0,8,0,100,0,47110,0,0,0,11,47117,0,0,0,0,0,7,0,0,0,0,0,0,0,'Drakuru''s Bunny 01 - On spellhit - Spellcast Script Cast Summon Image of Drakuru'),
(26500,0,0,1,19,0,100,0,12007,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Image of Drakuru - On quest accepted - Say text'),
(26500,0,1,0,61,0,100,0,12007,0,0,0,11,47122,0,0,0,0,0,7,0,0,0,0,0,0,0,'Image of Drakuru - On quest accepted - Spellcast Strip Detect Drakuru'),
(26543,0,0,1,19,0,100,0,12042,0,0,0,11,47308,0,0,0,0,0,7,0,0,0,0,0,0,0,'Image of Drakuru - On quest accepted - Spellcast Strip Detect Drakuru 02'),
(26559,0,0,0,8,0,100,0,47110,0,0,0,11,47149,0,0,0,0,0,7,0,0,0,0,0,0,0,'Drakuru''s Bunny 02 - On spellhit - Spellcast Script Cast Summon Image of Drakuru 02'),
(26700,0,0,0,8,0,100,0,47110,0,0,0,11,47316,0,0,0,0,0,7,0,0,0,0,0,0,0,'Drakuru''s Bunny 03 - On spellhit - Spellcast Script Cast Summon Image of Drakuru 03'),
(26701,0,0,1,19,0,100,0,12068,0,0,0,11,47403,0,0,0,0,0,7,0,0,0,0,0,0,0,'Image of Drakuru - On quest accepted - Spellcast Strip Detect Drakuru 03'),
(26787,0,0,1,19,0,100,0,12238,0,0,0,11,48417,0,0,0,0,0,7,0,0,0,0,0,0,0,'Image of Drakuru - On quest accepted - Spellcast Strip Detect Drakuru 04'),
(26789,0,0,0,8,0,100,0,47110,0,0,0,11,47405,0,0,0,0,0,7,0,0,0,0,0,0,0,'Drakuru''s Bunny 04 - On spellhit - Spellcast Script Cast Summon Image of Drakuru 04'),
(188458,1,0,1,62,0,100,0,9426,0,0,0,85,47293,0,0,0,0,0,7,0,0,0,0,0,0,0,'Seer of Zeb''Halak - On gossip option select - Invoker spellcast Create Eye of the Prophets'),
(188458,1,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Seer of Zeb''Halak - On gossip option select - Close gossip');

DELETE FROM `spell_scripts` WHERE `id` IN (47117,47149,47316,47405,50439);
INSERT INTO `spell_scripts` (`id`,`effIndex`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`) VALUES
(47117,0,0,15,47118,2,0,0,0,0,0), -- Script Cast Summon Image of Drakuru - Spellcast Envision Drakuru
(47149,0,0,15,47150,2,0,0,0,0,0), -- Script Cast Summon Image of Drakuru 02 - Spellcast Envision Drakuru
(47316,0,0,15,47317,2,0,0,0,0,0), -- Script Cast Summon Image of Drakuru 03 - Spellcast Envision Drakuru
(47405,0,0,15,47406,2,0,0,0,0,0), -- Script Cast Summon Image of Drakuru 04 - Spellcast Envision Drakuru
(50439,0,0,15,50440,2,0,0,0,0,0); -- Script Cast Summon Image of Drakuru 05 - Spellcast Envision Drakuru

DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (-47122,-47308,-47403,-48417);
INSERT INTO `spell_linked_spell` (`spell_trigger`,`spell_effect`,`type`,`comment`) VALUES
(-47122,-47118,0,'On Strip Detect Drakuru fade - Remove Envision Drakuru'),
(-47308,-47150,0,'On Strip Detect Drakuru 02 fade - Remove Envision Drakuru'),
(-47403,-47317,0,'On Strip Detect Drakuru 03 fade - Remove Envision Drakuru'),
(-48417,-47406,0,'On Strip Detect Drakuru 04 fade - Remove Envision Drakuru');

DELETE FROM `creature` WHERE `guid` in (@GUID+0,@GUID+1,@GUID+2,@GUID+3,@GUID+4,@GUID+5,@GUID+6,@GUID+7);
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(@GUID+0,26498,571,1,1,19595,0,3386.607,-1805.944,115.2497,3.001966,300,0,0,0,0,0,0,0,0),
(@GUID+1,26500,571,1,1,0,0,3386.272,-1805.434,115.4441,4.939282,300,0,0,0,0,0,0,0,0),
(@GUID+2,26559,571,1,1,19595,0,4243.962,-2024.805,238.2487,1.411705,300,0,0,0,0,0,0,0,0),
(@GUID+3,26543,571,1,1,0,0,4243.962,-2024.805,238.2487,1.411705,300,0,0,0,0,0,0,0,0),
(@GUID+4,26700,571,1,1,19595,0,4523.894,-3472.863,228.2441,4.695459,300,0,0,0,0,0,0,0,0),
(@GUID+5,26701,571,1,1,0,0,4523.894,-3472.863,228.2441,4.695459,300,0,0,0,0,0,0,0,0),
(@GUID+6,26787,571,1,1,0,0,4599.709,-4876.9,48.95556,0.719772,300,0,0,0,0,0,0,0,0),
(@GUID+7,26789,571,1,1,19595,0,4599.709,-4876.9,48.95556,0.719772,300,0,0,0,0,0,0,0,0);

DELETE FROM `creature_template_addon` WHERE `entry` IN (26500,26543,26701,26787);
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(26500,0,0,65536,1,0,'43167 47119'),
(26543,0,0,65536,1,0,'43167 47119'),
(26701,0,0,65536,1,0,'43167 47119'),
(26787,0,0,65536,1,0,'43167 47119');

DELETE FROM `gameobject` WHERE `guid` BETWEEN @OGUID+0 AND @OGUID+2;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(@OGUID+0,188600,571,1,1,3980.721,-1956.352,210.6624,1.169369,0,0,0,1,120,255,1),
(@OGUID+1,188600,571,1,1,3957.188,-1908.295,209.97,0.8901166,0,0,0,1,120,255,1),
(@OGUID+2,188600,571,1,1,3964.761,-1884.524,208.2739,1.692969,0,0,0,1,120,255,1);
 
 
/* 
* updates\world\2012_11_13_02_world_creature.sql 
*/ 
-- Fix [Q]{A/H} Meet At The Grave
UPDATE `creature_template_addon` SET `auras`='10848' WHERE `entry`=9299; -- allow to be seen in world of death
UPDATE `creature_template` SET `npcflag`=32770,`unit_flags`=768 WHERE `entry`=9299; -- makes unseen in world of living
 
 
/* 
* updates\world\2012_11_13_03_world_gameevent.sql 
*/ 
-- Pilgrim's Bounty start time fix
UPDATE `game_event` SET `start_time`= '2012-11-18 01:00:00' WHERE `eventEntry`=26;
 
 
/* 
* updates\world\2012_11_13_04_world_gameeventquest.sql 
*/ 
-- Fix Pilgrims Bounty quest during Hallows End
INSERT INTO `game_event_creature_quest` (`eventEntry`,`id`,`quest`) VALUES (26,18927,14022);
DELETE FROM `creature_questrelation` WHERE `id`=18927;
 
 
/* 
* updates\world\2012_11_13_05_world_player_factionchange_items.sql 
*/ 
DELETE FROM `player_factionchange_items` WHERE `alliance_id` IN (15198, 47937);
INSERT INTO `player_factionchange_items` (`race_A`, `alliance_id`, `commentA`, `race_H`, `horde_id`, `commentH`) VALUES
(0, 15198, 'Knight\'s Colors', 0, 15199, 'Stone Guard\'s Herald'),
(0, 47937, 'Girdle of the Nether Champion', 0, 48009, 'Belt of the Nether Champion');
 
 
/* 
* updates\world\2012_11_13_06_world_trinity_string.sql 
*/ 
DELETE FROM `trinity_string` WHERE `entry` IN (5018,5019);
UPDATE `trinity_string` SET `content_default`= '[Raid]' WHERE `entry`=5017;
 
 
/* 
* updates\world\2012_11_14_00_world_sai.sql 
*/ 
SET @ENTRY_SPIRIT_SHADE := 15261;
SET @ENTRY_LETHON := 14888;
SET @SPELL_DARK_OFFERING := 24804;

DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY_SPIRIT_SHADE;
UPDATE `creature_template` SET `AIName`= '',`ScriptName`= 'npc_spirit_shade' WHERE `entry`=@ENTRY_SPIRIT_SHADE;

DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY_SPIRIT_SHADE AND `source_type`=0;

DELETE FROM `creature_template_addon` WHERE `entry`=@ENTRY_SPIRIT_SHADE;
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`auras`) VALUES
(@ENTRY_SPIRIT_SHADE,0,0,0, '24809');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=@SPELL_DARK_OFFERING;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13,1,@SPELL_DARK_OFFERING,0,0,31,0,3,@ENTRY_LETHON,0,0,0, '', 'Dark offering can only target Lethon');
 
 
/* 
* updates\world\2012_11_14_00_world_various_fixes.sql 
*/ 
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Mounts players mode 25
UPDATE `creature_template` SET `VehicleId`=220,`spell1`=56091,`spell2`=56092,`spell3`=57090,`spell4`=57143,`spell5`=57108,`spell6`=57092,`spell7`=60534,`InhabitType`=5 WHERE `entry`=31752;
-- Hover Disk mode 25
UPDATE `creature_template` SET `VehicleId`=224,`faction_A`=35,`faction_H`=35,`InhabitType`=5 WHERE `entry` IN (31749,31748);
-- spawn the focusing iris 25men
DELETE FROM gameobject WHERE id IN (193960);
INSERT INTO `gameobject` 
(`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(361,193960,616,2,1,754.362,1301.61,266.171,6.23742,0,0,0.022883,-0.999738,300,0,1); 
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- The Heart of the Storm (Issue 1959)
DELETE FROM `gameobject` WHERE `id`=192181;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(362,192181,571,1,1,7308.945,-727.9163,791.6083,1.53589,0,0,0.690772,0.723073,30,100,1);
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Add support for {Q} Corrupted Sabers ID: 4506 (Issue 2297) 
SET @CommonKitten:=9937;
SET @CorruptedKitten :=9936;
SET @SGossip :=55002; -- Gossip for Kitten when near quest giver
SET @SpellVisual :=16510; -- Turn Kitten in Saber
SET @Winna   :=9996;  -- Winna Hazzard
SET @Saber   :=10042; -- Big green cat
-- Add SAI support for Corrupted Kitten
UPDATE `creature_template` SET `AIName`='SmartAI',`gossip_menu_id`=@SGossip,`npcflag`=1 WHERE `entry`=@CorruptedKitten;
UPDATE `creature_template` SET `AIName`='SmartAI',`gossip_menu_id`=@SGossip,`npcflag`=1 WHERE `entry`=@CommonKitten;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@CorruptedKitten,@CommonKitten);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@CommonKitten,0,0,1,54,0,100,0,0,0,0,0,36,@CorruptedKitten,0,0,0,0,0,1,0,0,0,0,0,0,0,'Common Kitten - On spawn - Change template to corrupted one'),
(@CommonKitten,0,1,2,61,0,100,0,0,0,0,0,11,@SpellVisual,0,0,0,0,0,1,0,0,0,0,0,0,0,'Common Kitten - On OOC of 10 sec - Cast Corrupted Saber visual to self'),
(@CommonKitten,0,2,0,61,0,100,0,0,0,0,0,3,@Saber,0,0,0,0,0,1,0,0,0,0,0,0,0,'Common Kitten - Linked with previous event - Morph to Corrupted Saber'),
(@CommonKitten,0,3,4,62,0,100,0,@SGossip,1,0,0,26,4506,0,0,0,0,0,7,0,0,0,0,0,0,0,'Common Kitten - On Gossip Select - Award quest,since no credit'),
(@CommonKitten,0,4,5,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Common Kitten - Linked with previous event - Close gossip'),
(@CommonKitten,0,5,6,61,0,100,0,0,0,0,0,47,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Common Kitten - Linked with previous event - Set unseen'),
(@CommonKitten,0,6,0,61,0,100,0,0,0,0,0,41,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Common Kitten - Linked with previous event - Despawn in 1 sec');
-- Insert Gossip /custom made id/
DELETE FROM `gossip_menu_option` WHERE `menu_id`=@SGossip AND `id`=1;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`) VALUES
(@SGossip,1,0,'I want to release the saber to Winna.',1,131,0);
-- Only show gossip if near Winna
DELETE FROM `conditions` WHERE `SourceGroup`=@SGOSSIP AND `SourceTypeOrReferenceId`=15;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES 
(15,@SGOSSIP,1,0,29,1,@Winna,5,0,0,0,'','Only show second gossip Corrupted Saber is near Wina in 5 yards');
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Fix for Prepping the Speech by Gecko32 (Issue 2399)
SET @MEKKATORQUE :=39712;
SET @OZZIE       :=1268;
SET @MILLI       :=7955;
SET @TOG         :=6119;
-- Add creature text for npc's
DELETE FROM `creature_text` WHERE `entry`=@MEKKATORQUE;
DELETE FROM `creature_text` WHERE `entry`=@OZZIE;
DELETE FROM `creature_text` WHERE `entry`=@MILLI;
DELETE FROM `creature_text` WHERE `entry`=@TOG;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@MEKKATORQUE,0,0,'They may take our lives, but they''ll never take...',12,0,100,0,0,0,'High Tinker Mekkatorque to Milli Featherwhistle 1'),
(@MEKKATORQUE,1,0,'...our INNOVATION!',12,0,100,0,0,0,'High Tinker Mekkatorque to Milli Featherwhistle 2'),
(@MEKKATORQUE,2,0,'What I want out of each and every one of you is a hard-target search of every refuelling station, residence, warehouse, farmhouse, henhouse, outhouse, and doghouse in this area.',12,0,100,0,0,0,'High Tinker Mekkatorque to Ozzie Togglevolt 1'),
(@MEKKATORQUE,3,0,'Your fugitive''s name is Mekgineer Thermaplugg.',12,0,100,0,0,0,'High Tinker Mekkatorque to Ozzie Togglevolt 2'),
(@MEKKATORQUE,4,0,'Go get him.',12,0,100,0,0,0,'High Tinker Mekkatorque to Ozzie Togglevolt 3'),
(@MEKKATORQUE,5,0,'We will not go quietly into the night! We will not vanish without a fight!',12,0,100,0,0,0,'High Tinker Mekkatorque to Tog Rustsprocket 1'),
(@MEKKATORQUE,6,0,'We''re going to live on! We''re going to survive! Today we celebrate...',12,0,100,0,0,0,'High Tinker Mekkatorque to Tog Rustsprocket 2'),
(@MEKKATORQUE,7,0,'...our Autonomy Day!',12,0,100,0,0,0,'High Tinker Mekkatorque to Tog Rustsprocket 3'),
(@OZZIE,0,0,'Hmm, I suppose it could work. But it could really use a little more umph!',12,0,100,0,0,0,'Ozzie Togglevolt reply'),
(@MILLI,0,0,'What? I don''t even know what you''re talking about! That''s terrible!',12,0,100,0,0,0,'Milli Featherwhistle reply'),
(@TOG,0,0,'Horrible! Well, all right,maybe it just needs a little cleaning up?',12,0,100,0,0,0,'Tog Rustsprocket reply');
-- Add SAI for Milli Featherwhistle
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@MILLI;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@MILLI;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@MILLI,0,0,0,8,0,100,1,74222,0,0,0,1,0,2000,0,0,0,0,11,@MEKKATORQUE,10,0,0.0,0.0,0.0,0.0,'Milli Featherwhistle - On spell hit - High Tinker Mekkatorque say part1'),
(@MILLI,0,1,0,52,0,100,0,0,@MEKKATORQUE,0,0,1,1,4000,0,0,0,0,11,@MEKKATORQUE,10,0,0.0,0.0,0.0,0.0,'Milli Featherwhistle - On text over - High Tinker Mekkatorque say part2'),
(@MILLI,0,2,3,52,0,100,0,1,@MEKKATORQUE,0,0,1,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,'Milli Featherwhistle - On text over - Reply'),
(@MILLI,0,3,4,61,0,100,0,0,0,0,0,33,@MILLI,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,'Milli Featherwhistle - On link - credit quest'),
(@MILLI,0,4,0,61,0,100,0,0,0,0,0,45,1,1,0,0,0,0,11,@MEKKATORQUE,10,0,0.0,0.0,0.0,0.0,'Milli Featherwhistle - On link - set data 1');
-- Add SAI for Ozzie Togglevolt
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@OZZIE;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@OZZIE;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@OZZIE,0,0,0,8,0,100,1,74222,0,0,0,1,2,2000,0,0,0,0,11,@MEKKATORQUE,10,0,0.0,0.0,0.0,0.0,'Ozzie Togglevolt - On spell hit - High Tinker Mekkatorque say part1'),
(@OZZIE,0,1,0,52,0,100,0,2,@MEKKATORQUE,0,0,1,3,4000,0,0,0,0,11,@MEKKATORQUE,10,0,0.0,0.0,0.0,0.0,'Ozzie Togglevolt - On text over - High Tinker Mekkatorque say part2'),
(@OZZIE,0,2,0,52,0,100,0,3,@MEKKATORQUE,0,0,1,4,4000,0,0,0,0,11,@MEKKATORQUE,10,0,0.0,0.0,0.0,0.0,'Ozzie Togglevolt - On text over - High Tinker Mekkatorque say part3'),
(@OZZIE,0,3,4,52,0,100,0,4,@MEKKATORQUE,0,0,1,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,'Ozzie Togglevolt - On text over - Reply'),
(@OZZIE,0,4,5,61,0,100,0,0,0,0,0,33,@OZZIE,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,'Milli Featherwhistle - On link - credit quest'),
(@OZZIE,0,5,0,61,0,100,0,0,0,0,0,45,1,1,0,0,0,0,11,@MEKKATORQUE,10,0,0.0,0.0,0.0,0.0,'Milli Featherwhistle - On link - set data 1');
-- Add SAI for Tog Rustsprocket
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@TOG;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@TOG;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@TOG,0,0,0,8,0,100,1,74222,0,0,0,1,5,2000,0,0,0,0,11,@MEKKATORQUE,10,0,0.0,0.0,0.0,0.0,'Tog Rustsprocket - On spell hit - High Tinker Mekkatorque say part1'),
(@TOG,0,1,0,52,0,100,0,5,@MEKKATORQUE,0,0,1,6,4000,0,0,0,0,11,@MEKKATORQUE,10,0,0.0,0.0,0.0,0.0,'Tog Rustsprocket - On text over - High Tinker Mekkatorque say part2'),
(@TOG,0,2,0,52,0,100,0,6,@MEKKATORQUE,0,0,1,7,4000,0,0,0,0,11,@MEKKATORQUE,10,0,0.0,0.0,0.0,0.0,'Tog Rustsprocket - On text over - High Tinker Mekkatorque say part3'),
(@TOG,0,3,4,52,0,100,0,7,@MEKKATORQUE,0,0,1,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,'Tog Rustsprocket - On text over - Reply'),
(@TOG,0,4,5,61,0,100,0,0,0,0,0,33,@TOG,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,'Tog Rustsprocket - On link - credit quest'),
(@TOG,0,5,0,61,0,100,0,0,0,0,0,45,1,1,0,0,0,0,11,@MEKKATORQUE,10,0,0.0,0.0,0.0,0.0,'Tog Rustsprocket - On link - set data 1');
-- Add SAI for High Tinker Mekkatorque
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@MEKKATORQUE;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@MEKKATORQUE;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@MEKKATORQUE,0,0,0,38,0,100,1,1,1,0,0,41,1000,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,'High Tinker Mekkatorque - on data set- despawn');
-- add prev quest id to both Words for Delivery
UPDATE `quest_template` SET `PrevQuestId`=25283 WHERE `Id`=25500;-- below 75
UPDATE `quest_template` SET `PrevQuestId`=25283 WHERE `Id`=25286;-- 75+
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Where the Wild Things Roam by Shlomi155 (Issue 3038)
-- Quest item will work only at Dragonblight and if the quest is incomplete!
DELETE FROM `conditions` WHERE SourceEntry=47627;
INSERT INTO `conditions` VALUES
(17,0,47627,0,0,9,0,12111,0,0,0,0,'',NULL),
(17,0,47627,0,0,23,0,65,0,0,0,0,'',NULL);
UPDATE `creature_template` SET AIName='SmartAI' WHERE entry IN (26615,26482);
DELETE FROM `creature_ai_scripts`where creature_id IN (26615,26482);
DELETE FROM `smart_scripts` WHERE entryorguid IN (26615,26482);
INSERT INTO `smart_scripts` VALUES
(26615,0,0,0,9,0,100,1,0,5,8000,12000,11,15976,0,0,0,0,0,2,0,0,0,0,0,0,0,'Snowfall Elk - Cast Puncture'),
(26615,0,1,2,23,0,100,1,47628,1,1,1,11,47675,0,0,0,0,0,1,0,0,0,0,0,0,0,'Snowfall Elk - On Aura - Cast Recently Inoculated'),
(26615,0,2,3,61,0,100,1,0,0,0,0,33,26895,0,0,0,0,0,18,40,0,0,0,0,0,0,'Snowfall Elk - Event Linked - Credit'),
(26615,0,3,0,61,0,100,1,0,0,0,0,41,5000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Snowfall Elk - Event Linked - Despawn Delay 5 Seconds'),
(26482,0,0,1,23,0,100,1,47628,1,1,1,11,47675,0,0,0,0,0,1,0,0,0,0,0,0,0,'Arctic Grizzly - On Aura - Cast Recently Inoculated'),
(26482,0,1,2,61,0,100,1,0,0,0,0,33,26882,0,0,0,0,0,18,40,0,0,0,0,0,0,'Arctic Grizzly - Event Linked - Credit'),
(26482,0,2,0,61,0,100,1,0,0,0,0,41,5000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Arctic Grizzly - Event Linked - Despawn Delay 5 Seconds');
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- [Q] [A/H] Catch the Wild Wolpertinger! by Discover (Issue 3131)
-- Wild Wolpertinger SAI
SET @WOLPERTINGER :=23487;
SET @SPELL_NET    :=41621;
SET @SPELL_CREATE_ITEM :=41622;
UPDATE `creature_template` SET `AIName`='SmartAI',`unit_flags`=`unit_flags`|512 WHERE `entry`=@WOLPERTINGER;
UPDATE `creature` SET `position_x`=24.539537 WHERE `guid`=207045 AND `id`=@WOLPERTINGER; -- For some reason this one was spawned in air
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@WOLPERTINGER;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@WOLPERTINGER;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@WOLPERTINGER,0,0,1,8,0,100,0,@SPELL_NET,0,0,0,11,@SPELL_CREATE_ITEM,2,0,0,0,0,7,0,0,0,0,0,0,0,"Wild Wolpertinger - On Spellhit - Cast Create Stunned Wolpertinger Item"),
(@WOLPERTINGER,0,1,0,61,0,100,0,0,0,0,0,41,4000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Wild Wolpertinger - On Spellhit - Forced Despawn");
-- Condition for spell Wolpertinger Net
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=@SPELL_NET;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition` ,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(17,0,@SPELL_NET,0,0,31,1,3,@WOLPERTINGER,0,0,0,'','Net can only hit Wolpertingers');
-- Update Wolpetinger flags to remove immunity to players,was 768 before
UPDATE `creature_template` SET `unit_flags`=512 WHERE `entry`=@WOLPERTINGER;
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Fix quest Blinding the Eyes in the Sky ID: 13313 by Trista (Issue 3225)
SET @ReconFighter :=32189;
SET @Spell        :=60079;
-- Add SAI support Skybreaker Recon
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ReconFighter;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ReconFighter;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ReconFighter,0,0,1,8,0,100,0,@Spell,0,0,0,33,@ReconFighter,0,0,0,0,0,7,0,0,0,0,0,0,0,'Skybreaker Recon - On spell hit - Give kill credit to invoker'),
(@ReconFighter,0,1,0,61,0,100,0,0,0,0,0,37,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Skybreaker Recon - Linked with previous event - Kill self');
-- Update Vehicle_Accesorry to die along with the vehicle,otherwise little untargetable dwards fall on ground
UPDATE `vehicle_template_accessory` SET `minion`=1 WHERE `entry`=32189 AND `seat_id`=0;
-- Add conditions for spell to target only alive Recons
DELETE FROM `conditions` WHERE `SourceEntry`=@Spell and `SourceTypeOrReferenceId`=17;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES 
(17,0,@Spell,0,0,36,1,0,0,0,0,0,'','Fire SGM-3 can hit only alive Recon Fighter'),
(17,0,@Spell,0,0,31,1,3,@ReconFighter,0,0,0,'','Fire SGM-3 can hit Recon Fighter');
-- Keeping the Alliance Blind ID: 13331 quest requirements
UPDATE `quest_template` SET `PrevQuestId`=13313 WHERE `Id`=13331;
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Cleansing Drak'Tharon by gecko32 (Issue 3351)
-- Update Item Enduring Mojo is normal drop not quest drop
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = ABS(`ChanceOrQuestChance`) WHERE `item`=38303;
-- Add gossip menu option
DELETE FROM `gossip_menu_option` WHERE `menu_id`=9615 AND `id`=1;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES 
(9615,1,0,'I need another of your elixirs, Drakuru.',1,1,0,0,0,0,'');
-- Add Conditions for Gossip
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=9615 AND `SourceEntry`=1;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES 
(15,9615,1,0,1,2,0,35797,1,0,1,0,'','Drakuru''s Elixir - Must not already have item'),
(15,9615,1,0,1,28,0,11991,0,0,0,0,'','Drakuru''s Elixir - Must have quest Subject to Interpretation'),
(15,9615,1,0,2,2,0,35797,1,0,1,0,'','Drakuru''s Elixir - Must not already have item'),
(15,9615,1,0,2,9,0,12007,0,0,0,0,'','Drakuru''s Elixir - Must have quest Sacrifices Must be Made'),
(15,9615,1,0,3,2,0,35797,1,0,1,0,'','Drakuru''s Elixir - Must not already have item'),
(15,9615,1,0,3,28,0,12802,0,0,0,0,'','Drakuru''s Elixir - Must have quest My Heart is in Your Hands'),
(15,9615,1,0,4,2,0,35797,1,0,1,0,'','Drakuru''s Elixir - Must not already have item'),
(15,9615,1,0,4,9,0,12068,0,0,0,0,'','Drakuru''s Elixir - Must have quest Voices From the Dust'),
(15,9615,1,0,5,2,0,35797,1,0,1,0,'','Drakuru''s Elixir - Must not already have item'),
(15,9615,1,0,5,28,0,12238,0,0,0,0,'','Drakuru''s Elixir - Must have quest Cleansing Drak''Tharon');
-- Add SmartAI to give item
DELETE FROM `smart_scripts` WHERE `entryorguid`=26423 AND `id` IN (2,3);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(26423,0,2,3,62,0,100,0,9615,1,0,0,11,50021,2,0,0,0,0,7,0,0,0,0,0,0,0,'Drakuru - On gossip option select - cast Replace Drakuru''s Elixir'),
(26423,0,3,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Drakuru - On gossip option select - close gossip');
-- Add TEMP Drakuru's Brazier In Drak'tharon Keep
DELETE FROM `gameobject` WHERE `guid`=364;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES 
(364,300188,600,3,1,-236.766,-614.774,116.487,1.5708,0,0,0,1,300,100,1);
-- Conditions for spell Target
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=47110;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES 
(13,1,47110,0,1,31,0,3,26498,0,0,0,'',NULL),-- Drakuru's Bunny 01
(13,1,47110,0,2,31,0,3,26559,0,0,0,'',NULL),-- Drakuru's Bunny 02
(13,1,47110,0,3,31,0,3,26700,0,0,0,'',NULL),-- Drakuru's Bunny 03
(13,1,47110,0,4,31,0,3,26789,0,0,0,'',NULL),-- Drakuru's Bunny 04
(13,1,47110,0,5,31,0,3,28015,0,0,0,'',NULL); -- Drakuru's Bunny 05
-- Add Smart AI Drakuru Bunny
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (26498,26559,26700,26789,28015);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (26498,26559,26700,26789,28015);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(26498,0,0,0,8,0,100,0,47110,0,0,0,12,26500,3,50000,0,0,0,8,0,0,0,3386.26,-1805.32,114.909,4.945,'Drakuru Bunny 01- On Spellhit - Summmon Image of Drakuru'),
(26559,0,0,0,8,0,100,0,47110,0,0,0,12,26543,3,50000,0,0,0,8,0,0,0,4243.98,-2025.08,238.248,1.431,'Drakuru Bunny 02- On Spellhit - Summmon Image of Drakuru'),
(26700,0,0,0,8,0,100,0,47110,0,0,0,12,26701,3,50000,0,0,0,8,0,0,0,4523.94,-3472.9,228.393,-0.803,'Drakuru Bunny 03- On Spellhit - Summmon Image of Drakuru'),
(26789,0,0,0,8,0,100,0,47110,0,0,0,12,26787,3,50000,0,0,0,8,0,0,0,4599.09,-4875.82,48.956,0.748,'Drakuru Bunny 04- On Spellhit - Summmon Image of Drakuru'),
(28015,0,0,0,8,0,100,0,47110,0,0,0,12,28016,3,50000,0,0,0,8,0,0,0,-236.77,-618.61,116.475,4.727,'Drakuru Bunny 05- On Spellhit - Summmon Drakuru');
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Fix Neutralizing the Cauldrons (11647) quest by Shlomi1515 (Issue 3432)
UPDATE `creature_template` SET flags_extra='128', AIName='SmartAI' WHERE entry IN (25493,25490,25492);
DELETE FROM `smart_scripts` WHERE entryorguid IN (25493,25490,25492);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(25493,0,0,0,8,0,100,0,45653,0,0,0,33,25493,0,0,0,0,0,7,0,0,0,0,0,0,0,'West Enkilah Cauldron - On Spell Hit - Kil Credit'),
(25490,0,0,0,8,0,100,0,45653,0,0,0,33,25490,0,0,0,0,0,7,0,0,0,0,0,0,0,'East Enkilah Cauldron - On Spell Hit - Kil Credit'),
(25492,0,0,0,8,0,100,0,45653,0,0,0,33,25492,0,0,0,0,0,7,0,0,0,0,0,0,0,'Central Enkilah Cauldron - On Spell Hit - Kil Credit');
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Hallow's End Treats for Jesper/spoops 8311/8312 (Issue 3548)
-- Flexing for Nougat (Alliance)
SET @INNKEEPER=6740;
SET @QUEST=8356;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@INNKEEPER AND `id`=2;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@INNKEEPER,0,2,0,22,0,100,0,41,0,0,0,33,@INNKEEPER,0,0,0,0,0,7,0,0,0,0,0,0,0,'Innkeeper Allison - on /flex credit for quest');
DELETE FROM `conditions` WHERE `SourceEntry`=@QUEST;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES 
(19,0,@QUEST,0,12,12,0,0,0,'',NULL);
-- Chicken Clucking for a Mint (Alliance)
SET @INNKEEPER=5111;
SET @QUEST=8353;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@INNKEEPER AND `id`=2;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@INNKEEPER,0,2,0,22,0,100,0,22,0,0,0,33,@INNKEEPER,0,0,0,0,0,7,0,0,0,0,0,0,0,'Innkeeper Firebrew - on /chicken credit for quest');
DELETE FROM `conditions` WHERE `SourceEntry`=@QUEST;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES 
(19,0,@QUEST,0,12,12,0,0,0,'',NULL);
-- Dancing for Marzipan (Alliance)
SET @INNKEEPER=6735;
SET @QUEST=8357;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@INNKEEPER AND `id`=2;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@INNKEEPER,0,2,0,22,0,100,0,34,0,0,0,33,@INNKEEPER,0,0,0,0,0,7,0,0,0,0,0,0,0,'Innkeeper Saelienne - on /dance credit for quest');
DELETE FROM `conditions` WHERE `SourceEntry`=@QUEST;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES 
(19,0,@QUEST,0,12,12,0,0,0,'',NULL);
-- Incoming Gumdrop (Alliance)
SET @INNKEEPER=6826;
SET @QUEST=8355;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@INNKEEPER;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@INNKEEPER;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@INNKEEPER,0,0,0,22,0,100,0,264,0,0,0,33,@INNKEEPER,0,0,0,0,0,7,0,0,0,0,0,0,0,'Talvash del Kissel - on /train credit for quest');
DELETE FROM `conditions` WHERE `SourceEntry`=@QUEST;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES 
(19,0,@QUEST,0,12,12,0,0,0,'',NULL);
-- Flexing for Nougat (Horde)
SET @INNKEEPER=6929;
SET @QUEST=8359;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@INNKEEPER AND `id`=2;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@INNKEEPER,0,2,0,22,0,100,0,41,0,0,0,33,@INNKEEPER,0,0,0,0,0,7,0,0,0,0,0,0,0,'Innkeeper Gryshka - on /flex credit for quest');
DELETE FROM `conditions` WHERE `SourceEntry`=@QUEST;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES 
(19,0,@QUEST,0,12,12,0,0,0,'',NULL);
-- Chicken Clucking for a Mint (Horde)
SET @INNKEEPER=6741;
SET @QUEST=8354;
-- SAI
UPDATE `smart_scripts` SET `link`=3 WHERE `entryorguid`=@INNKEEPER AND `id`=2;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@INNKEEPER AND `id`=3;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@INNKEEPER,0,3,0,61,0,100,0,0,0,0,0,15,@QUEST,0,0,0,0,0,7,0,0,0,0,0,0,0,'Innkeeper Norman - Link - exploreded for quest');
-- conditions
DELETE FROM `conditions` WHERE `SourceEntry`=@QUEST;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(19,0,@QUEST,0,0,12,0,12,0,0,0,0,'',"Quest avialable only during Hallow's End event");
-- Dancing for Marzipan (Horde)
SET @INNKEEPER=6746;
SET @QUEST=8360;
SET @GOSSIP=21215;
UPDATE `creature_template` SET `AIName`='SmartAI',`ScriptName`='' WHERE `entry`=@INNKEEPER;
-- Add trick or treat SAI since the .cpp script was removed
DELETE FROM `smart_scripts` WHERE `entryorguid`=@INNKEEPER;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@INNKEEPER,0,0,1,62,0,100,0,@GOSSIP,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Innkeeper Pala - On gossip option 0 select - Close gossip'),
(@INNKEEPER,0,1,0,61,0,100,0,0,0,0,0,85,24751,0,0,0,0,0,7,0,0,0,0,0,0,0,'Innkeeper Pala - On gossip option 0 select - Player cast Trick or Treat on self'),
(@INNKEEPER,0,2,0,22,0,100,0,34,0,0,0,33,@INNKEEPER,0,0,0,0,0,7,0,0,0,0,0,0,0,'Innkeeper Pala - on /dance credit for quest');
-- Add gossip menu option for trick or treat
DELETE FROM `gossip_menu_option` WHERE `menu_id`=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES 
(@GOSSIP,1,5,'Make this inn your home.',8,65536,0,0,0,0,''),
(@GOSSIP,2,1,'I want to browse your goods',3,128,0,0,0,0,''),
(@GOSSIP,0,0,'Trick or Treat!',1,1,0,0,0,0,'');
-- Add conditions must be hallows end for Dancing for Marzipan quest and trick or treat option
DELETE FROM `conditions` WHERE `SourceEntry`=@QUEST;
DELETE FROM `conditions` WHERE `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES 
(19,0,@QUEST,0,12,12,0,0,0,'',NULL),
(15,@GOSSIP,0,0,12,12,0,0,0,'',NULL);
-- Incoming Gumdrop (Horde)
SET @INNKEEPER=11814;
SET @QUEST=8358;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@INNKEEPER;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@INNKEEPER;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@INNKEEPER,0,0,0,22,0,100,0,264,0,0,0,33,@INNKEEPER,0,0,0,0,0,7,0,0,0,0,0,0,0,'Kali Remik - on /train credit for quest');
DELETE FROM `conditions` WHERE `SourceEntry`=@QUEST;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES 
(19,0,@QUEST,0,12,12,0,0,0,'',NULL);
 
 
/* 
* updates\world\2012_11_14_02_world_battleground_template.sql 
*/ 
DELETE FROM `battleground_template` WHERE `id` = 6;
INSERT INTO `battleground_template` (`id`, `MinPlayersPerTeam`, `MaxPlayersPerTeam`, `MinLvl`, `MaxLvl`, `AllianceStartLoc`, `AllianceStartO`, `HordeStartLoc`, `HordeStartO`, `StartMaxDist`, `Weight`, `ScriptName`, `Comment`) VALUES
(6,0,2,10,80,0,0,0,0,0,1,'','All Arena');
 
 
/* 
* updates\world\2012_11_16_00_world_utgarde.sql 
*/ 
-- Frenzied geist
DELETE FROM `creature_loot_template` WHERE `entry`=31671;
-- Savage worg
DELETE FROM `creature_loot_template` WHERE `entry`=31678 AND `item` IN(39211,39212,33454);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `mincountOrRef`, `maxcount`) VALUES 
(31678,39211,70,3,5),
(31678,39212,16,2,4),
(31678,33454, 3,1,1);

-- Keleseth
UPDATE `creature_template` SET `mechanic_immune_mask`=617289692 WHERE `entry` IN(23953,30748);
-- Tunneling ghoul
DELETE FROM `creature_loot_template` WHERE `entry`=31681;
-- Dalronn heartsplitter
UPDATE `creature_template` SET `mindmg`=380,`maxdmg`=580,`attackpower`=0,`dmg_multiplier`=10 WHERE `entry`=31660;
-- Frenzied geist
UPDATE `creature_template` SET `lootid`=28419 WHERE `entry`=31671;
UPDATE `creature_template` SET `AIName`='SmartAI',`ScriptName`='' WHERE `entry`=28419;
-- Skarvald the constructor - On level 81 health fits/is blizzlike, depending on wowhead his level range is 72 - 81
UPDATE `creature_template` SET `minlevel`=81,`maxlevel`=81 WHERE `entry`=31679;
-- Tunneling ghoul
UPDATE `creature_template` SET `lootid`=24084 WHERE `entry`=31681;
-- Dragonflayer runecaster
UPDATE `creature_template` SET `ScriptName`='',`AIName`='SmartAI' WHERE `entry`=23960;
-- Dragonflayer strategist
UPDATE `creature_template` SET `minlevel`=80,`maxlevel`=80,`unit_flags`=`unit_flags`|131072 WHERE `entry`=32246;
-- Ingvar and undead Ingvar
UPDATE `creature_template` SET `mindmg`=650,`maxdmg`=900,`attackpower`=200, `dmg_multiplier`=10 WHERE `entry` IN(31673,31674);
UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`|1  WHERE `entry` IN(23954,31673,23980,31674);
-- Throw axe dummy
UPDATE `creature_template` SET `unit_flags`=2|131072|33554432, `flags_extra`=`flags_extra`|2, `equipment_id`=720 WHERE `entry` IN(23997,31835);
-- Throw axe target
UPDATE `creature_template` SET `unit_flags`=2|4|256|512, `faction_A`=35, `faction_H`=35, `flags_extra`=`flags_extra`|128 WHERE `entry`=23996;

-- Dragonflayer runecaster
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=23960;
DELETE FROM `smart_scripts` WHERE `entryorguid`=23960 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `id`, `event_type`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `target_type`, `target_param2`, `comment`) VALUES 
(23960,1,0,2,5000,7000,14000,17000,11,42740,11,30,'Dragonflayer Runecaster - In combat - Cast Njords Rune of Protection'),
(23960,2,0,4,5000,7000,14000,17000,11,59616,11,30,'Dragonflayer Runecaster - In combat - Cast Njords Rune of Protection'),
(23960,3,0,2,1000,2000,15000,18000,11,54965, 1, 0,'Dragonflayer Runecaster - In combat - Cast Bolthorns Rune of Flame'),
(23960,4,0,4,1000,2000,15000,18000,11,59617, 1, 0,'Dragonflayer Runecaster - In combat - Cast Bolthorns Rune of Flame');

-- Frenzied geist
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=28419;
DELETE FROM `smart_scripts` WHERE `entryorguid`=28419 AND `source_type`=0;
INSERT INTO `smart_scripts`(`entryorguid`,`event_type`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`target_type`,`comment`) VALUES
(28419,0,5000,5000,30000,30000,11,40414,5,'Frenzied geist - In combat - Cast Fixate');

-- Difficulty data for spells used in utgarde keep
DELETE FROM `spelldifficulty_dbc` WHERE `id` IN(42669,42708,42750,42723,42729,43667,42702,50653,43931) OR `spellid0` IN(42669,42708,42750,42723,42729,43667,42702,50653,43931);
INSERT INTO `spelldifficulty_dbc`(`id`,`spellid0`,`spellid1`) VALUES
(42669,42669,59706), -- Smash
(42708,42708,59708), -- Staggering Roar
(42750,42750,59719), -- Throw Axe
(42723,42723,59709), -- Dark Smash
(42729,42729,59734), -- Dreadful Roar
(43667,43667,59389), -- Shadow Bolt
(42702,42702,59397), -- Decrepify
(50653,50653,59692), -- Flame Breath
(43931,43931,59691); -- Rend

-- Ticking Time Bomb, Fixate
DELETE FROM `spell_script_names` WHERE `spell_id` IN(59686,40414);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES 
(59686,'spell_ticking_time_bomb'),
(40414,'spell_fixate');

-- Proto-drake striders
UPDATE `creature` SET `position_x`=212.429,`position_y`=-127.793,`position_z`=256.101,`MovementType`=2 WHERE `guid`=125914;
UPDATE `creature` SET `position_x`=211.854,`position_y`=-112.602,`position_z`=262.188,`MovementType`=2 WHERE `guid`=125915;
UPDATE `creature` SET `position_x`=211.024,`position_y`=-100.299,`position_z`=266.201,`MovementType`=2 WHERE `guid`=125920;
UPDATE `creature` SET `position_x`=213.777,`position_y`=-140.709,`position_z`=251.048,`MovementType`=2 WHERE `guid`=125922;
UPDATE `creature` SET `position_x`=252.247,`position_y`=-350.532,`position_z`=185.813,`MovementType`=2 WHERE `guid`=125934;
UPDATE `creature` SET `position_x`=243.964,`position_y`=-194.833,`position_z`=227.126,`MovementType`=2 WHERE `guid`=125936;
UPDATE `creature` SET `position_x`=221.534,`position_y`=-239.809,`position_z`=196.459,`MovementType`=2 WHERE `guid`=125937;
UPDATE `creature` SET `position_x`=238.382,`position_y`=-353.086,`position_z`=188.785,`MovementType`=2 WHERE `guid`=125940;

-- Waypoint assignments
DELETE FROM `creature_addon` WHERE `guid` IN (125940,125934,125915,125920,125914,125936,125937,125922);
INSERT INTO `creature_addon`(`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`auras`) VALUES
(125914,1259140,22657,50331648,1,'54775'),
(125915,1259150,22657,50331648,1,'54775'),
(125920,1259200,22657,50331648,1,'54775'),
(125922,1259220,22657,50331648,1,'54775'),
(125934,1259340,22657,50331648,1,'54775'),
(125936,1259360,22657,50331648,1,'54775'),
(125937,1259370,22657,50331648,1,'54775'),
(125940,1259400,22657,50331648,1,'54775');

-- Waypoint data
DELETE FROM `waypoint_data` WHERE `id` IN (1259400,1259340,1259150,1259200,1259140,1259360,1259370,1259220);
INSERT INTO `waypoint_data`(`id`,`point`,`position_x`,`position_y`,`position_z`) VALUES
(1259400,1,211.864,-352.629,196.144),
(1259340,1,271.911,-318.506,185.049),
(1259150,1,265.478,-199.246,186.812),
(1259200,1,346.765,-99.2527,220.519),
(1259140,1,295.597,-181.162,207.374),
(1259360,1,271.68,-194.911,220.248),
(1259370,1,238.947,-255.704,191.639),
(1259220,1,149.42,-247.696,194.145);

INSERT INTO `waypoint_data`(`id`,`point`,`position_x`,`position_y`,`position_z`)
SELECT `guid`*10,2,`position_x`,`position_y`,`position_z` FROM `creature` WHERE `guid` IN (125940,125934,125915,125920,125914,125936,125937,125922);
 
 
/* 
* updates\world\2012_11_16_01_world_utgarde.sql 
*/ 
-- Areatrigger script
DELETE FROM `areatrigger_scripts` WHERE `entry`=4838;
INSERT INTO `areatrigger_scripts`(`entry`,`ScriptName`) VALUES
(4838,'SmartTrigger');

DELETE FROM `smart_scripts` WHERE `entryorguid`=4838 AND `source_type`=2;
INSERT INTO `smart_scripts`(`entryorguid`,`source_type`,`event_type`,`event_param1`,`action_type`,`action_param1`,`action_param2`,`target_type`,`target_param1`,`comment`) VALUES
(4838,2,46,4838,45,28,6,10,125946,'Areatrigger in Utgarde Keep near Ingvar - On trigger - Set data of Enslaved Proto Drake');

-- Template updates for proto drake and rider
UPDATE `creature_template` SET `AIName`='',`ScriptName`='npc_enslaved_proto_drake' WHERE `entry`=24083; -- Proto drake non heroic
UPDATE `creature_template` SET `InhabitType`=4 WHERE `entry` IN (24849,31676); -- Proto drake rider

-- Waypoints for core script
DELETE FROM `waypoint_data` WHERE `id`=125946;
INSERT INTO `waypoint_data`(`id`,`point`,`position_x`,`position_y`,`position_z`,`move_flag`) VALUES 
(125946,1,210.92,-185.92,203.729,1),
(125946,2,215.397,-181.239,205.773,1),
(125946,3,219.674,-176.469,202.97,1),
(125946,4,223.183,-172.761,200.058,1),
(125946,5,228.007,-168.952,196.713,1),
(125946,6,230.514,-167.104,195.116,1),
(125946,7,235.687,-163.455,192.13,1),
(125946,8,239.569,-161.025,190.346,1);

-- Mount the rider to the drake
DELETE FROM `vehicle_template_accessory` WHERE `entry`=24083;
INSERT INTO `vehicle_template_accessory`(`entry`,`accessory_entry`,`seat_id`,`minion`,`description`,`summontype`,`summontimer`) VALUES
(24083,24849,0,0,'Proto Drake Rider mounted to Enslaved Proto Drake',6,30000);

-- Create required spellclick information
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry`=24083;
INSERT INTO `npc_spellclick_spells`(`npc_entry`,`spell_id`,`cast_flags`) VALUES
(24083,55074,1);

-- Remove no longer needed data
DELETE FROM `creature` WHERE `guid`=125912 AND `map`=574 AND `id`=24849;
DELETE FROM `creature_addon` WHERE `guid`=125912;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=24083;
 
 
