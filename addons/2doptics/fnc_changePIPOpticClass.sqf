#include "script_component.hpp"

// force unscheduled environment
if (canSuspend) exitWith {
    isNil FUNC(changePIPOpticClass);
};

params ["_unit"];

if (GVAR(usePipOptics) && {!GVAR(inArsenal)}) then {
    // switch to pip weapon
    private _gun = primaryWeapon _unit;
    private _gunItems = primaryWeaponItems _unit;
    private _gunMagazine = primaryWeaponMagazine _unit;

    private _pipGun = BWA3_PIPOptics getVariable _gun;

    if (!isNil "_pipGun") then {
        private _muzzle = currentMuzzle _unit;
        _unit addWeapon _pipGun;
        if (_muzzle isEqualType "") then {_unit selectWeapon _muzzle};

        {
            _unit addPrimaryWeaponItem _x;
        } forEach _gunItems;

        {
            _unit addWeaponItem [_pipGun, _x];
        } forEach _gunMagazine;

        INFO_2("Switched %1 to %2.",_gun,_pipGun);
    };

    // switch to pip optics
    {
        _x params ["_weapon", "", "", "_optic"]; // ["_weapon", "_muzzle", "_pointer", "_optic", "_magazine", "_bipod"]

        private _pipOptic = BWA3_PIPOptics getVariable _optic;

        if (!isNil "_pipOptic") then {
            _unit addWeaponItem [_weapon, _pipOptic];
            INFO_2("Switched %1 to %2.",_optic,_pipOptic);
        };
    } forEach weaponsItems _unit;
} else {
    // switch to normal weapon
    private _gun = primaryWeapon _unit;
    private _gunItems = primaryWeaponItems _unit;
    private _gunMagazine = primaryWeaponMagazine _unit;

    private _normalGun = BWA3_NonPIPOptics getVariable _gun;

    if (!isNil "_normalGun") then {
        private _muzzle = currentMuzzle _unit;
        _unit addWeapon _normalGun;
        if (_muzzle isEqualType "") then {_unit selectWeapon _muzzle};

        {
            _unit addPrimaryWeaponItem _x;
        } forEach _gunItems;

        {
            _unit addWeaponItem [_normalGun, _x];
        } forEach _gunMagazine;

        INFO_2("Switched %1 to %2.",_gun,_normalGun);
    };

    // switch to normal / 2d optics
    {
        _x params ["_weapon", "", "", "_optic"];

        private _normalOptic = BWA3_NonPIPOptics getVariable _optic;

        if (!isNil "_normalOptic") then {
            _unit addWeaponItem [_weapon, _normalOptic];
            INFO_2("Switched %1 to %2.",_optic,_normalOptic);
        };
    } forEach weaponsItems _unit;
};