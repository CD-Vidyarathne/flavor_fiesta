enum PromoCode { FB10, FB20, FB30 }

extension PromoCodeExtension on PromoCode {
  double get discount {
    switch (this) {
      case PromoCode.FB10:
        return 0.10;
      case PromoCode.FB20:
        return 0.20;
      case PromoCode.FB30:
        return 0.30;
      default:
        return 0.0;
    }
  }
}
