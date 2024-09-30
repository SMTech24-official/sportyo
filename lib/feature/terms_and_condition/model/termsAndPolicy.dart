class TermsAndPolicy {
  final String? id;
  final String? policy;
  final String? termsConditions;

  TermsAndPolicy({
     this.id,
     this.policy,
     this.termsConditions,
  });

  factory TermsAndPolicy.fromJson(Map<String, dynamic> json) {
    return TermsAndPolicy(
      id: json['id'],
      policy: json['policy'],
      termsConditions: json['termsConditions'],
    );
  }
}

