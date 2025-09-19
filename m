Return-Path: <linux-iio+bounces-24280-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB872B8861E
	for <lists+linux-iio@lfdr.de>; Fri, 19 Sep 2025 10:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0F811BC7FF3
	for <lists+linux-iio@lfdr.de>; Fri, 19 Sep 2025 08:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEAD2EC561;
	Fri, 19 Sep 2025 08:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="e8ZRXd0g"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37AE2E7162;
	Fri, 19 Sep 2025 08:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758269984; cv=none; b=TFhS9pFJb9ctW4OFGOlcqKicYLn8UpWxVmvHESE3cj9J3E2AtJ0rwuUAxQkWCyMYb1hhb/rOIVUbXIG/Y3Nwg8bz2Fsu9FxwcUKaXSzJHHyIAj3EssY26FqYbfVuntcwdJGTERFV5TMUVIamfzSByHTnfBT4sg16YDJ/uIIEl2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758269984; c=relaxed/simple;
	bh=xm/ErcBYhYbmBboTTN6ZM5cxbTGS4S39+svDSeRK1vI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qxamGfEv/i4v2VOBtGmNBBlOpv294EttRHsMCkflY97k0XBFKyX8lOe0KOQ5A9dMbaVMhmIQlsn+VKWktID4ahJabsAHSdnX2CvuL5hOEq9qc4/5xCnDRqFrcCQsT5WzZdWB2bcSwaqk3T2/zs0UaLE7S34kADgRskUkmuAkyzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=e8ZRXd0g; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EF3D1430CE;
	Fri, 19 Sep 2025 08:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1758269972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y0xh7YMSH4C4tJj4Lo6jHL0M6rH8dEMNlQiMKss9trE=;
	b=e8ZRXd0g1FvDcSB11TdT6+sYS3HiNO4mKZprS7PNgQ4vgSeBOV/GU3cb7/jDK5/SmAE55z
	AP7VjLW2JJ0MK0OoReYsf2EP4iSrpKSNwRAt62X9KARu++aQ/fTlX5VRY37SRLKjlZZzxg
	AzVs4U5nwnCkXlDOMhQV8h7sAt6ebeOQnOXCIWktYZ/ANHhi+wbXcxLQGRmaJ1uNFHFpQS
	XhS5VPf+wSvGQ+k+YcvsExGNY3c4hrp6r4q0n+EeIXyffH670SbLatv1wzq9GgM9O/DUTp
	pZfaonmi/zSVtLb8f/bxpFlvSH4E1Gog81NBi6f3Sqg8GEY6oLO+q3hDSy9UFg==
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
Date: Fri, 19 Sep 2025 10:19:26 +0200
Message-ID: <2799517.mvXUDI8C0e@fw-rgant>
In-Reply-To: <aMxa5_LG3ADCjeHj@smile.fi.intel.com>
References:
 <20250916-ltm8054-driver-v1-0-fd4e781d33b9@bootlin.com>
 <12775482.O9o76ZdvQC@fw-rgant> <aMxa5_LG3ADCjeHj@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12745262.O9o76ZdvQC";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegkeejudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfgggtsehgtderredttdejnecuhfhrohhmpeftohhmrghinhcuifgrnhhtohhishcuoehrohhmrghinhdrghgrnhhtohhishessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfdvleekvefgieejtdduieehfeffjefhleegudeuhfelteduiedukedtieehlefgnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehffidqrhhgrghnthdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhomhgrihhnrdhgrghnthhoihhssegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedugedprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhgihhrugifohhougesghhmrghilhdrtghomhdprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhri
 ihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjihgtvdefsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegulhgvtghhnhgvrhessggrhihlihgsrhgvrdgtohhm
X-GND-Sasl: romain.gantois@bootlin.com

--nextPart12745262.O9o76ZdvQC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Date: Fri, 19 Sep 2025 10:19:26 +0200
Message-ID: <2799517.mvXUDI8C0e@fw-rgant>
In-Reply-To: <aMxa5_LG3ADCjeHj@smile.fi.intel.com>
MIME-Version: 1.0

On Thursday, 18 September 2025 21:17:59 CEST Andy Shevchenko wrote:
> On Thu, Sep 18, 2025 at 11:31:50AM +0200, Romain Gantois wrote:
> > On Tuesday, 16 September 2025 16:17:56 CEST Romain Gantois wrote:
> > > On Tuesday, 16 September 2025 15:12:37 CEST Andy Shevchenko wrote:
> > > > On Tue, Sep 16, 2025 at 12:24:08PM +0200, Romain Gantois wrote:
...
> > > > I think we have already something agnostic in regulator API to get a
> > > > regulator from a firmware node (rather than from specific OF/etc one).
> > > 
> > > IIRC the "of_match" regulator descriptor property can be used for this,
> > > I'll have a second look and see if I can use that instead.
> > 
> > Looks like I misread your comment sorry, the "of_match" property is pretty
> > much irrelevant to using fwnode_* wrappers, and I didn't find any of those
> > in the regulator subsystem. I'm missing a Kconfig dependency on "OF"
> > though, I'll have to add that.
> 
> Why do we need to add that dependency? Yes, probably it won't function,
> but then it will decrease test coverage at compile time.

Oh I didn't see it that way, in that case I'll just go the LTC3676 way and 
leave the OF dependency out.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPart12745262.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmjNEg4ACgkQKCYAIARz
eA63DhAAkmwgOOk+4SMBXxGJZ5sj3PTl8C3rqkn0Na5mAHAygKHjiJgI6tQMkQqg
hBzuzxz8HNlJPCv0DS9wAOuemR4o0NQjo+oI+/oNjpm2/ZZswj+slwKjGkD18/bO
SGAPYL84JvN6rXQzIv0YMKsyvBTrVAblrSBSkREV9vTfxhQ+82KmRjPgLK1sU1sp
6DuYKKID5h4zl4f4k7t61uiYGDmQeVMvpFo4wUSatEAI2Nc1Lxa1A+QBG4XC+1xV
t7hkX4oiEjp1LQkShz/ggQhdbBZm1Gsqv24tqD8o2Lie665gWasyT9bDiQEun5co
yrmWgKWDhJl2RU8fPEcaqtaO7EXyyUby/7OME48zjmcIHYj1G49QZEwkV1MVxygY
1qjZxxpSblSOgl9Ifi7NhVctyUIHlS14Uy1DmF5K2VZSWZ7be/O+KNbYDkmpSNFb
zgKmuXfI+X/OEDdmrUXKVhUF6cEucqvguomBnvJ4j99D9AsMD/9HJLmxeq1xo8UX
nEJcNUa1bQr5XHsUoV/e1T7Sg0sqkUBbBjH6GfVSswF+P0+8hjtQ+nuUl8FkqSo4
Ru/lm4b+AjqId4E2ohmohFPcgbiNR4FgepgOa/lHWUZnRyK/UWJI8v2+eFftwWrl
H+aX0WhgbJsGPuf4SiIf8KSqIIdYGPAUrktXxAxUgD3fPm9u/G4=
=RS2Y
-----END PGP SIGNATURE-----

--nextPart12745262.O9o76ZdvQC--




