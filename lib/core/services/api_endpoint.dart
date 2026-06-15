class ApiEndpoint {
  // ── Base API URL ─────────────────────────────────────────────────────────
  static String mainDomain = "https://inflanar.mamunuiux.com"; // Replace with your real base domain
  static String baeUrl = "$mainDomain/api/";

  // ── Endpoints ────────────────────────────────────────────────────────────
  // 1. Service List (GET)
  static const String serviceList = "influencers/service?lang_code=en&page=1";

  // 2. Service Create Info (GET)
  static const String serviceCreateInfo = "influencers/service/create?lang_code=en";

  // 3. Service Store (POST)
  static const String serviceStore = "influencers/service?lang_code=en";

  // 4. Service Edit (GET)
  static const String serviceEdit = "influencers/service/{id}?lang_code=en";

  // 5. Service Update (POST)
  static const String serviceUpdate = "influencers/service/{id}?lang_code=en&_method=PUT";

  // 6. Service Delete (DELETE)
  static const String serviceDelete = "influencers/service/{id}?lang_code=en";

  // 7. Website Setup (GET)
  static const String websiteSetup = "website-setup?lang_code=en";

  // 8. Login (POST)
  static const String login = "store-login?lang_code=en";
}
