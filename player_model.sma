/*
    (c) Player Models
    2014 by CryWolf
        eXtreamCS Dev Team
*/
 
#include < amxmodx >
#include < cstrike >
#include < hamsandwich >
 
 
new const 
    PLUGIN_NAME [ ] = "Player Models",
    PLUGIN_VERSION  [ ] = "0.0.1",
    PLUGIN_AUTHOR   [ ] = "CryWolf";
 
// Model CT
new ct_model [ ] =
{
    "models/player/modelct/modelct.mdl"
};
 
// Model Terro
new te_model [ ] =
{
    "models/player/modelte/modelte.mdl"
};
 
#pragma semicolon 1
 
 
public plugin_precache ( )
{
    precache_model ( ct_model );
    precache_model ( te_model );
}
 
public plugin_init ( )
{
    register_plugin ( PLUGIN_NAME, PLUGIN_VERSION, PLUGIN_AUTHOR );
    RegisterHam ( Ham_Spawn, "player", "FunC_HamSpawn", true );
}
 
public FunC_HamSpawn ( iPlayer )
{
    if ( is_user_alive ( iPlayer ) )
        set_task ( random_float ( 1.0, 4.2 ), "FunC_SetModel", iPlayer );
}
 
public FunC_SetModel ( iPlayer )
{
    if ( !is_user_alive ( iPlayer ) )
        return HAM_SUPERCEDE;
    
    client_cmd ( iPlayer, "cl_minmodels 0" );
    
    switch ( cs_get_user_team ( iPlayer ) ) 
    {
        case CS_TEAM_CT: 
        {
            cs_set_user_model ( iPlayer, "modelct" );
        }
        case CS_TEAM_T:
        {
            cs_set_user_model ( iPlayer, "modelte" );
        }
        
        default: return HAM_IGNORED;
        
    }
    return HAM_IGNORED;
}
