class Endpoints {
  Endpoints({
    required this.baseUrl,
    required this.checkEmailVerificationCode,
    required this.checkMobileNumberVerificationCode,
    required this.currentDateTime,
    required this.identificationTypes,
    required this.loanDetail,
    required this.login,
    required this.logout,
    required this.microCredit,
    required this.microCredits,
    required this.microCreditsConfirm,
    required this.microCreditUser,
    required this.passwordRecovery,
    required this.personalInfo,
    required this.sendEmailVerificationCode,
    required this.sendMobilePhoneVerificationCode,
    required this.setAppPermissions,
    required this.setDocumentInfo,
    required this.setTermsAndConditions,
    required this.setUserBirthDay,
    required this.setUserInfoUrl,
    required this.setUserPassword,
    required this.setUserSelfie,
    required this.uploadDocumentImage,
    required this.userBirthDay,
    required this.userDevicePermissions,
    required this.userDocumentAndSelfie,
    required this.userGetData,
    required this.userIdentity,
    required this.userUserBasicInfo,
    required this.webViewUrl,
  });

  factory Endpoints.fromMap(Map<String, dynamic> map) => Endpoints(
        baseUrl: map[_AttributesKeys.baseUrl],
        checkEmailVerificationCode:
            map[_AttributesKeys.checkEmailVerificationCode],
        checkMobileNumberVerificationCode:
            map[_AttributesKeys.checkMobileNumberVerificationCode],
        currentDateTime: map[_AttributesKeys.currentDateTime],
        identificationTypes: map[_AttributesKeys.identificationTypes],
        loanDetail: map[_AttributesKeys.loanDetail],
        login: map[_AttributesKeys.login],
        logout: map[_AttributesKeys.logout],
        microCredit: map[_AttributesKeys.microCredit],
        microCredits: map[_AttributesKeys.microCredits],
        microCreditsConfirm: map[_AttributesKeys.microCreditsConfirm],
        microCreditUser: map[_AttributesKeys.microCreditUser],
        passwordRecovery: map[_AttributesKeys.passwordRecovery],
        personalInfo: map[_AttributesKeys.personalInfo],
        sendEmailVerificationCode:
            map[_AttributesKeys.sendEmailVerificationCode],
        sendMobilePhoneVerificationCode:
            map[_AttributesKeys.sendMobilePhoneVerificationCode],
        setAppPermissions: map[_AttributesKeys.setAppPermissions],
        setDocumentInfo: map[_AttributesKeys.setDocumentInfo],
        setTermsAndConditions: map[_AttributesKeys.setTermsAndConditions],
        setUserBirthDay: map[_AttributesKeys.setUserBirthDay],
        setUserInfoUrl: map[_AttributesKeys.setUserInfoUrl],
        setUserPassword: map[_AttributesKeys.setUserPassword],
        setUserSelfie: map[_AttributesKeys.setUserSelfie],
        uploadDocumentImage: map[_AttributesKeys.uploadDocumentImage],
        userBirthDay: map[_AttributesKeys.userBirthDay],
        userDevicePermissions: map[_AttributesKeys.userDevicePermissions],
        userDocumentAndSelfie: map[_AttributesKeys.userDocumentAndSelfie],
        userGetData: map[_AttributesKeys.userGetData],
        userIdentity: map[_AttributesKeys.userIdentity],
        userUserBasicInfo: map[_AttributesKeys.userUserBasicInfo],
        webViewUrl: map[_AttributesKeys.webViewUrl],
      );

  final String baseUrl;
  final String checkEmailVerificationCode;
  final String checkMobileNumberVerificationCode;
  final String currentDateTime;
  final String identificationTypes;
  final String loanDetail;
  final String login;
  final String logout;
  final String microCredit;
  final String microCredits;
  final String microCreditsConfirm;
  final String microCreditUser;
  final String passwordRecovery;
  final String personalInfo;
  final String sendEmailVerificationCode;
  final String sendMobilePhoneVerificationCode;
  final String setAppPermissions;
  final String setDocumentInfo;
  final String setTermsAndConditions;
  final String setUserBirthDay;
  final String setUserInfoUrl;
  final String setUserPassword;
  final String setUserSelfie;
  final String uploadDocumentImage;
  final String userBirthDay;
  final String userDevicePermissions;
  final String userDocumentAndSelfie;
  final String userGetData;
  final String userIdentity;
  final String userUserBasicInfo;
  final String webViewUrl;
}

abstract class _AttributesKeys {
  static const baseUrl = 'baseUrl';
  //* Configurations
  static const currentDateTime = 'currentDateTime';
  static const identificationTypes = 'identificationTypes';
  static const loanDetail = 'loanDetail';
  static const microCredit = 'microCredit';
  static const personalInfo = 'personalInfo';
  //* Registry
  static const checkEmailVerificationCode = 'checkEmailVerificationCode';
  static const checkMobileNumberVerificationCode =
      'checkMobileNumberVerificationCode';
  static const login = 'login';
  static const sendEmailVerificationCode = 'sendEmailVerificationCode';
  static const sendMobilePhoneVerificationCode =
      'sendMobilePhoneVerificationCode';
  static const setAppPermissions = 'setAppPermissions';
  static const setDocumentInfo = 'setDocumentInfo';
  static const setTermsAndConditions = 'setTermsAndConditions';
  static const setUserBirthDay = 'setUserBirthDay';
  static const setUserInfoUrl = 'setUserInfo';
  static const setUserPassword = 'setUserPassword';
  static const uploadDocumentImage = 'uploadDocumentImages';
  static const userBirthDay = 'userBirthDay';
  static const userDevicePermissions = 'userDevicePermissions';
  static const userDocumentAndSelfie = 'userDocumentAndSelfie';
  static const userIdentity = 'userIdentity';
  static const userUserBasicInfo = 'userUserBasicInfo';
  static const webViewUrl = 'webViewUrl';
  static const setUserSelfie = 'setUserSelfie';
  //* Password Recovery;
  static const passwordRecovery = 'passwordRecovery';
  //* Micro Credits
  static const microCredits = 'microCredits';
  static const microCreditsConfirm = 'microCreditsConfirm';
  static const microCreditUser = 'microCreditUser';
  //* Users
  static const userGetData = 'userGetData';
  static const logout = 'logout';
}
