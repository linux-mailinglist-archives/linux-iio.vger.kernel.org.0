Return-Path: <linux-iio+bounces-24244-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5132AB83CD2
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 11:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CDB34834C8
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 09:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3150B19922D;
	Thu, 18 Sep 2025 09:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NkyYxl1f"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C0117E4;
	Thu, 18 Sep 2025 09:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187926; cv=none; b=ITCqRL5jN43G9UQlIzxn3MjNGViNeUqv0yAy/kcQrsUiZw8Q4e2HVtkn4szX1egRa5y45EqXYqvcgqROCOLTZE2GxueCZNJP0nmJogQVXsXVBNnegdvDrTlEfBd5yAOY5OIhFK+C0OzkWJ+3uKu1s2oOLoWzfZyNakqkRBvtcYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187926; c=relaxed/simple;
	bh=5eZEyd1AC0ZFBmocbitX8T9aoTolOlqY6tK2uFS6HHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UnA85/bBwLpShGbEcytSSoWuwJ8sAZaWYFptt2HFT8+u79Hh8ArnsnzVjg+Yq4RgyvTZqlmFHLHSeCaKbD4UkFLEB+2TyY3i3lxRzE+POmZsf+LcNtvM+V7YPbow5U10bqB//eQaMd51Vw1MmXbIhNS4aZfNm7a18YXdqAmwXFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NkyYxl1f; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 386CD43275;
	Thu, 18 Sep 2025 09:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1758187912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=onjKfNwV+vxgpk6WNnxRi5pBsCYrAvbzc4JeZwq2xIY=;
	b=NkyYxl1fyXYCyhT2vwA4JLKkbI98xHie/JMwUjI4JaLnKsbmG8GSnL0f7ILxo0VYRpfuu8
	VoJMrKA71YWe0A3QLrOHKKBvWPRpMwbDlaj16B7WwWprsdLwXFaV4Qw28ge/8wLKuTszTq
	BiZqgC6fj+tbdLQP1CzWgh0xe/6nBHCWaAEJE7xREvGPFRRprhBjwmzCjX/xwMSeUaNGLo
	wBdTfHrxBdzzgjaTwbx6V2nam2/Nma6Pt54F1v6aspZS62MrsvWYcCrY3bq+jy05Fy5M1m
	MeSSu2zo52L3v/5tNoIJAt9IfAEC3VoMF6ftPr4qdnx6o0r7CUyTWtma77kCyw==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/4] regulator: Support the LTM8054 voltage regulator
Date: Thu, 18 Sep 2025 11:31:50 +0200
Message-ID: <12775482.O9o76ZdvQC@fw-rgant>
In-Reply-To: <5205519.GXAFRqVoOG@fw-rgant>
References:
 <20250916-ltm8054-driver-v1-0-fd4e781d33b9@bootlin.com>
 <aMliRTuUDNPkeM8C@smile.fi.intel.com> <5205519.GXAFRqVoOG@fw-rgant>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5954814.DvuYhMxLoT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegheelkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfgggtsehgtderredttdejnecuhfhrohhmpeftohhmrghinhcuifgrnhhtohhishcuoehrohhmrghinhdrghgrnhhtohhishessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfdvleekvefgieejtdduieehfeffjefhleegudeuhfelteduiedukedtieehlefgnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtvdemkeegvdegmeektdekvdemhegrtddumegrtdegvgemfhejieehmeelhegrmegufhekieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemkeegvdegmeektdekvdemhegrtddumegrtdegvgemfhejieehmeelhegrmegufhekiedphhgvlhhopehffidqrhhgrghnthdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhomhgrihhnrdhgrghnthhoihhssegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedugedprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhgihhrugifohhougesghhmrghilhdrtghomhdprhgtphhtthhopegsr
 hhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjihgtvdefsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegulhgvtghhnhgvrhessggrhihlihgsrhgvrdgtohhm
X-GND-Sasl: romain.gantois@bootlin.com

--nextPart5954814.DvuYhMxLoT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Date: Thu, 18 Sep 2025 11:31:50 +0200
Message-ID: <12775482.O9o76ZdvQC@fw-rgant>
In-Reply-To: <5205519.GXAFRqVoOG@fw-rgant>
MIME-Version: 1.0

On Tuesday, 16 September 2025 16:17:56 CEST Romain Gantois wrote:
> Hello Andy,
> 
> On Tuesday, 16 September 2025 15:12:37 CEST Andy Shevchenko wrote:
> > On Tue, Sep 16, 2025 at 12:24:08PM +0200, Romain Gantois wrote:
> > > Add a stub driver for the  Linear Technology LTM8054 Buck-Boost voltage
> > > regulator. This version only supports enabling/disabling the regulator
> > > via
> > > a GPIO, and reporting the output voltage level from the resistor divider
> > > values given in the device tree.
> > 
> > ...
> > 
> > > +#include <linux/module.h>
> > > +#include <linux/of.h>
> > 
> > I think we have already something agnostic in regulator API to get a
> > regulator from a firmware node (rather than from specific OF/etc one).
> 
> IIRC the "of_match" regulator descriptor property can be used for this, I'll
> have a second look and see if I can use that instead.
> 

Looks like I misread your comment sorry, the "of_match" property is pretty 
much irrelevant to using fwnode_* wrappers, and I didn't find any of those in 
the regulator subsystem. I'm missing a Kconfig dependency on "OF" though, I'll 
have to add that.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPart5954814.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmjL0YYACgkQKCYAIARz
eA7hjg/9EDHFPwl1XkRsN30LTB/inIJcd1PSFAc/rAB90loRVPlZ9p7rVUP8/UjD
CAZwL6gV1c985GhwPa6MwnwenxqD0PIoFdaBK0G/xtUutpadZikHFe4hIkPOtbyw
ZgfTobHbczZwGPCfcIv1k5fyekqTtwUOQnpqkoEfd9uiTy1+deoAFZg5tAY3yw5f
VvkAtnOBTerzprJCvMloiY06EM5KLRxsmLdhDj6/CXbHrrO0gmd3+TUyU/903NYo
/XKPZmvrNLdp0Shjj/kEjy/k0xFaE6uBaMdtiMeScooESWqTwzqE8v3Nb3of/uxn
luhRN7YfI7oGbr9uaAefgEAsDiPeFdXWoMdsaVLKzXtcQSNKGUMTQcUEOJfODqVj
Y3Kj0bRz97mfyEu48KZlY63oHVDyQ4d06DIsCJyDEfCTtuTBrzM7GUcUH+oHHCwK
+tlugzb/uwA3Iosgnk2ACQdhzARu4whZZIzrBG8Nihirq805g7QbOvXZNDGIbT6Z
Cki2leoMJp6BOUGMVUkqTNujqw6gWLMHuFAWvx6DPdwylDu7RpbRe6mtO1IpqhA7
Sw5z/rmbjw0+kgloAF2pOBUhFU5wJrcKTpicH9iGf54wlYGY7LZTpkpdct+XLAQD
sqzu3oW7YxBqtpLX9yGYkfOc4AnWJAEqAQrBYY9E0TGtwV3jw60=
=NLaj
-----END PGP SIGNATURE-----

--nextPart5954814.DvuYhMxLoT--




