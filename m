Return-Path: <linux-iio+bounces-24221-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB712B80F55
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 18:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ACC032217F
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 16:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD1A2FD1DB;
	Wed, 17 Sep 2025 16:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="j+C4XBNL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A144B2F99BD;
	Wed, 17 Sep 2025 16:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758125642; cv=none; b=SZq9Yl5HtTNg8ehIUaVUWrobP7YTTQHpBOquVnh6BRGooQvTnY1vYbZN6aUgx5vrzcp9UfWQW4FSGDh7uE63FrzXa+WGgUehV7u7KxZlK9wOwZkgH5hK2g5VKiWEYEbl+TPM4xnTmFYWqzCr3LivOtsLDdDDB1V2NKMQj/3kOTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758125642; c=relaxed/simple;
	bh=dZ4C35iruyQNbn469wZyDtWWanNafQVMjSIp3KQ/Ggc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b77HHNBnGrTBUfwegJiLhU66lOcGdVbjK2SwneUkJjq+2j7v2q2TS6J0gGH2cn3K90OGYvszJPNBLF4jkgCNpo8RxAdsw1tAcIv7Of2NgzI8vny9m2idiBG5cXyOF/k6aoAguZS3PufcLo7LC7rm22iDb5Ot76fluiUcu2h9Ksk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=j+C4XBNL; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id E99195822F9;
	Wed, 17 Sep 2025 15:46:13 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id F22804434C;
	Wed, 17 Sep 2025 15:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1758123966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ridci+3pZanjzKBje+PEIIesuCm7dyWPxeONcp0CpGs=;
	b=j+C4XBNLZyUmIr86DKte0VI/MvkxCk/IUKCXgiVuobITD8F8fYadOfhbV3Voe6K60xRAGX
	WOdOha6/kOoUhD4pEifx/AB11vt+1zjti7CZQpzK20gHBQ42M2u0qeXPquhohND4dau2zJ
	Vf/5kQIishCjM/ljrej578wByc83X/0YrIbS/rMu1oTpFsE9w4i/VjCOhFGE2Pan4//4xD
	0X1Hf28jBKNWhj5rTFj/4xc1ysCDoGXhGeFVc45JIAxLaNC9pC7Crdo7Qp55byla9ADSYa
	To740E0+NLD2PBleaVbIEPyStSU+WLOmNgZEbcgQExQwS9SuWXBO4X+iDGWGUw==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: add processed write API
Date: Wed, 17 Sep 2025 17:46:00 +0200
Message-ID: <2893324.mvXUDI8C0e@fw-rgant>
In-Reply-To: <decdb75c-b61e-4e0f-bddd-cfc8986f3b6f@baylibre.com>
References:
 <20250916-ltm8054-driver-v1-0-fd4e781d33b9@bootlin.com>
 <20250916-ltm8054-driver-v1-2-fd4e781d33b9@bootlin.com>
 <decdb75c-b61e-4e0f-bddd-cfc8986f3b6f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12838243.O9o76ZdvQC";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegfeekgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfgggtsehgtderredttdejnecuhfhrohhmpeftohhmrghinhcuifgrnhhtohhishcuoehrohhmrghinhdrghgrnhhtohhishessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepteevieelgeekteevgfdtgeffvdeigfdvveekhffgteeiffdvvdekudejfedvgfdtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepfhifqdhrghgrnhhtrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrohhmrghinhdrghgrnhhtohhishessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudefpdhrtghpthhtoheplhhgihhrugifohhougesghhmrghilhdrtghomhdprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohept
 ghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjihgtvdefsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnuhhnohdrshgrsegrnhgrlhhoghdrtghomhdprhgtphhtthhopegrnhguhieskhgvrhhnvghlrdhorhhg
X-GND-Sasl: romain.gantois@bootlin.com

--nextPart12838243.O9o76ZdvQC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
Subject: Re: [PATCH 2/4] iio: add processed write API
Date: Wed, 17 Sep 2025 17:46:00 +0200
Message-ID: <2893324.mvXUDI8C0e@fw-rgant>
In-Reply-To: <decdb75c-b61e-4e0f-bddd-cfc8986f3b6f@baylibre.com>
MIME-Version: 1.0

Hello David,

On Tuesday, 16 September 2025 21:23:04 CEST David Lechner wrote:
> On 9/16/25 5:24 AM, Romain Gantois wrote:
> > Add a function to allow IIO consumers to write a processed value to a
...
> > +		case IIO_VAL_FRACTIONAL:
> > +			tmp_num = (s64)processed * (s64)scale_val2;
> > +			tmp_den = scale_val;
> > +			break;
> > +		case IIO_VAL_FRACTIONAL_LOG2:
> > +			tmp_num = (s64)processed << scale_val2;
> > +			tmp_den = scale_val;
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +
> > +		tmp_den *= scale;
> > +
> > +		*raw = div64_s64(tmp_num, tmp_den);
> > +	}
> 
> It can be quite tricky to get all of these combinations right. I would
> prefer if added some unit tests like we did in [1].
> 
> [1]:
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=tes
> ting&id=c732e60ee10ed0611a59513cbf9c8d35fbe7cf65

Agreed, that would be nice, I'll look into it.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPart12838243.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmjK17gACgkQKCYAIARz
eA5qwg/8CGvK7nUAKsA4+5nhVKamKMPMwjoQ3hNFMgn84LjQHTFOmAGZ/mYudC2V
UAbeMpoN0e7pcnQkXZS8NHOTymfsv7aCd5aqi76zi4RCJ5+AvNIxGMaYf+QgOjZ+
F3Jt5BuhRgnDimOc3d8qQaBkSS3BX4ImU0F0zd4oLGF6tqUMFmeXCEAM+A+B60aO
BOL5RNtPyfq1U8/aO+gts1Vf3OHZ4msFjEwWeMDFdpUPH7NA3Zw8aRss2GdmPhcc
OnhqSh/CJUgpciCCF85Wi6rc2nlTpIIcTUIh7xcBFRtlez7GElalQKuvhDy1GE21
njBvMTNT5gEVZjZiEbUhBa1eQ+ElXHKwgriCjRsYCbhTsjrWMLv/L1nTs/zH7E5B
4OQFL8lqhntwRLwppwQnUZKWR+sARcZnWRjhFgjh3cNj4/hNkTzQXHZr8HYAygM9
WW5wkLugK8q3anqb1SrGyOs4JvkIHTzJx4gnsU/DpOxNpGxwxUofPLGplAPFfZqn
Q68EF5gNNykr5MLV/r9fTNXlWG1dSNfHcSJH9XhpUT2Kmok6sbCmhUOjCQVblbeN
yKi+2wrAvFEc1UbYBv2zhJMBTR7OfwwSvHPacFRSInpxE2f7sKg0rcJnQH9PrtSW
tr4xDMIHZXG8bLD75UE/1ASL1deX10iUN6X5s0gjgC+8bPzjXQo=
=I+94
-----END PGP SIGNATURE-----

--nextPart12838243.O9o76ZdvQC--




