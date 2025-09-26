Return-Path: <linux-iio+bounces-24462-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA79CBA4CEF
	for <lists+linux-iio@lfdr.de>; Fri, 26 Sep 2025 20:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FC26387CBE
	for <lists+linux-iio@lfdr.de>; Fri, 26 Sep 2025 18:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64C230C61E;
	Fri, 26 Sep 2025 18:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="U17rVZVO"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884A52798ED;
	Fri, 26 Sep 2025 18:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758909739; cv=none; b=KfGy9t2kWmh82b5yHWd2M3kdCXV2jvAmmh/kUzjdqlvBrvpls3IICCpzLkt1cWliV7rS2l+s5TS1sQ8BWfTKw5KPglm2TpLwQUY0VZc6A3evQCRM/s6tOQRoACxq3sA560sjWEcvi+ia0XpHZM07eXZ1v0+WF3wj/7hm0bC6SBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758909739; c=relaxed/simple;
	bh=zfGNKVpK3YCHVTtG0N5d6/84sLpoT92C6WcROFmqZus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WU2Y8oZjqiyQx/j2vxAKcZJmDcbpoH4eOd7arnVQ5t0CTa0FsUO/pb/y8Xhr24tzxlt5idP8L+drg2YaHczQzTvOUBNiLFT1MoLH+P8LjZ38nWFxj77hPZiAP1XxAn1q/Ir3z8T19bADeft2kjffdgtAGGbQOjaVyB1plvfgSHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=U17rVZVO; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CF8E7442EF;
	Fri, 26 Sep 2025 18:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1758909732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f1iClMCSUbu1VdiuAP48MXWihn5/YOy3xJHSlLVRB3Q=;
	b=U17rVZVOmPOMZsVuwIuivMoJRJLAgYJQnZxPmwKqLnMig3i7WiAGu23IxaLP61EMaX7ra9
	iGTpdzFGTGpWYwT/ElI5hAsVBNuCHcACq6WepZPxA3l+Jo9LtmbRQBNHEHWgcY8q26bzAb
	nhbi6Ud2PtN0wmo4HgKM3+ebhDLazL51kjT8WQZJw3Uaqkbgx3KHxOZoZNxhS6K9Gga+2v
	bzN1ThaW/v3jpO1bFJrSCr2O+KHiQOO6xlMUa1DasgoRoEIcldCGFnl33OwSEzJehQ8ZRg
	eJNCxSBc/9UNQD5DzVnSrrvuPPNhvQ0UdoBnG5smoKHMDvO4TSmiIk37wwTlPQ==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Conor Dooley <conor@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Hans de Goede <hansg@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject:
 Re: [PATCH v2 1/5] regulator: dt-bindings: Add Linear Technology LTM8054
 regulator
Date: Fri, 26 Sep 2025 17:59:48 +0200
Message-ID: <5331035.LvFx2qVVIh@fw-rgant>
In-Reply-To: <20250925-pushchair-charity-9ccee20d8a6e@spud>
References:
 <20250925-ltm8054-driver-v2-0-bb61a401a0dc@bootlin.com>
 <20250925-ltm8054-driver-v2-1-bb61a401a0dc@bootlin.com>
 <20250925-pushchair-charity-9ccee20d8a6e@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3033215.ElGaqSPkdT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejtddtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfgggtsehgtderredttdejnecuhfhrohhmpeftohhmrghinhcuifgrnhhtohhishcuoehrohhmrghinhdrghgrnhhtohhishessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfdvleekvefgieejtdduieehfeffjefhleegudeuhfelteduiedukedtieehlefgnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeefjedrieeirddvudekrdefleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeefjedrieeirddvudekrdefledphhgvlhhopehffidqrhhgrghnthdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhomhgrihhnrdhgrghnthhoihhssegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduhedprhgtphhtthhopegtohhnohhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlghhirhgufihoohgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdro
 hhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhitgdvfeeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughlvggthhhnvghrsegsrgihlhhisghrvgdrtghomh
X-GND-Sasl: romain.gantois@bootlin.com

--nextPart3033215.ElGaqSPkdT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
To: Conor Dooley <conor@kernel.org>
Date: Fri, 26 Sep 2025 17:59:48 +0200
Message-ID: <5331035.LvFx2qVVIh@fw-rgant>
In-Reply-To: <20250925-pushchair-charity-9ccee20d8a6e@spud>
MIME-Version: 1.0

Hello Conor,

On Thursday, 25 September 2025 21:27:06 CEST Conor Dooley wrote:
> On Thu, Sep 25, 2025 at 02:37:33PM +0200, Romain Gantois wrote:
...
> > +properties:
> > +  compatible:
> > +    const: adi,ltm8054
> > +
> > +  enable-gpios:
> > +    description: GPIO connected to the RUN pin.
> > +    maxItems: 1
> > +
> 
> > +  lltc,fb-voltage-divider:
> Why does this property have a ?linear? vendor prefix?
> Shouldn't it be adi to match the other property and compatible?

This component was originally from Linear Technology, before it was acquired 
by Analog Devices. The new properties and compatibles have the Analog Devices 
prefix, but the "fb-voltage-divider" property is already used by the LTC3676 
and LTC3589 regulators, so I left the Linear Technology prefix for this one to 
avoid introducing a new property just to specify a vendor prefix change.

I don't have a strong opinion about this though.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPart3033215.ElGaqSPkdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmjWuHQACgkQKCYAIARz
eA7OwA/9G4mPIwIfP7ydE9Jl22NjgLTptl9DeV9HdoZFinDU6e+W0GZs6XtQlK45
8uU2I+hywAEzy/Ii49eI9ly2nhjWEgS59kldlThzNAEJeCZ/8zJPDj2DQuetYI+b
LZdAnl3Gv+LNPCPpfR1YMUfZgzIkAIrWbd6KtrT+K/Vgc+2YgzqDttPZtqyvmrT8
4OU5Nd6ZYpJPkUbl7TfOkGXbHcQHpD2I+O51JiBLtzHuV08Hod9jn2B1UaY1rZaD
g5j5Mfo4lbRhX1FIl0jpbb91Fnl0tbA+N4r8GIpgST90kePgkRC3dTI6oTTQQs1p
XPJsk8QYmMB5Qmk2VGnIauoOidEmVe2E43jVLDbBG/2KXuMK2OI3aq4TfAgV4KQa
F7seEP0XsV3zJYNnJmFKvT7cEhDGS8Fy4gVrHllzx1lEItf9d0h0Jw9GhUcf7xhQ
pOPZKJe5Pp0gy556akG7jNjVcOll+p+5Aiv1tGDW7oOVT7iog1AuywjgOPfaYh5N
HJ07jrRQ2XIon9HqsPRWp9WNOaWbsQ+uNLHArmWeNr4ESa0PiFHoWNPh3rIjxGN2
SB74FhA8QVRSvDneiW5ChAfQa5LreeKVf50EhfhBO/nzDO6oUKHG4CYCJ75QX6i5
pofx68yTCsyrw25wN5Qn3fK0alI64AiLeV3TRfJtrVv2+IHMnLk=
=yiZG
-----END PGP SIGNATURE-----

--nextPart3033215.ElGaqSPkdT--




