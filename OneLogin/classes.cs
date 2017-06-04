using System;

namespace OneLogin
{
    // object types
    public class App
    {
        public bool extension {get; set;}
        public string icon {get; set;}
        public string id {get; set;}
        public string login_id {get; set;}
        public string name {get; set;}
        public bool personal {get; set;}
        public bool provisioned {get; set;}
    }

    public class ApiRateLimit
    {
        public int RateLimit {get; set;}
        public int RateLimitRemaining {get; set;}
        public TimeSpan RateLimitReset {get; set;}

        public ApiRateLimit (int RateLimit, int RateLimitRemaining, int RateLimitReset)
        {
            this.RateLimit = RateLimit;
            this.RateLimitRemaining = RateLimitRemaining;
            this.RateLimitReset = new TimeSpan(0, 0, RateLimitReset);
        }
    }

    public class Event
    {
        public string account_id {get; set;}
        public string actor_system {get; set;}
        public string actor_user_id {get; set;}
        public string actor_user_name {get; set;}
        public string app_id {get; set;}
        public string app_name {get; set;}
        public string assuming_acting_user_id {get; set;}
        public string client_id {get; set;}
        public DateTimeOffset? created_at {get; set;}
        public string custom_message {get; set;}
        public string directory_sync_run_id {get; set;}
        public string directory_id {get; set;}
        public string error_description {get; set;}
        public string event_type_id {get; set;}
        public string event_type
        {
            get
            {
                try
                {
                    return Enum.GetName(typeof(EventType), Int32.Parse(this.event_type_id));
                }
                catch
                {
                    return "Unknown";
                }
            }
        }
        public string group_id {get; set;}
        public string group_name {get; set;}
        public string id {get; set;}
        public string ipaddr {get; set;}
        public string notes {get; set;}
        public string operation_name {get; set;}
        public string otp_device_id {get; set;}
        public string otp_device_name {get; set;}
        public string policy_name {get; set;}
        public string policy_id {get; set;}
        public string proxy_ip {get; set;}
        public string resolution {get; set;}
        public string resource_type_id {get; set;}
        public string role_id {get; set;}
        public string role_name {get; set;}
        public string user_id {get; set;}
        public string user_name {get; set;}
    }

    public class Group
    {
        public string id {get; set;}
        public string name {get; set;}
        public string reference {get; set;}
    }

    public class Role
    {
        public string id {get; set;}
        public string name {get; set;}
    }

    public class Token
    {
        public string access_token {get; set;}
        public string account_id {get; set;}
        public string ApiBase {get; set;}
        public DateTimeOffset? created_at {get; set;}
        public DateTimeOffset? expires_at
        {
            get
            {
                return this.created_at.Value.AddSeconds(this.expires_in);
            }
        }
        public int expires_in {get; set;}
        public string refresh_token {get; set;}
        public string token_type {get; set;}
    }

    public class User
    {
        public DateTimeOffset? activated_at { get; set; }
        public string company { get; set; }
        public DateTimeOffset? created_at { get; set; }
        public object[] custom_attributes { get; set; }
        public string department { get; set; }
        public string directory_id {get; set;}
        public string distinguished_name {get; set;}
        public string email {get; set;}
        public string external_id {get; set;}
        public string firstname {get; set;}
        public string group_id {get; set;}
        public string id {get; set;}
        public string invalid_login_attempts {get; set;}
        public DateTimeOffset? invitation_sent_at {get; set;}
        public string lastname {get; set;}
        public DateTimeOffset? last_login {get; set;}
        public string locale_code {get; set;}
        public DateTimeOffset? locked_until {get; set;}
        public string manager_ad_id {get; set;}
        public string member_of {get; set;}
        public string[] notes {get; set;}
        public string openid_name {get; set;}
        public DateTimeOffset? password_changed_at {get; set;}
        public string phone {get; set;}
        public string[] role_id {get; set;}
        public string samaccountname {get; set;}
        public string state {get; set;}
        public string status {get; set;}
        public string status_value
        {
            get
            {
                try
                {
                    return Enum.GetName(typeof(UserStatus), Int32.Parse(this.status));
                }
                catch
                {
                    return "Unknown";
                }
            }
        }
        public string title {get; set;}
        public DateTimeOffset? updated_at {get; set;}
        public string username {get; set;}
        public string userprincipalname {get; set;}

        public override string ToString() { return this.id; }
    }

    // enums
    public enum RoleFilterParameter
    {
        name
    }

    public enum AdminRegion
    {
        us,
        eu
    }

    public enum EventFilterParameter
    {
        client_id,
        created_at,
        directory_id,
        event_type_id,
        resolution,
        user_id
    }

    public enum UserFilterParameter
    {
        directory_id,
        email,
        external_id,
        firstname,
        lastname,
        manager_ad_id,
        role_id,
        samaccountname,
        username,
        userprincipalname
    }

    public enum UserStatus
    {
        Unactivated,
        Active,
        Suspended,
        Locked,
        PasswordExpired,
        AwaitingPasswordReset,
        Pending,
        PendingPassword,
        SecurityQuestionsRequired
    }

    public enum EventType
    {
        App_added_to_role                                                        = 1,
        App_removed_from_role                                                    = 2,
        Acting_user_assumed_user                                                 = 3,
        Role_assigned_to_user                                                    = 4,
        User_logged_in_to_OneLogin                                               = 5,
        User_login_to_OneLogin_failed                                            = 6,
        User_logged_out_of_OneLogin                                              = 7,
        User_logged_in_to_app                                                    = 8,
        User_requested_new_password                                              = 10,
        User_changed_password                                                    = 11,
        User_unlocked                                                            = 12,
        User_created                                                             = 13,
        User_updated                                                             = 14,
        User_deactivated                                                         = 15,
        User_activated                                                           = 16,
        User_deleted                                                             = 17,
        Admin_approved_password_request                                          = 18,
        User_locked                                                              = 19,
        User_limit_reached                                                       = 20,
        User_suspended                                                           = 21,
        User_registered_OTP_device                                               = 22,
        User_triggered_bulk_operation                                            = 23,
        User_deregistered_OTP_device                                             = 24,
        Provisioning_exception                                                   = 25,
        Provisioning_event                                                       = 26,
        User_downloaded_browser_certificate                                      = 27,
        User_recently_removed                                                    = 28,
        User_logged_out_of_app                                                   = 29,
        Updated_payment_info                                                     = 30,
        Failed_update_to_payment_info                                            = 31,
        User_reactivated                                                         = 32,
        User_imported_from_directory                                             = 33,
        User_requested_access_to_app                                             = 34,
        User_locked_out_of_app                                                   = 35,
        User_lost_OTP_device                                                     = 36,
        User_requested_join                                                      = 37,
        App_reached_user_limit                                                   = 38,
        Connector_broken                                                         = 39,
        User_unlocked_OTP_device                                                 = 40,
        Active_Directory_Connector_started                                       = 41,
        Active_Directory_Connector_stopped                                       = 42,
        Active_Directory_Connector_configuration_reloaded                        = 43,
        Active_Directory_Connector_notification                                  = 44,
        Active_Directory_Connector_exception                                     = 45,
        Active_Directory_Connector_failed_over                                   = 46,
        Active_Directory_Connector_exception2                                    = 47,
        User_imported                                                            = 48,
        Update_to_user_failed                                                    = 49,
        User_rejected                                                            = 50,
        User_created_in_app                                                      = 51,
        User_updated_in_app                                                      = 52,
        User_suspended_in_app                                                    = 53,
        User_reactivated_in_app                                                  = 54,
        User_deleted_in_app                                                      = 55,
        Unmatched_users                                                          = 56,
        User_linked_in_app                                                       = 59,
        Provisioning_Deprovisioning_mode_Do_nothing_warning                      = 60,
        User_suspension_failed_in_app                                            = 61,
        User_reactivation_failed_in_app                                          = 62,
        User_deletion_failed_in_app                                              = 63,
        User_creation_failed_in_app                                              = 64,
        User_update_failed_in_app                                                = 65,
        No_users_to_import                                                       = 66,
        Directory_import_exception                                               = 67,
        User_authenticated_by_RADIUS                                             = 68,
        User_rejected_by_RADIUS                                                  = 69,
        Privilege_granted_to_account                                             = 70,
        Privilege_revoked_from_account                                           = 71,
        Privilege_granted_to_user                                                = 72,
        Privilege_revoked_from_user                                              = 73,
        User_added_a_trusted_IdP                                                 = 74,
        User_removed_a_trusted_IdP                                               = 75,
        User_modified_a_Trusted_IdP                                              = 76,
        User_failed_to_login_to_app_via_assertion_proxy                          = 77,
        User_logged_into_app_via_assertion_proxy                                 = 78,
        User_failed_to_provision_in_directory                                    = 79,
        User_created_in_directory                                                = 80,
        User_updated_in_directory                                                = 81,
        User_suspended_in_directory                                              = 82,
        User_reactivated_in_directory                                            = 83,
        User_deleted_in_directory                                                = 84,
        Could_not_authenticate_to_app                                            = 85,
        User_failed_remote_authentication                                        = 86,
        User_viewed_secure_note                                                  = 87,
        User_edited_secure_note                                                  = 88,
        User_deleted_secure_note                                                 = 89,
        Self_registration_requested_for_user                                     = 100,
        Self_registration_approved_for_user                                      = 101,
        Self_registration_denied_for_user                                        = 102,
        SMS_failure                                                              = 105,
        Acting_user_updated_user_login_information                               = 110,
        Acting_user_attempted_to_update_user_login_information                   = 111,
        User_changed_default_trusted_IdP                                         = 112,
        Directory_import_started                                                 = 113,
        Directory_import_finished                                                = 114,
        User_invited                                                             = 115,
        User_creation_failed                                                     = 116,
        Directory_sync_run_ID                                                    = 117,
        SAML_assertion_consumer_service_failed                                   = 118,
        Trusted_IdP_removed_as_default                                           = 119,
        User_unlocked_in_directory                                               = 120,
        Scriptlet_error                                                          = 121,
        User_authenticated_via_API                                               = 122,
        User_authentication_via_API_failed                                       = 123,
        Safe_entitlements_cache_activity_occurred                                = 124,
        Creation_of_new_entitlements_in_a_service_succeeded_or_failed            = 125,
        Directory_connector_enabled                                              = 126,
        Directory_connector_disabled                                             = 127,
        No_Active_Active_Directory_connectors                                    = 128,
        VLDAP_bind_failed                                                        = 129,
        VLDAP_bind_successful                                                    = 130,
        Directory_export_started                                                 = 131,
        Directory_export_finished                                                = 132,
        Directory_export_exception                                               = 133,
        Directory_refresh_schema_exception                                       = 134,
        Certificate_expiration_notice                                            = 135,
        Directory_fields_import_started                                          = 136,
        User_app_request_approved                                                = 137,
        User_app_request_denied                                                  = 138,
        Directory_fields_import_finished                                         = 139,
        Social_sign_in_successful                                                = 140,
        Social_sign_in_failed                                                    = 141,
        Smart_password_updated                                                   = 145,
        Smart_password_update_failed                                             = 146,
        User_manually_added_to_role                                              = 147,
        User_manually_removed_from_role                                          = 148,
        User_automatically_added_to_role                                         = 149,
        User_automatically_removed_from_role                                     = 150,
        Role_management_granted                                                  = 151,
        Role_management_revoked                                                  = 152,
        Mac_login_successful                                                     = 153,
        Mac_login_failed                                                         = 154,
        Import_of_directory_fields_experienced_an_exception                      = 155,
        Policy_created                                                           = 156,
        Policy_updated                                                           = 157,
        Policy_deleted                                                           = 158,
        Proxy_agent_created                                                      = 159,
        Proxy_agent_deleted                                                      = 160,
        RADIUS_configuration_created                                             = 161,
        RADIUS_configuration_updated                                             = 162,
        RADIUS_configuration_deleted                                             = 163,
        VPN_enabled                                                              = 164,
        VPN_settings_updated                                                     = 165,
        VPN_disabled                                                             = 166,
        Embedding_enabled                                                        = 167,
        Embedding_settings_updated                                               = 168,
        Embedding_disabled                                                       = 169,
        Authentication_factor_created                                            = 170,
        Authentication_factor_updated                                            = 171,
        Authentication_factor_deleted                                            = 172,
        Security_questions_updated                                               = 173,
        Desktop_SSO_settings_updated                                             = 174,
        Desktop_SSO_enabled                                                      = 175,
        Desktop_SSO_disabled                                                     = 176,
        Certificate_created                                                      = 177,
        Certificate_deleted                                                      = 178,
        API_credential_created                                                   = 179,
        API_credential_deleted                                                   = 180,
        API_credential_enabled                                                   = 181,
        API_credential_disabled                                                  = 182,
        VLDAP_enabled                                                            = 183,
        VLDAP_disabled                                                           = 184,
        VLDAP_settings_updated                                                   = 185,
        Branding_enabled                                                         = 186,
        Branding_disabled                                                        = 187,
        Branding_updated                                                         = 188,
        Mapping_added                                                            = 189,
        Mapping_deleted                                                          = 190,
        Mapping_disabled                                                         = 191,
        Mapping_enabled                                                          = 192,
        Mapping_updated                                                          = 193,
        User_field_added                                                         = 194,
        User_field_deleted                                                       = 195,
        Company_information_updated                                              = 196,
        Account_settings_updated                                                 = 197,
        Directory_created                                                        = 198,
        Directory_destroyed                                                      = 199,
        Directory_connector_instance_added                                       = 200,
        Directory_connector_instance_deleted                                     = 201,
        Mappings_reapplied                                                       = 202,
        Self_registration_profile_created                                        = 203,
        Self_registration_profile_updated                                        = 204,
        Self_registration_profile_deleted                                        = 205,
        Login_manually_added                                                     = 206,
        Login_manually_removed                                                   = 207,
        Provisioning_retrieved                                                   = 208,
        LDAP_connector_exception                                                 = 210,
        Actor_user_uploaded_profile_picture                                      = 213,
        Actor_user_removed_profile_picture                                       = 214,
        API_bad_request                                                          = 400,
        API_request_unauthorized                                                 = 401,
        Retrieved_all_resources_for_User_or_Group                                = 501,
        Retrieved_resource_by_ID_for_User_or_Group                               = 502,
        Retrieved_custom_attributes_retrieved_apps_or_retrieved_roles_for_a_user = 503,
        Set_password_with_salt                                                   = 510,
        Set_password_using_cleartext                                             = 511,
        Set_custom_attribute_for_a_user                                          = 512,
        Added_role_to_a_user                                                     = 513,
        Removed_role_from_a_user                                                 = 514,
        Issued_session_login_token                                               = 515,
        Logged_user_out_via_API                                                  = 516,
        Failed_to_set_password_with_salt                                         = 517,
        Failed_to_set_password_using_cleartext                                   = 518,
        Failed_to_set_custom_attribute_for_a_user                                = 519,
        Failed_to_add_role_to_a_user                                             = 520,
        Failed_to_remove_role_from_a_user                                        = 521,
        Failed_to_issue_session_login_token                                      = 522,
        Failed_to_log_user_out_via_API                                           = 523,
        Failed_to_delete_user                                                    = 524,
        Failed_to_invite_user                                                    = 525,
        Failed_to_lock_user_account                                              = 526,
        Verification_of_factor_via_API_failed                                    = 527,
        Verified_factor_via_API                                                  = 528,
        Updated_user_via_API                                                     = 529,
        Destroyed_user_via_API                                                   = 530,
        Locked_user_via_API                                                      = 531,
        Update_to_user_via_API_failed                                            = 532,
        Created_user_via_API                                                     = 533,
        Creation_of_user_via_API_failed                                          = 534,
        Get_invite_link_via_API                                                  = 535,
        Send_invite_link_via_API                                                 = 535
    }
}
